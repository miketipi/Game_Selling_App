using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using Xamarin.Essentials;
using System.Windows.Input;
using IE307Final;
using System.ComponentModel;
using System.Runtime.CompilerServices;
namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class MainShellPage : Xamarin.Forms.Shell
    {
        public ICommand HelpCommand { get; }
        protected bool SetProperty<T>(ref T backingStore, T value,
            [CallerMemberName] string propertyName = "",
            Action onChanged = null)
        {
            if (EqualityComparer<T>.Default.Equals(backingStore, value))
                return false;

            backingStore = value;
            onChanged?.Invoke();
            OnPropertyChanged(propertyName);
            return true;
        }
        public bool IsAdmin { get => isAdmin; set => SetProperty(ref isAdmin, value); }
        private bool isAdmin;
        public MainShellPage()
        {
            MessagingCenter.Subscribe<LoginPage>(this, "admin", (sender) =>
            {
                IsAdmin = true;
            });
            MessagingCenter.Subscribe<LoginPage>(this, "user", (sender) =>
            {
                IsAdmin = false;
            });
            HelpCommand = new Command<string>(async (url) => await Browser.OpenAsync(url));           
            InitializeComponent();
            BindingContext = this;

        }
        
        
       
        

    }
}