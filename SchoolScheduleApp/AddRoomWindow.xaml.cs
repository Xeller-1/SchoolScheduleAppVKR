using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class AddRoomWindow : Window
    {
        private SchoolScheduleEntities _dbContext;

        public AddRoomWindow()
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(NameTextBox.Text))
            {
                MessageBox.Show("Название кабинета не может быть пустым.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (!int.TryParse(CapacityTextBox.Text, out int capacity) || capacity <= 0)
            {
                MessageBox.Show("Вместимость должна быть положительным числом.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Проверяем, существует ли уже кабинет с таким названием
            var existingRoom = _dbContext.Rooms.FirstOrDefault(r => r.Name == NameTextBox.Text);
            if (existingRoom != null)
            {
                MessageBox.Show("Кабинет с таким названием уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Создаем новый кабинет
            var newRoom = new Rooms
            {
                Name = NameTextBox.Text,
                Capacity = capacity,
                
            };

            _dbContext.Rooms.Add(newRoom);
            _dbContext.SaveChanges();

            MessageBox.Show("Кабинет успешно добавлен.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }
    }
}