using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace SchoolScheduleApp
{
    public partial class AddCallsWindow : Window
    {
        private SchoolScheduleEntities _dbContext;

        public AddCallsWindow()
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            if (!TimeSpan.TryParse(StartTimeTextBox.Text, out TimeSpan startTime))
            {
                MessageBox.Show("Некорректное время начала звонка. Используйте формат ЧЧ:ММ или ЧЧ:ММ:СС.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (!TimeSpan.TryParse(EndTimeTextBox.Text, out TimeSpan endTime))
            {
                MessageBox.Show("Некорректное время конца звонка. Используйте формат ЧЧ:ММ или ЧЧ:ММ:СС.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (DayOfWeekComboBox.SelectedItem == null)
            {
                MessageBox.Show("Выберите день недели.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Получаем выбранный день недели
            string dayOfWeek = ((ComboBoxItem)DayOfWeekComboBox.SelectedItem).Content.ToString();

            // Преобразуем русские названия дней недели в английские
            switch (dayOfWeek)
            {
                case "Понедельник":
                    dayOfWeek = "Понедельник";
                    break;
                case "Вторник":
                    dayOfWeek = "Вторник";
                    break;
                case "Среда":
                    dayOfWeek = "Среда";
                    break;
                case "Четверг":
                    dayOfWeek = "Четверг";
                    break;
                case "Пятница":
                    dayOfWeek = "Пятница";
                    break;
                default:
                    MessageBox.Show("Некорректный день недели.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
            }

            // Проверяем, существует ли уже звонок с таким временем и днем недели
            var existingCall = _dbContext.Calls.FirstOrDefault(c => c.StartTime == startTime && c.EndTime == endTime && c.DayOfWeek == dayOfWeek);
            if (existingCall != null)
            {
                MessageBox.Show("Звонок с таким временем и днем недели уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Создаем новый звонок
            var newCall = new Calls
            {
                StartTime = startTime,
                EndTime = endTime,
                DayOfWeek = dayOfWeek
            };

            try
            {
                _dbContext.Calls.Add(newCall);
                _dbContext.SaveChanges();

                MessageBox.Show("Звонок успешно добавлен.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
            {
                MessageBox.Show($"Ошибка при сохранении данных: {ex.InnerException?.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

    }
}