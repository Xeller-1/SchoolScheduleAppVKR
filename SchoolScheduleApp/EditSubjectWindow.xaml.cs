using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class EditSubjectWindow : Window
    {
        private SchoolScheduleEntities _dbContext;
        private Subjects _subject;

        public EditSubjectWindow(int subjectId)
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();

            // Загружаем предмет по ID
            _subject = _dbContext.Subjects.FirstOrDefault(s => s.SubjectID == subjectId);
            if (_subject == null)
            {
                MessageBox.Show("Предмет не найден.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                this.Close();
                return;
            }

            // Заполняем поля данными предмета
            NameTextBox.Text = _subject.Name;
            ComplexityTextBox.Text = _subject.Complexity.ToString();
            HoursTextBox.Text = _subject.Hours.ToString();
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
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

            // Обновляем данные предмета
            _subject.Name = NameTextBox.Text;
            _subject.Complexity = complexity;
            _subject.Hours = hours;

            _dbContext.SaveChanges();

            MessageBox.Show("Данные предмета успешно обновлены.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }
    }
}