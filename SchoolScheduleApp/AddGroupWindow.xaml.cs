using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class AddGroupWindow : Window
    {
        private SchoolScheduleEntities _dbContext;

        public AddGroupWindow()
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(NameTextBox.Text))
            {
                MessageBox.Show("Название группы не может быть пустым.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            

            // Проверяем, существует ли уже группа с таким названием
            var existingGroup = _dbContext.Groups.FirstOrDefault(g => g.Name == NameTextBox.Text);
            if (existingGroup != null)
            {
                MessageBox.Show("Группа с таким названием уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Создаем новую группу
            var newGroup = new Groups
            {
                Name = NameTextBox.Text,
                
            };

            _dbContext.Groups.Add(newGroup);
            _dbContext.SaveChanges();

            MessageBox.Show("Группа успешно добавлена.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }
    }
}