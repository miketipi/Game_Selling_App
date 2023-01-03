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
              ("http://192.168.1.10/doanie307/api/HelloWebAPIController/LoadGame");
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
    }
}
