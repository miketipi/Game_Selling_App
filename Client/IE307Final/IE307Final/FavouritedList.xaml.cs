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
    public partial class FavouritedList : ContentPage
    {
        List<Product> game = new List<Product>();
        public FavouritedList()
        {
            InitializeComponent();
            CreateFavList();
        }
        private async void CreateFavList()
        {
            CV_favorite.ItemsSource = null;
            HttpClient http = new HttpClient();
            var lst_cart = await http.GetStringAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Load_Fav?userID=" + Account.usr.UserID.ToString());
            var cart = JsonConvert.DeserializeObject<List<Product>>(lst_cart);
            game = cart;
            float total = 0;
            foreach (Product p in game)
            {
                total += p.Price;
            }
            CV_favorite.ItemsSource = cart;
        }
        protected override void OnAppearing()
        {
            CreateFavList();
            base.OnAppearing();
        }
private   async void btn_Xoa_Clicked(object sender, EventArgs e) 
        {
            ImageButton bt = (ImageButton)sender;
            Product SanPham = (Product)bt.BindingContext;
            foreach (Product p in game)
            {
                if (SanPham.ProductID == p.ProductID)
                {
                    Favourite newcrt = new Favourite { UserID = Account.usr.UserID, ProductID = SanPham.ProductID };
                    HttpClient http = new HttpClient();
                    string jsonlh = JsonConvert.SerializeObject(newcrt);
                    StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
                    HttpResponseMessage kq = await http.PostAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Fav_Delete", httpcontent);
                    CreateFavList();
                    break;
                }
            } 
            await DisplayAlert("Thông báo", "Đã xoá thành công " + SanPham.Name, "OK");

        }
    }
}