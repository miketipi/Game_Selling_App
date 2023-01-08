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
        public LoaiGame _lgame;
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
            Scroll_ChiTiet.BindingContext = a;
        }

        private void Btn_Add_Clicked(object sender, EventArgs e)
        {

        }

        private void Yeuthich_Clicked(object sender, EventArgs e)
        {

        }
    }
}