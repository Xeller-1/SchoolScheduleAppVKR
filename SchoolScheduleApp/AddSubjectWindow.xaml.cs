using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class AddSubjectWindow : Window
    {
        private SchoolScheduleEntities _dbContext;

        public AddSubjectWindow()
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();
            LoadGroups();
        }

        private void LoadGroups()
        {
            GroupComboBox.ItemsSource = _dbContext.Groups.ToList();
            GroupComboBox.SelectedIndex = 0;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            // Проверка выбранного класса
            if (GroupComboBox.SelectedItem == null)
            {
                MessageBox.Show("Выберите класс.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            var selectedGroup = GroupComboBox.SelectedItem as Groups;

            if (string.IsNullOrWhiteSpace(NameTextBox.Text))
            {
                MessageBox.Show("Название предмета не может быть пустым.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (!int.TryParse(ComplexityTextBox.Text, out int complexity) || complexity < 1 || complexity > 15)
            {
                MessageBox.Show("Сложность должна быть числом от 1 до 15.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (!int.TryParse(HoursTextBox.Text, out int hours) || hours <= 0)
            {
                MessageBox.Show("Часы должны быть положительным числом.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Проверяем, существует ли уже предмет с таким названием (глобально)
            var existingSubject = _dbContext.Subjects.FirstOrDefault(s => s.Name == NameTextBox.Text);

            Subjects subjectToAdd;

            if (existingSubject != null)
            {
                // Если предмет уже существует, используем его
                subjectToAdd = existingSubject;

                // Проверяем, не добавлен ли уже этот предмет в учебный план класса
                if (_dbContext.Curriculum.Any(c => c.GroupID == selectedGroup.GroupID && c.SubjectID == subjectToAdd.SubjectID))
                {
                    MessageBox.Show("Этот предмет уже есть в учебном плане выбранного класса.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
            }
            else
            {
                // Создаем новый предмет
                subjectToAdd = new Subjects
                {
                    Name = NameTextBox.Text,
                    Complexity = complexity,
                    Hours = hours
                };
                _dbContext.Subjects.Add(subjectToAdd);
            }

            // Добавляем связь предмета с классом в Curriculum
            var curriculum = new Curriculum
            {
                GroupID = selectedGroup.GroupID,
                SubjectID = subjectToAdd.SubjectID,
                Hours = hours,
                Complexity = complexity
            };

            _dbContext.Curriculum.Add(curriculum);
            _dbContext.SaveChanges();

            MessageBox.Show("Предмет успешно добавлен в учебный план класса.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.DialogResult = true;
            this.Close();
        }
    }
}