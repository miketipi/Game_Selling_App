using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using Newtonsoft.Json;
using System.Net.Http;
using IE307Final;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class SignUpPage : ContentPage
    {
        public SignUpPage()
        {
            InitializeComponent();
            if(Account.usr.UserID>0)
            {
                EntRealName.Text = Account.usr.RealName;
                EntUsrName.Text = Account.usr.UserName;
                EntEmail.Text = Account.usr.Email;
            }  
        }

        private async void Btn_SignUp_Clicked(object sender, EventArgs e)
        {
            string TenND = EntUsrName.Text;
            string MatKhau = EntPassword.Text;
            string MatKhaunl = EntPasswordAgain.Text;
            string TenThat = EntRealName.Text;
            string email = EntEmail.Text;
            string phone = EntPhoneNumber.Text;
            if(EntUsrName.Text == null || EntPassword==null || EntRealName==null || EntEmail.Text ==null || EntPhoneNumber==null)
            {
                await DisplayAlert("Thông báo", "Vui lòng nhâp đủ các trường thông tin", "OK");
                return;
            }    
            if (EntPassword.Text != EntPasswordAgain.Text)
            {
                await DisplayAlert("Thông báo", "Mật khẩu nhập lại không đúng", "OK");
                return;
            }
            Account acc = new Account { UserName = TenND, RealName = TenThat, PWD = MatKhau, Email = email , phone = phone, Role=0};
            HttpClient http = new HttpClient();
            string jsonlh = JsonConvert.SerializeObject(acc);
            StringContent httcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
            HttpResponseMessage kq = await http.PostAsync
                ("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/AddUser", httcontent);
            var kqtv = await kq.Content.ReadAsStringAsync();
            acc = JsonConvert.DeserializeObject<Account>(kqtv);
            if (acc.UserID > 0)
            {
                await DisplayAlert("Thông báo", "Thêm thành công người dùng " + acc.UserName, "OK");
                await Shell.Current.GoToAsync("//login");
            }
            else
                await DisplayAlert("Thông báo", "Tên Đăng Nhập " + acc.UserName + " đã tồn tại", "OK");
        }
    }
}