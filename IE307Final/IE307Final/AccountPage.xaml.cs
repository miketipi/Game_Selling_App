using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using System.Net.Http;
using Newtonsoft.Json;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class AccountPage : ContentPage
    {
        Account tkc = Account.usr;
        public AccountPage()
        {
            InitializeComponent();
            BindingContext = Account.usr;           
        }
        protected override void OnAppearing()
        {
            base.OnAppearing();
        }
        private async void Btn_Change_Clicked(object sender, EventArgs e)
        {
            if (EntPasswordAgain.Text != EntPassword.Text)
            {
                await DisplayAlert("Thông báo", "Mật khẩu nhập lại không đúng", "OK");
                return;
            }
            string userID = Account.usr.UserID.ToString();
            string MatKhau = EntPassword.Text;
            string MatKhaunl = EntPasswordAgain.Text;
            string TenThat = EntRealName.Text;
            string email = EntEmail.Text;
            string phone = EntPhoneNumber.Text;
            tkc.UserID = Account.usr.UserID;
            tkc.Role = Account.usr.Role;
            tkc.UserName = Account.usr.UserName;
            tkc.phone = EntPhoneNumber.Text;
            tkc.Email = EntEmail.Text;
            tkc.PWD = EntPassword.Text;
            
            
            HttpClient http = new HttpClient();
            string jsonlh = JsonConvert.SerializeObject(tkc);
            StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
            HttpResponseMessage kq = await http.PostAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Update_Account", httpcontent);
            var kqtv = await kq.Content.ReadAsStringAsync();
            var kqtvv = kq.StatusCode.ToString();
            if (kq.StatusCode.ToString() == "OK")
            {
                await DisplayAlert("Thông báo", "Sửa thông tin thành công", "OK");
            }
            else await DisplayAlert("Thông báo", "Cập nhật thất bại", "OK");
        }
    }
}