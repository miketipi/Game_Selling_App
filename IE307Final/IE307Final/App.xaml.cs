using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using IE307Final;

namespace IE307Final
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new MainShellPage();
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
