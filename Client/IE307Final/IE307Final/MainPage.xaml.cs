using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using IE307Final.Models;
using Newtonsoft.Json;
using System.Net.Http;
namespace IE307Final
{
    public partial class MainPage : ContentPage
    {
        int tapCount = 2;
        List<Product> game = new List<Product>();
        List<Product> lst_Game = new List<Product>();
        Product b = new Product();
        public MainPage()
        {
            InitializeComponent();
            CreateGameList();
        }
        public async void CreateGameList()
        {

            HttpClient http = new HttpClient();
            var kq = await http.GetStringAsync
              ("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/LoadGame");
            var lst_game = JsonConvert.DeserializeObject<List<Product>>(kq);
            CV_Trending.ItemsSource = lst_game;
            lst_Game = lst_game;
        }
        private void CV_Trending_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Product game = CV_Trending.SelectedItem as Product;
            Navigation.PushAsync(new GameDetailPage(game));
        }

    private async void AddToWishList_Tapped(object sender, EventArgs e) 
        {
            tapCount++;
            var image = (Image)sender;
            Product SanPham = (Product)image.BindingContext;
            if (tapCount % 2 != 0)
            {
                image.Source = "FavouriteRedIcon.png";
                Favourite fav = new Favourite { UserID = Account.usr.UserID, ProductID = SanPham.ProductID };
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
            else
            {
                
                image.Source = "FavouriteBlackIcon.png";
                HttpClient http = new HttpClient();
                var lst_cart = await http.GetStringAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Load_Fav?userID=" + Account.usr.UserID.ToString());
                var cart = JsonConvert.DeserializeObject<List<Product>>(lst_cart);
                game = cart;
                foreach (Product p in game)
                {
                    if (SanPham.ProductID == p.ProductID)
                    {
                        Favourite newcrt = new Favourite { UserID = Account.usr.UserID, ProductID = SanPham.ProductID };
                        HttpClient htt = new HttpClient();
                        string jsonlh = JsonConvert.SerializeObject(newcrt);
                        StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
                        HttpResponseMessage kq = await htt.PostAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Fav_Delete", httpcontent);
                        
                        break;
                    }
                }
            }
        }

        private void CV_Recommend_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Product game = CV_Trending.SelectedItem as Product;
            Navigation.PushAsync(new GameDetailPage(game));
        }

        private void Action_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 6;
            Navigation.PushAsync(new GameTypePage(a));
        }

        private void Puzzle_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 7;
            Navigation.PushAsync(new GameTypePage(a));
        }

        private void TPS_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 2;
            Navigation.PushAsync(new GameTypePage(a));
        }

        private void FPS_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 1;
            Navigation.PushAsync(new GameTypePage(a)); 
        }

        private void PVP_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 5;
            Navigation.PushAsync(new GameTypePage(a));
        }

        private void sport_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 8;
            Navigation.PushAsync(new GameTypePage(a));
        }

        private void stimulate_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 3;
            Navigation.PushAsync(new GameTypePage(a));
        }

        private void racing_Tapped(object sender, EventArgs e)
        {
            LoaiGame a = new LoaiGame();
            a.Game_Type = 4;
            Navigation.PushAsync(new GameTypePage(a));
        }


        private async void AddToCart_Clicked(object sender, EventArgs e)
        {
            ImageButton bt = (ImageButton)sender;
            Product SanPham = (Product)bt.BindingContext;
            Cart crt = new Cart { UserID = Account.usr.UserID, ProductID = SanPham.ProductID };
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

        private void Search_game_TextChanged(object sender, TextChangedEventArgs e)
        {
            string text = Search_game.Text.ToUpper();
            CV_Trending.ItemsSource = lst_Game.Where(i => i.Name.ToUpper().Contains(text));
        }
    }
}
