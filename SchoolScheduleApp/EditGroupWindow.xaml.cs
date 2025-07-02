using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class EditGroupWindow : Window
    {
        private SchoolScheduleEntities _dbContext;
        private Groups _group;

        public EditGroupWindow(int groupId)
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();

            // Загружаем группу по ID
            _group = _dbContext.Groups.FirstOrDefault(g => g.GroupID == groupId);
            if (_group == null)
            {
                MessageBox.Show("Группа не найдена.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                this.Close();
                return;
            }

            // Заполняем поля данными группы
            NameTextBox.Text = _group.Name;
          
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(NameTextBox.Text))
            {
                MessageBox.Show("Название группы не может быть пустым.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            

            // Проверяем, существует ли уже группа с таким названием (кроме текущей)
            var existingGroup = _dbContext.Groups.FirstOrDefault(g => g.Name == NameTextBox.Text && g.GroupID != _group.GroupID);
            if (existingGroup != null)
            {
                MessageBox.Show("Группа с таким названием уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Обновляем данные группы
            _group.Name = NameTextBox.Text;
           

            _dbContext.SaveChanges();

            MessageBox.Show("Данные группы успешно обновлены.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }
    }
}