using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace SchoolScheduleApp
{
    public partial class EditCallsWindow : Window
    {
        private SchoolScheduleEntities _dbContext;
        private Calls _call;

        public EditCallsWindow(int callId)
        {
            InitializeComponent();
            _dbContext = new SchoolScheduleEntities();

            // Загружаем звонок по ID
            _call = _dbContext.Calls.FirstOrDefault(c => c.CallID == callId);
            if (_call == null)
            {
                MessageBox.Show("Звонок не найден.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                this.Close();
                return;
            }

            // Заполняем поля данными звонка
            StartTimeTextBox.Text = _call.StartTime.ToString();
            EndTimeTextBox.Text = _call.EndTime.ToString();
            DayOfWeekComboBox.SelectedItem = DayOfWeekComboBox.Items.Cast<ComboBoxItem>().FirstOrDefault(item => item.Content.ToString() == _call.DayOfWeek);
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (!TimeSpan.TryParse(StartTimeTextBox.Text, out TimeSpan startTime))
            {
                MessageBox.Show("Некорректное время начала звонка.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (!TimeSpan.TryParse(EndTimeTextBox.Text, out TimeSpan endTime))
            {
                MessageBox.Show("Некорректное время конца звонка.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (DayOfWeekComboBox.SelectedItem == null)
            {
                MessageBox.Show("Выберите день недели.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Получаем выбранный день недели
            string dayOfWeek = ((ComboBoxItem)DayOfWeekComboBox.SelectedItem).Content.ToString();

            // Обновляем данные звонка
            _call.StartTime = startTime;
            _call.EndTime = endTime;
            _call.DayOfWeek = dayOfWeek;

            _dbContext.SaveChanges();

            MessageBox.Show("Данные звонка успешно обновлены.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }
    }
}