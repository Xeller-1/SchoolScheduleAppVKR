using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class EditTeacherWindow : Window
    {
        private readonly Teachers _teacher;
        private readonly SchoolScheduleEntities _context;
        private readonly List<Subjects> _currentSubjects;

        public EditTeacherWindow(Teachers teacher, List<Subjects> currentSubjects)
        {
            InitializeComponent();
            _teacher = teacher;
            _context = new SchoolScheduleEntities();
            _currentSubjects = currentSubjects;

            // Заполняем форму
            NameTextBox.Text = teacher.FullName;

            // Загружаем все возможные предметы
            var allSubjects = _context.Subjects.ToList();
            SubjectsListBox.ItemsSource = allSubjects;

            // Выделяем текущие предметы преподавателя
            foreach (var item in SubjectsListBox.Items)
            {
                var subject = item as Subjects;
                if (_currentSubjects.Any(s => s.SubjectID == subject.SubjectID))
                {
                    SubjectsListBox.SelectedItems.Add(item);
                }
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Обновляем основные данные
                _teacher.FullName = NameTextBox.Text;

                // Получаем выбранные предметы
                var selectedSubjects = SubjectsListBox.SelectedItems.Cast<Subjects>().ToList();

                // Обновляем связи с предметами через расписание
                // 1. Удаляем старые связи с предметами, которые были сняты
                var schedulesToRemove = _teacher.Schedule?
                    .Where(s => !selectedSubjects.Any(sub => sub.SubjectID == s.SubjectID))
                    .ToList() ?? new List<Schedule>();

                foreach (var schedule in schedulesToRemove)
                {
                    _context.Schedule.Remove(schedule);
                }

                // 2. Добавляем новые связи
                foreach (var subject in selectedSubjects)
                {
                    if (!_teacher.Schedule.Any(s => s.SubjectID == subject.SubjectID))
                    {
                        _teacher.Schedule.Add(new Schedule
                        {
                            SubjectID = subject.SubjectID,
                            // Установите другие необходимые поля расписания
                            // Например, GroupID, CallID и т.д.
                        });
                    }
                }

                DialogResult = true;
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при сохранении: {ex.Message}");
            }
        }
    }
}