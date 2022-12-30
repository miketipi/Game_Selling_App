using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using Xamarin.Essentials;
using System.Windows.Input;
using IE307Final.Views;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class MainShellPage : Xamarin.Forms.Shell
    {
        public ICommand HelpCommand { get; }
        public MainShellPage()
        {
            HelpCommand = new Command<string>(async (url) => await Browser.OpenAsync(url));
            InitializeComponent();
            BindingContext = this;
        }
    }
}