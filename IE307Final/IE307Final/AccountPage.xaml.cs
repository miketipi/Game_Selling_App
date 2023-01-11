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
        Account tkc;
        public AccountPage()
        {
            InitializeComponent();
            BindingContext = Account.usr;
            tkc = new Account();
        }

        private async void Btn_Change_Clicked(object sender, EventArgs e)
        {
            if (EntPasswordAgain.Text != EntPassword.Text)
            {
                await DisplayAlert("Thông báo", "Mật khẩu nhập lại không đúng", "OK");
                return;
            }    
            HttpClient http = new HttpClient();
            Account acc = new Account { UserID = Account.usr.UserID, phone = EntPhoneNumber.Text, Email = EntEmail.Text, PWD = EntPassword.Text };
            string jsonlh = JsonConvert.SerializeObject(acc);
            StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
            HttpResponseMessage kq = await http.PutAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/HelloWebAPIController/Update_Account", httpcontent);
            var kqtv = await kq.Content.ReadAsStringAsync();
            acc = JsonConvert.DeserializeObject<Account>(kqtv);
            if (int.Parse(kqtv.ToString()) > 0)
            {
                await DisplayAlert("Thông báo", "Sửa thông tin thành công", "OK");
            }
            else await DisplayAlert("Thông báo", "Cập nhật thất bại", "OK");
            

        }
    }
}