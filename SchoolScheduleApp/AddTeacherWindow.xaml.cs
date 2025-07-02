using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class AddTeacherWindow : Window
    {
        private SchoolScheduleEntities _dbContext;

        public AddTeacherWindow()
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();

            // Загружаем предметы и пользователей в ComboBox
            SubjectComboBox.ItemsSource = _dbContext.Subjects.ToList();
            
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(FullNameTextBox.Text))
            {
                MessageBox.Show("ФИО преподавателя не может быть пустым.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (SubjectComboBox.SelectedItem == null)
            {
                MessageBox.Show("Необходимо выбрать предмет.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Проверяем, существует ли уже преподаватель с таким ФИО
            var existingTeacher = _dbContext.Teachers.FirstOrDefault(t => t.FullName == FullNameTextBox.Text);
            if (existingTeacher != null)
            {
                MessageBox.Show("Преподаватель с таким ФИО уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Создаем нового преподавателя
            var newTeacher = new Teachers
            {
                FullName = FullNameTextBox.Text,
                SubjectID = ((Subjects)SubjectComboBox.SelectedItem).SubjectID,
                
            };

            _dbContext.Teachers.Add(newTeacher);
            _dbContext.SaveChanges();

            MessageBox.Show("Преподаватель успешно добавлен.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }
    }
}