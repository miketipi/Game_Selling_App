using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using Newtonsoft.Json;
using System.Net.Http;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LoginPage : ContentPage
    {
        public LoginPage()
        {
            InitializeComponent();
        }

        private void SwtNhoMatKhau_Toggled(object sender, ToggledEventArgs e)
        {

        }

        private void Btn_Signup_Clicked(object sender, EventArgs e)
        {
            Navigation.PushAsync(new SignUpPage());
        }

        private async void BtnLogin_Clicked(object sender, EventArgs e)
        {
            HttpClient http = new HttpClient();
            var kq = await http.GetStringAsync("http://"+ BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Login?UserName=" + EntUsrName.Text + "&PassWord=" + EntPassword.Text);
            var nd = JsonConvert.DeserializeObject<Account>(kq);
            if (nd.UserName != "" && nd.UserName != null)
            {
                await DisplayAlert("Thông báo", "Chào " + nd.UserName, "OK");
                Account.usr = new Account();
                Account.usr = nd;
                MessagingCenter.Send<LoginPage>(this, (Account.usr.Role == 1) ? "admin" : "user");
                await Shell.Current.GoToAsync("//main");
            }
            else await DisplayAlert("Thông báo", "Đăng nhập không hợp lệ", "OK");
        }
    }
}