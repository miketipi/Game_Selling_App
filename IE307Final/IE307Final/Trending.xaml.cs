using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using Newtonsoft.Json;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class Trending : ContentPage
    {
        int tapCount = 2;
        public Trending()
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
                CV_ALL.ItemsSource = lst_game;
                
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

            }
            if (choose == false)
            {
                Account.usrCart.GameList.Add(prod);
            }
            DisplayAlert("Thông báo", "Thêm vào giỏ hàng thành công", "OK");
        }

        private void CV_ALL_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Product game = CV_ALL.SelectedItem as Product;
            Navigation.PushAsync(new GameDetailPage(game));
        }
    }
}