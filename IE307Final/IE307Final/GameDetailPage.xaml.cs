using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using IE307Final.Models;
using IE307Final;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class GameDetailPage : ContentPage
    {
        public Product _game;
        public GameDetailPage()
        {
            InitializeComponent();
        }
        public GameDetailPage(Product a)
        {
            InitializeComponent();
            _game = a;
            Title = _game.Name;
            /*Scroll_ChiTiet.BindingContext = a;*/
        }
        private void Btn_AddToBuy_Clicked(object sender, EventArgs e)
        {
            Navigation.PushAsync(new MyCart());
        }
        private void Btn_Loving_Clicked(object sender, EventArgs e)
        {

        }
    }
}