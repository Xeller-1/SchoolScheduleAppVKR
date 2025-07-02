using System.Linq;
using System.Windows;

namespace SchoolScheduleApp
{
    public partial class EditRoomWindow : Window
    {
        private SchoolScheduleEntities _dbContext;
        private Rooms _room;

        public EditRoomWindow(int roomId)
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();

            // Загружаем кабинет по ID
            _room = _dbContext.Rooms.FirstOrDefault(r => r.RoomID == roomId);
            if (_room == null)
            {
                MessageBox.Show("Кабинет не найден.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                this.Close();
                return;
            }

            // Заполняем поля данными кабинета
            NameTextBox.Text = _room.Name;
            CapacityTextBox.Text = _room.Capacity.ToString();
           
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
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

            // Обновляем данные кабинета
            _room.Name = NameTextBox.Text;
            _room.Capacity = capacity;


            _dbContext.SaveChanges();

            MessageBox.Show("Данные кабинета успешно обновлены.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }
    }
}