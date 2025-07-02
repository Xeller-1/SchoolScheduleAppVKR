using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace SchoolScheduleApp
{
    public partial class Login : Window
    {
        public Login()
        {
            InitializeComponent();
            this.Closed += Login_Closed; // Добавляем обработчик закрытия окна
        }

        private void Login_Closed(object sender, EventArgs e)
        {
            // Гарантируем корректное закрытие приложения
            Application.Current.Shutdown();
        }

        private void UsernameTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            try
            {
                UsernamePlaceholder.Visibility = string.IsNullOrWhiteSpace(UsernameTextBox.Text)
                    ? Visibility.Visible
                    : Visibility.Collapsed;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка обновления интерфейса: {ex.Message}");
            }
        }

        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            try
            {
                PasswordPlaceholder.Visibility = string.IsNullOrWhiteSpace(PasswordBox.Password)
                    ? Visibility.Visible
                    : Visibility.Collapsed;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка обновления интерфейса: {ex.Message}");
            }
        }


        public bool VerifyPassword(string enteredPassword, string storedHash)
        {
            try
            {
                return BCrypt.Net.BCrypt.Verify(enteredPassword, storedHash);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при верификации пароля: {ex.Message}");
                return false;
            }
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var username = UsernameTextBox.Text.Trim();
                var password = PasswordBox.Password;

                // Валидация ввода
                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    MessageBox.Show("Введите логин и пароль");
                    return;
                }

                // Создаем новый контекст для авторизации
                using (var authContext = new SchoolScheduleEntities())
                {
                    var user = authContext.Users
                        .AsNoTracking()
                        .FirstOrDefault(u => u.Username == username);

                    if (user == null)
                    {
                        MessageBox.Show("Пользователь не найден");
                        return;
                    }

                    if (!VerifyPassword(password, user.PasswordHash))
                    {
                        MessageBox.Show("Неверный пароль");
                        return;
                    }

                    // Успешная авторизация - запускаем главное окно
                    this.Hide(); // Скрываем окно авторизации

                    var mainWindow = new MainWindow();
                    mainWindow.Closed += (s, args) => this.Close(); // Закрываем авторизацию при закрытии главного окна
                    mainWindow.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка авторизации: {ex.Message}");
            }
            finally
            {
                PasswordBox.Password = ""; // Всегда очищаем пароль
            }
        }
    }
}