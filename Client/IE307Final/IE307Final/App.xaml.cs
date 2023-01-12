using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using IE307Final;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;
namespace IE307Final
{
    public partial class App : Application
    {

        public App()
        {
            InitializeComponent();
            
            MainPage = new MainShellPage();
            Account.usr = new Account();
            Account.usrCart = new Cart();
            Account.usrCart.GameList = new System.Collections.Generic.List<Product>();
            Account.GioHang = new System.Collections.Generic.List<Product>();
        }
        
         

        protected override void OnStart()
        {
        }

        protected override void OnSleep()
        {
        }

        protected override void OnResume()
        {
        }
    }
}
