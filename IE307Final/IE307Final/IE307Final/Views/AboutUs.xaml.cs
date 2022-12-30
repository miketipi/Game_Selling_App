using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Essentials;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using System.Windows.Input;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class AboutUs : ContentPage
    {
        public AboutUs()
        {
            InitializeComponent();
            Title = "Về chúng tôi";
            OpenGitHubCommand = new Command(async () => await Browser.OpenAsync("https://github.com/miketipi/Game_Selling_App.git"));
        }
        public ICommand OpenGitHubCommand { get; }
    }
}