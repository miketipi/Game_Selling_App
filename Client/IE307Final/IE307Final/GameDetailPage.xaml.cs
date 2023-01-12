using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using IE307Final.Models;
using IE307Final;
using System.Net.Http;
using Newtonsoft.Json;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class GameDetailPage : ContentPage
    {
        public Product _game;
        public LoaiGame _lgame;
        Product b = new Product();
        public GameDetailPage()
        {
            InitializeComponent();
        }
        public GameDetailPage(Product a)
        {
            InitializeComponent();
            _game = a;
            a.LayTenLoai(a.Game_Type);
            Title = _game.Name;
            BindingContext = a;
            Scroll_ChiTiet.BindingContext = a;
            b = a;
        }

        private async void Btn_Add_Clicked(object sender, EventArgs e)
        {
            Cart crt = new Cart { UserID = Account.usr.UserID, ProductID = b.ProductID };
            HttpClient http = new HttpClient();
            string jsonlh = JsonConvert.SerializeObject(crt);
            StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
            HttpResponseMessage kqtv = await http.PostAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/AddToCart", httpcontent);
            var res = await kqtv.Content.ReadAsStringAsync();
            var ress = JsonConvert.DeserializeObject<Cart>(res);
            if (ress.UserID < 0 || res == null || res == "")
            {
                await DisplayAlert("Thông báo", "Thêm không thành công", "OK");
            }
            else await DisplayAlert("Thông báo", "Thêm sản phẩm vào giỏ hàng thành công", "OK");
        }

      private async void Yeuthich_Clicked(object sender, EventArgs e) 
        {
            Favourite fav = new Favourite { UserID = Account.usr.UserID, ProductID = b.ProductID };
            HttpClient http = new HttpClient();
            string jsonlh = JsonConvert.SerializeObject(fav);
            StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
            HttpResponseMessage kqtv = await http.PostAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/AddToFav", httpcontent); 
            var res = await kqtv.Content.ReadAsStringAsync();
            var ress = JsonConvert.DeserializeObject<Favourite>(res);
            if (ress.UserID < 0 || res == null || res == "")
            {
                await DisplayAlert("Thông báo", "Thêm không thành công", "OK");
            }
            else await DisplayAlert("Thông báo", "Thêm sản phẩm vào thành công", "OK");
        }
    }
}