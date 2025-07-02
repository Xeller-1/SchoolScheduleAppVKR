using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace SchoolScheduleApp
{
    public class ScheduleGenerator
    {
        private readonly int groupId;
        private readonly SchoolScheduleEntities _context;

        public ScheduleGenerator(int groupId, SchoolScheduleEntities context)
        {
            this.groupId = groupId;
            this._context = context;
        }

        public async Task GenerateAsync()
        {
            var calls = await _context.Calls.OrderBy(c => c.DayOfWeek).ThenBy(c => c.StartTime).ToListAsync();
            var group = await _context.Groups.FirstOrDefaultAsync(g => g.GroupID == groupId);

            if (group == null) return;

            int classYear = group.Year;
            var daysOfWeek = calls.Select(c => c.DayOfWeek).Distinct().ToList();
            int maxLessonsPerDay = 6;
            int complexityLimitPerDay = 30;
            var random = new Random();

            // Загружаем учебный план этой группы
            var curriculum = await _context.Curriculum
                .Where(c => c.GroupID == groupId)
                .ToListAsync();

            // Загружаем только тех учителей, чьи предметы есть в учебном плане
            var subjectIds = curriculum.Select(c => c.SubjectID).Distinct().ToList();
            var teachers = await _context.Teachers
                .Where(t => subjectIds.Contains(t.SubjectID))
                .ToListAsync();

            // Удаление старого расписания
            var oldSchedule = await _context.Schedule.Where(s => s.GroupID == groupId).ToListAsync();
            _context.Schedule.RemoveRange(oldSchedule);
            await _context.SaveChangesAsync();

            foreach (var day in daysOfWeek)
            {
                var callsToday = calls
                    .Where(c => c.DayOfWeek == day)
                    .OrderBy(c => c.StartTime)
                    .Take(maxLessonsPerDay)
                    .ToList();

                int remainingComplexity = complexityLimitPerDay;
                var usedSubjectsToday = new Dictionary<int, int>();
                int? lastUsedSubject = null;

                foreach (var call in callsToday)
                {
                    var candidates = teachers
                        .Where(t =>
                        {
                            var curr = curriculum.FirstOrDefault(c => c.SubjectID == t.SubjectID);
                            return curr != null &&
                                curr.Hours > 0 &&
                                curr.Complexity <= remainingComplexity &&
                                (!usedSubjectsToday.ContainsKey(t.SubjectID) || usedSubjectsToday[t.SubjectID] < 2) &&
                                t.SubjectID != lastUsedSubject;
                        })
                        .ToList();

                    if (!candidates.Any())
                    {
                        candidates = teachers
                            .Where(t =>
                            {
                                var curr = curriculum.FirstOrDefault(c => c.SubjectID == t.SubjectID);
                                return curr != null && curr.Hours > 0 && curr.Complexity <= remainingComplexity;
                            })
                            .ToList();
                    }

                    if (!candidates.Any()) continue;

                    var selectedTeacher = candidates[random.Next(candidates.Count)];
                    var curriculumEntry = curriculum.First(c => c.SubjectID == selectedTeacher.SubjectID);

                    var room = await GetAvailableRoomAsync(day, call.StartTime, call.EndTime);
                    if (room == null) continue;

                    _context.Schedule.Add(new Schedule
                    {
                        GroupID = groupId,
                        TeacherID = selectedTeacher.TeacherID,
                        SubjectID = selectedTeacher.SubjectID,
                        RoomID = room.RoomID,
                        StartTime = call.StartTime,
                        EndTime = call.EndTime,
                        CallID = call.CallID
                    });

                    curriculumEntry.Hours--;
                    remainingComplexity -= curriculumEntry.Complexity;

                    if (!usedSubjectsToday.ContainsKey(selectedTeacher.SubjectID))
                        usedSubjectsToday[selectedTeacher.SubjectID] = 0;
                    usedSubjectsToday[selectedTeacher.SubjectID]++;

                    lastUsedSubject = selectedTeacher.SubjectID;
                }

                await _context.SaveChangesAsync();
            }
        }

        private async Task<Rooms> GetAvailableRoomAsync(string day, TimeSpan start, TimeSpan end)
        {
            var busyRoomIds = await _context.Schedule
                .Where(s =>
                    s.StartTime < end &&
                    s.EndTime > start &&
                    s.Calls.DayOfWeek == day) // учитываем только нужный день
                .Select(s => s.RoomID)
                .ToListAsync();

            return await _context.Rooms
                .Where(r => !busyRoomIds.Contains(r.RoomID))
                .OrderBy(r => Guid.NewGuid()) // случайный выбор свободной аудитории
                .FirstOrDefaultAsync();
        }
    }
}
