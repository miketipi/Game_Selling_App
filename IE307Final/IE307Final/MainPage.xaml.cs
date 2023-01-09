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
        List<Product> lst_Game = new List<Product>();
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
        }
        private void CV_Trending_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Product game = CV_Trending.SelectedItem as Product;
            Navigation.PushAsync(new GameDetailPage(game));
        }

        private void AddToWishList_Tapped(object sender, EventArgs e)
        {
            tapCount++;
            var image = (Image)sender;
            if (tapCount % 2 != 0)
            {
                image.Source = "FavouriteRedIcon.png";
            }
            else
            {
                image.Source = "FavouriteBlackIcon.png";
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


        private void AddToCart_Clicked(object sender, EventArgs e)
        {
            ImageButton bt = (ImageButton)sender;
            Product prod = (Product)bt.BindingContext;
            bool choose = false;
            foreach (Product p in Account.usrCart.GameList)
            {
                if (prod.ProductID == p.ProductID)
                {
                    choose = true;
                    break; //xem xem  san pham da duoc chon hay chua
                }
                if (choose == false)
                {
                    Account.usrCart.GameList.Add(prod);
                }
                
            }
            DisplayAlert("Thông báo", "Thêm vào giỏ hàng thành công", "OK");
        }
    }
}
