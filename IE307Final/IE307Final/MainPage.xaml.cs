using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using IE307Final.Models;
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
        public void CreateGameList()
        {
            SharedFunct.CreateGameList(lst_Game);
            CV_Trending.ItemsSource = lst_Game;
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

        }
    }
}
