
using iTextSharp.text.pdf;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Collections;
using System.ComponentModel;
using System.Windows.Data;
using System.Data;



namespace SchoolScheduleApp
{
    public partial class MainWindow : Window
    {
        private readonly SchoolScheduleEntities _dbContext = new SchoolScheduleEntities();
        private int? _selectedClassId;

        public MainWindow()
        {
            
            InitializeComponent();
            LoadAllData();
        }




        private void LoadAllData()
        {
            LoadTeachers();
            LoadRooms();
            LoadGroups();
            LoadSubjects();
            LoadCalls();
            LoadSchedule();
        }




        private void LoadTeachers()
        {
            try
            {
                var teachers = _dbContext.Teachers
                    .Include(t => t.Schedule)
                    .Include(s => s.Subjects)
                    .AsNoTracking()
                    .ToList();

                var teacherData = teachers.Select(t => new
                {
                    t.TeacherID,
                    t.FullName,
                    Subjects = t.Schedule?.Any() == true
                        ? string.Join(", ", t.Schedule
                            .Where(s => s.Subjects != null)
                            .Select(s => s.Subjects.Name)
                            .Distinct())
                        : "Нет предметов"
                }).ToList();

                TeachersGrid.ItemsSource = teacherData;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки: {ex.Message}");
                TeachersGrid.ItemsSource = new List<dynamic> { new { FullName = "Ошибка загрузки", Subjects = "" } };
            }
        }

        private void LoadRooms()
        {
            RoomsGrid.ItemsSource = _dbContext.Rooms.ToList();
        }

        private void LoadGroups()
        {
            // Загружаем список классов
            var groups = _dbContext.Groups.ToList();

            // Добавляем фиктивный элемент "Все" в начало списка
            groups.Insert(0, new Groups
            {
                GroupID = -1,
                Name = "Все"
            });

            // Привязываем данные
            GroupsGrid.ItemsSource = groups;
            ClassComboBox.ItemsSource = groups;
            GroupsComboBox.ItemsSource = groups;

            // Исправляем SelectedValuePath (должно соответствовать свойству в классе Groups)
            ClassComboBox.SelectedValuePath = "GroupID"; 
            GroupsComboBox.SelectedValuePath = "GroupID"; 

            // Устанавливаем "Все" как выбранный элемент по умолчанию
            ClassComboBox.SelectedIndex = 0;
            GroupsComboBox.SelectedIndex = 1; // Добавьте эту строку
        }

        private void LoadSubjects()
        {
            if (_selectedClassId.HasValue && _selectedClassId.Value != -1)
            {
                var subjectsForGroup = _dbContext.Curriculum
                    .Include(c => c.Subjects)
                    .Where(c => c.GroupID == _selectedClassId.Value)
                    .Select(c => new
                    {
                        c.Subjects.SubjectID,
                        c.Subjects.Name,
                        c.Hours,
                        c.Complexity
                    })
                    .ToList();

                SubjectsGrid.ItemsSource = subjectsForGroup;
            }
            else
            {
                // Если выбраны "Все", показываем все предметы без фильтра
                SubjectsGrid.ItemsSource = _dbContext.Subjects.ToList();
            }
        }

        private void LoadCalls()
        {
            CallsGrid.ItemsSource = _dbContext.Calls.ToList();
        }

        private void LoadSchedule()
        {
            IQueryable<Schedule> query = _dbContext.Schedule
       .Include(s => s.Groups)
       .Include(s => s.Calls)
       .Include(s => s.Subjects)
       .Include(s => s.Teachers)
       .Include(s => s.Rooms);

            if (_selectedClassId.HasValue && _selectedClassId.Value != -1)
            {
                query = query.Where(s => s.GroupID == _selectedClassId.Value);

                // Фильтрация по Curriculum (дополнительно, если важно)
                var subjectIds = _dbContext.Curriculum
                    .Where(c => c.GroupID == _selectedClassId.Value)
                    .Select(c => c.SubjectID)
                    .ToList();

                query = query.Where(s => subjectIds.Contains(s.SubjectID));
            }

            var scheduleData = query.ToList();


            // Порядок дней недели
            var dayOrder = new Dictionary<string, int>
    {
        {"Понедельник", 1}, {"Вторник", 2}, {"Среда", 3},
        {"Четверг", 4}, {"Пятница", 5}, {"Суббота", 6}, {"Воскресенье", 7}
    };

            var groupedView = new ListCollectionView(scheduleData);

            // Настройка группировки в зависимости от выбора
            if (_selectedClassId.HasValue && _selectedClassId.Value == -1)
            {
                // Режим "Все" - группировка по классам и дням
                groupedView.GroupDescriptions.Add(new PropertyGroupDescription("Groups.Name"));
                groupedView.GroupDescriptions.Add(new PropertyGroupDescription("Calls.DayOfWeek"));

                groupedView.SortDescriptions.Add(new SortDescription("Groups.Name", ListSortDirection.Ascending));
            }
            else
            {
                // Режим одного класса - группировка только по дням
                groupedView.GroupDescriptions.Add(new PropertyGroupDescription("Calls.DayOfWeek"));
            }

            // Общая сортировка
            groupedView.SortDescriptions.Add(new SortDescription("Calls.DayOfWeek", ListSortDirection.Ascending));
            groupedView.SortDescriptions.Add(new SortDescription("StartTime", ListSortDirection.Ascending));

            // Кастомная сортировка
            groupedView.CustomSort = new DayOfWeekComparer(dayOrder);

            ScheduleGrid.ItemsSource = groupedView;
        }




        // Кастомный компаратор для сортировки дней
        public class DayOfWeekComparer : IComparer
        {
            private readonly Dictionary<string, int> _dayOrder;

            public DayOfWeekComparer(Dictionary<string, int> dayOrder)
            {
                _dayOrder = dayOrder;
            }

            public int Compare(object x, object y)
            {
                var dayX = ((Schedule)x).Calls.DayOfWeek;
                var dayY = ((Schedule)y).Calls.DayOfWeek;
                return _dayOrder[dayX].CompareTo(_dayOrder[dayY]);
            }
        }

        //обновление
        //private async void RefreshTeachers()
        //{
        //    using (var context = new SchoolScheduleEntities())
        //    {
        //        var teachers = await context.Teachers.ToListAsync();
        //        TeachersGrid.ItemsSource = teachers;
                
        //    }
        //}

        private async void RefreshRooms()
        {
            using (var context = new SchoolScheduleEntities())
            {
                var rooms = await context.Rooms.ToListAsync();
                RoomsGrid.ItemsSource = rooms;
            }
        }

        private async void RefreshGroups()
        {
            using (var context = new SchoolScheduleEntities())
            {
                var groups = await context.Groups.ToListAsync();
                GroupsGrid.ItemsSource = groups;
            }
        }

        private async void RefreshSubjects()
        {
            using (var context = new SchoolScheduleEntities())
            {
                var subjects = await context.Subjects.ToListAsync();
                SubjectsGrid.ItemsSource = subjects;
                
            }
        }

        
        



        private void RefreshAll()
        {
            //RefreshTeachers();
            RefreshGroups();
            RefreshRooms();
            RefreshSubjects();
            

        }





        // Преподаватели
        private void AddTeacher_Click(object sender, RoutedEventArgs e)
        {
            var window = new AddTeacherWindow();
            if (window.ShowDialog() == true)
                LoadTeachers();
            RefreshAll();
            LoadSchedule();
        }

        private void EditTeacher_Click(object sender, RoutedEventArgs e)
        {
            // 1. Получаем выбранный элемент безопасным способом
            if (TeachersGrid.SelectedItem == null)
            {
                MessageBox.Show("Выберите преподавателя для редактирования.");
                return;
            }

            // 2. Определяем реальный тип элемента
            int teacherId;
            object selectedItem = TeachersGrid.SelectedItem;

            // Вариант A: Если привязаны объекты Teachers
            if (selectedItem is Teachers teacher)
            {
                teacherId = teacher.TeacherID;
            }
            // Вариант B: Если привязан анонимный тип (например, через .Select())
            else if (selectedItem.GetType().GetProperty("TeacherID") != null)
            {
                try
                {
                    teacherId = (int)selectedItem.GetType().GetProperty("TeacherID").GetValue(selectedItem);
                }
                catch
                {
                    MessageBox.Show("Ошибка при получении ID преподавателя");
                    return;
                }
            }
            // Вариант C: Если привязан DataRowView (при работе с DataTable)
            else if (selectedItem is DataRowView row)
            {
                teacherId = Convert.ToInt32(row["TeacherID"]);
            }
            else
            {
                MessageBox.Show("Неизвестный формат данных преподавателя");
                return;
            }

            // 3. Загружаем полные данные преподавателя (EF6 style)
            var teacherWithSubjects = _dbContext.Teachers
                .Include("Schedule.Subjects")
                .FirstOrDefault(t => t.TeacherID == teacherId);

            if (teacherWithSubjects == null)
            {
                MessageBox.Show("Преподаватель не найден в базе данных.");
                return;
            }

            // 4. Формируем список предметов
            var teacherSubjects = teacherWithSubjects.Schedule?
                .Where(s => s.Subjects != null)
                .Select(s => s.Subjects)
                .Distinct()
                .ToList() ?? new List<Subjects>();

            // 5. Открываем окно редактирования
            var window = new EditTeacherWindow(teacherWithSubjects, teacherSubjects);

            if (window.ShowDialog() == true)
            {
                try
                {
                    _dbContext.SaveChanges();
                    LoadTeachers();
                    LoadSchedule();
                    MessageBox.Show("Изменения сохранены успешно!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка сохранения: {ex.Message}");
                }
            }
        }


        private void DeleteTeacher_Click(object sender, RoutedEventArgs e)
        {
            var selectedTeacher = TeachersGrid.SelectedItem as dynamic;
            if (selectedTeacher == null)
            {
                MessageBox.Show("Выберите преподавателя для удаления.");
                return;
            }

            int teacherId;
            try
            {
                teacherId = (int)selectedTeacher.GetType().GetProperty("TeacherID").GetValue(selectedTeacher);
            }
            catch
            {
                MessageBox.Show("Ошибка при получении данных преподавателя.");
                return;
            }

            try
            {
                // Удаляем вручную записи из Teacher_Subjects
                _dbContext.Database.ExecuteSqlCommand("DELETE FROM Teacher_Subjects WHERE TeacherID = {0}", teacherId);

                // Удаляем связанные записи в Schedule
                var scheduleToDelete = _dbContext.Schedule.Where(s => s.TeacherID == teacherId).ToList();
                if (scheduleToDelete.Any())
                    _dbContext.Schedule.RemoveRange(scheduleToDelete);

                // Удаляем преподавателя
                var teacherToDelete = _dbContext.Teachers.FirstOrDefault(t => t.TeacherID == teacherId);
                if (teacherToDelete != null)
                    _dbContext.Teachers.Remove(teacherToDelete);

                _dbContext.SaveChanges();

                MessageBox.Show("Преподаватель успешно удалён.");
                LoadTeachers();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при удалении: {ex.InnerException?.Message ?? ex.Message}");
            }
        }

        // Аудитории
        private void AddRoom_Click(object sender, RoutedEventArgs e)
        {
            var window = new AddRoomWindow();
            if (window.ShowDialog() == true)
                LoadRooms();
            RefreshAll();
        }

        private void EditRoom_Click(object sender, RoutedEventArgs e)
        {
            var selectedRoom = RoomsGrid.SelectedItem as Rooms;
            if (selectedRoom == null)
            {
                MessageBox.Show("Выберите аудиторию для редактирования.");
                return;
            }

            // Если конструктор EditRoomWindow принимает ID (int)
            var window = new EditRoomWindow(selectedRoom.RoomID);
            if (window.ShowDialog() == true)
                LoadRooms();
            RefreshAll();
        }

        private void DeleteRoom_Click(object sender, RoutedEventArgs e)
        {
            var selectedRoom = RoomsGrid.SelectedItem as Rooms;
            if (selectedRoom == null)
            {
                MessageBox.Show("Выберите аудиторию для удаления.");
                return;
            }

            _dbContext.Rooms.Remove(selectedRoom);
            _dbContext.SaveChanges();
            LoadRooms();
        }

        // Группы
        private void AddGroup_Click(object sender, RoutedEventArgs e)
        {
            var window = new AddGroupWindow();
            if (window.ShowDialog() == true)
                LoadGroups();
            RefreshAll();
        }

        private void EditGroup_Click(object sender, RoutedEventArgs e)
        {
            var selectedGroup = GroupsGrid.SelectedItem as Groups;
            if (selectedGroup == null)
            {
                MessageBox.Show("Выберите группу для редактирования.");
                return;
            }

            var window = new EditGroupWindow(selectedGroup.GroupID);
            if (window.ShowDialog() == true)
                LoadGroups();
            RefreshAll();
        }

        private void DeleteGroup_Click(object sender, RoutedEventArgs e)
        {
            var selectedGroup = GroupsGrid.SelectedItem as Groups;
            if (selectedGroup == null)
            {
                MessageBox.Show("Выберите группу для удаления.");
                return;
            }

            _dbContext.Groups.Remove(selectedGroup);
            _dbContext.SaveChanges();
            LoadGroups();
        }

        // Предметы
        private void AddSubject_Click(object sender, RoutedEventArgs e)
        {
            var window = new AddSubjectWindow();
            if (window.ShowDialog() == true)
                LoadSubjects();
            RefreshAll();
        }

        private void EditSubject_Click(object sender, RoutedEventArgs e)
        {
            var selectedSubject = SubjectsGrid.SelectedItem as Subjects;
            if (selectedSubject == null)
            {
                MessageBox.Show("Выберите предмет для редактирования.");
                return;
            }

            var window = new EditSubjectWindow(selectedSubject.SubjectID);
            if (window.ShowDialog() == true)
                LoadSubjects();
            RefreshAll();
        }

        private void DeleteSubject_Click(object sender, RoutedEventArgs e)
        {
            var selectedSubject = SubjectsGrid.SelectedItem as Subjects;
            if (selectedSubject == null) return;

            // Проверяем, есть ли преподаватели, ведущие этот предмет
            var teachersWithSubject = _dbContext.Schedule
                .Where(s => s.SubjectID == selectedSubject.SubjectID)
                .Select(s => s.Teachers.FullName)
                .Distinct()
                .ToList();

            if (teachersWithSubject.Any())
            {
                MessageBox.Show($"Нельзя удалить предмет, так как его ведут преподаватели:\n{string.Join("\n", teachersWithSubject)}",
                              "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            _dbContext.Subjects.Remove(selectedSubject);
            _dbContext.SaveChanges();
            LoadSubjects();
            LoadTeachers(); // Обновляем список преподавателей
        }

        // Звонки
        private void AddCalls_Click(object sender, RoutedEventArgs e)
        {
            var window = new AddCallsWindow();
            if (window.ShowDialog() == true)
                LoadCalls();
            RefreshAll();
        }

        private void EditCalls_Click(object sender, RoutedEventArgs e)
        {
            var selectedCall = CallsGrid.SelectedItem as Calls;
            if (selectedCall == null)
            {
                MessageBox.Show("Выберите звонок для редактирования.");
                return;
                
            }

            var window = new EditCallsWindow(selectedCall.CallID);
            if (window.ShowDialog() == true)
                LoadCalls();
        }

        private void DeleteCalls_Click(object sender, RoutedEventArgs e)
        {
            var selectedCall = CallsGrid.SelectedItem as Calls;
            if (selectedCall == null)
            {
                MessageBox.Show("Выберите звонок для удаления.");
                return;
            }

            var result = MessageBox.Show("Вы уверены, что хотите удалить этот звонок?", "Подтверждение удаления", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                _dbContext.Calls.Remove(selectedCall);
                _dbContext.SaveChanges();
                LoadCalls();
            }
        }
        private void GroupsComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedClass = GroupsComboBox.SelectedItem as Groups;
            _selectedClassId = selectedClass?.GroupID == -1 ? null : selectedClass?.GroupID;
            LoadSubjects(); // или другая логика для вкладки предметов
        }

        private void ClassComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedClass = ClassComboBox.SelectedItem as Groups;

            // Если выбран элемент "Все" (GroupID = -1) или снят выбор
            _selectedClassId = selectedClass?.GroupID == -1 ? null : selectedClass?.GroupID;


            LoadSchedule(); // Всегда обновляем расписание
        }

        // Расписание




        private async void GenerateSchedule_Click(object sender, RoutedEventArgs e)
        {
            if (_selectedClassId.HasValue)
            {
                // Создаём экземпляр ScheduleGenerator
                using (var context = new SchoolScheduleEntities())
                {
                    var generator = new ScheduleGenerator(_selectedClassId.Value, context);
                    await generator.GenerateAsync(); // Вызываем асинхронный метод
                }

                LoadSchedule();
                MessageBox.Show("Расписание успешно сгенерировано.");
            }
            else
            {
                MessageBox.Show("Выберите класс для генерации расписания.");
            }
        }

        private void EditSchedule_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show($"Находится в стадии сна:\n");
        }


        private void ExportScheduleToPdf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var selectedClass = ClassComboBox.SelectedItem as Groups;
                bool exportAll = selectedClass?.GroupID == -1;

                List<Groups> classesToExport = new List<Groups>();
                List<Schedule> scheduleData;

                if (exportAll)
                {
                    classesToExport = _dbContext.Groups.ToList();
                    scheduleData = _dbContext.Schedule
                        .Include(s => s.Groups)
                        .Include(s => s.Calls)
                        .Include(s => s.Subjects)
                        .Include(s => s.Rooms)
                        .ToList();
                }
                else
                {
                    if (selectedClass == null)
                    {
                        MessageBox.Show("Выберите класс для экспорта.");
                        return;
                    }
                    classesToExport.Add(selectedClass);
                    scheduleData = _dbContext.Schedule
                        .Where(s => s.GroupID == selectedClass.GroupID)
                        .Include(s => s.Calls)
                        .Include(s => s.Subjects)
                        .Include(s => s.Rooms)
                        .ToList();
                }

                var dayOrder = new Dictionary<string, int>
        {
            { "Понедельник", 1 }, { "Вторник", 2 }, { "Среда", 3 },
            { "Четверг", 4 }, { "Пятница", 5 }, { "Суббота", 6 }, { "Воскресенье", 7 }
        };

                var groupedByDay = scheduleData
                    .Where(s => s.Calls != null)
                    .GroupBy(s => s.Calls.DayOfWeek)
                    .OrderBy(g => dayOrder.TryGetValue(g.Key, out int order) ? order : int.MaxValue)
                    .ToList();

                string fileName = exportAll ? "Все_классы" : selectedClass.Name;
                string filePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), $"{fileName}_Schedule.pdf");

                string fontPath = Environment.GetFolderPath(Environment.SpecialFolder.Fonts) + "\\arial.ttf";
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                Font titleFont = new Font(baseFont, 16, Font.BOLD);
                Font headerFont = new Font(baseFont, 12, Font.BOLD);
                Font cellFont = new Font(baseFont, 10, Font.NORMAL);

                using (var fs = new FileStream(filePath, FileMode.Create))
                using (var doc = new Document(PageSize.A4.Rotate(), 15, 15, 15, 15))
                using (var writer = PdfWriter.GetInstance(doc, fs))
                {
                    doc.Open();

                    doc.Add(new Paragraph($"Расписание уроков {(exportAll ? "всех классов" : $"класса {selectedClass.Name}")}", titleFont));
                    doc.Add(new Paragraph($"Дата создания: {DateTime.Now:dd.MM.yyyy}", new Font(baseFont, 10)));
                    doc.Add(Chunk.NEWLINE);

                    foreach (var dayGroup in groupedByDay)
                    {
                        PdfPTable dayTable = new PdfPTable(classesToExport.Count + 1) { WidthPercentage = 100 };
                        dayTable.SetWidths(Enumerable.Repeat(2f, classesToExport.Count + 1).ToArray());

                        // Заголовок дня
                        var dayHeaderCell = new PdfPCell(new Phrase(dayGroup.Key, headerFont))
                        {
                            Colspan = classesToExport.Count + 1,
                            Border = Rectangle.BOX,
                            BorderWidth = 0.8f,
                            Padding = 6f,
                            HorizontalAlignment = Element.ALIGN_CENTER,
                            VerticalAlignment = Element.ALIGN_MIDDLE,
                            BackgroundColor = BaseColor.LIGHT_GRAY
                        };
                        dayTable.AddCell(dayHeaderCell);

                        // Заголовки классов
                        var timeHeader = new PdfPCell(new Phrase("Время", headerFont))
                        {
                            Border = Rectangle.BOX,
                            BorderWidth = 0.5f,
                            Padding = 5f,
                            HorizontalAlignment = Element.ALIGN_CENTER,
                            VerticalAlignment = Element.ALIGN_MIDDLE
                        };
                        dayTable.AddCell(timeHeader);

                        foreach (var cls in classesToExport)
                        {
                            var classCell = new PdfPCell(new Phrase(cls.Name, headerFont))
                            {
                                Border = Rectangle.BOX,
                                BorderWidth = 0.5f,
                                Padding = 5f,
                                HorizontalAlignment = Element.ALIGN_CENTER,
                                VerticalAlignment = Element.ALIGN_MIDDLE
                            };
                            dayTable.AddCell(classCell);
                        }

                        // Уроки по времени
                        var timeSlots = dayGroup
                            .OrderBy(s => s.StartTime)
                            .GroupBy(s => $"{s.StartTime:hh\\:mm} - {s.EndTime:hh\\:mm}")
                            .ToList();

                        foreach (var timeSlot in timeSlots)
                        {
                            var timeCell = new PdfPCell(new Phrase(timeSlot.Key, cellFont))
                            {
                                Border = Rectangle.BOX,
                                BorderWidth = 0.5f,
                                Padding = 4f,
                                HorizontalAlignment = Element.ALIGN_CENTER,
                                VerticalAlignment = Element.ALIGN_MIDDLE
                            };
                            dayTable.AddCell(timeCell);

                            foreach (var cls in classesToExport)
                            {
                                var lesson = timeSlot.FirstOrDefault(s => s.GroupID == cls.GroupID);
                                string lessonInfo = lesson != null
                                    ? $"{lesson.Subjects?.Name}\n{lesson.Rooms?.Name}"
                                    : "—";

                                var lessonCell = new PdfPCell(new Phrase(lessonInfo, cellFont))
                                {
                                    Border = Rectangle.BOX,
                                    BorderWidth = 0.5f,
                                    Padding = 4f,
                                    HorizontalAlignment = Element.ALIGN_CENTER,
                                    VerticalAlignment = Element.ALIGN_MIDDLE
                                };
                                dayTable.AddCell(lessonCell);
                            }
                        }

                        doc.Add(dayTable);
                        doc.Add(Chunk.NEWLINE);
                    }

                    doc.Close();
                }

                MessageBox.Show($"Расписание экспортировано в PDF:\n{filePath}");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при экспорте:\n{ex.Message}");
            }
        }



        private void ExportScheduleToExcel_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show($"Находится в стадии подписания лиценнзии для работы с Exel:\n");
        }

    }
}