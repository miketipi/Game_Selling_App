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
    public partial class AddGamePage : ContentPage
    {
        public AddGamePage()
        {
            InitializeComponent();
        }

        private async void Btn_Them_Clicked(object sender, EventArgs e)
        {
            string name = EntGameName.Text;
            string nentang = EntPlatform.Text;
            int gametype = int.Parse(EntGameType.Text);
            string des = EntDes.Text;
            float gia = float.Parse(EntPrice.Text);
            
            string img = EntImg.Text;
            float rating = float.Parse(EntRating.Text);
            Product pd = new Product { Description = des, Price = gia, Rating = rating, Game_Img = img, Game_Type = gametype, Name = name, Platform = nentang };
            HttpClient http = new HttpClient();
            String jsonlh = JsonConvert.SerializeObject(pd);
            StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
            HttpResponseMessage kq = await http.PostAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Them_Game", httpcontent);
            var kqtv = await kq.Content.ReadAsStringAsync();
            pd = JsonConvert.DeserializeObject<Product>(kqtv);
            if (pd.ProductID > 0)
            {
                await DisplayAlert("Thông báo", "Thêm thành công game! ", "OK");
            }
            else
                await DisplayAlert("Thông báo", "Game đã tồn tại", "OK");
        }
    }
}