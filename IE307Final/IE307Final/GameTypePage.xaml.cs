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
    public partial class GameTypePage : ContentPage
    {
        public GameTypePage()
        {
            InitializeComponent();
        }
        public GameTypePage(LoaiGame lg)
        {
            InitializeComponent();
            LayGameTheoLoai(lg);
        }
        private async void LayGameTheoLoai(LoaiGame lg)
        {
            HttpClient http = new HttpClient();
            var kq = await http.GetStringAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/LayGameTheoLoai?Game_Type=" + lg.Game_Type.ToString());
            var dslg = JsonConvert.DeserializeObject<List<Product>>(kq);
            CV_Type_Page.ItemsSource = dslg;
        }
        private void CV_Type_Page_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Product game = CV_Type_Page.SelectedItem as Product;
            Navigation.PushAsync(new GameDetailPage(game));
        }

        private void AddToWishList_Tapped(object sender, EventArgs e)
        {

        }
    }
}