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
            Button bt = (Button)sender;
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

        private void Yeuthich_Clicked(object sender, EventArgs e)
        {

        }
    }
}