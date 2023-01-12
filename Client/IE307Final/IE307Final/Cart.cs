using System;
using System.Collections.Generic;
using System.Text;
using Xamarin.Forms;
namespace IE307Final
{
    public class Cart
    {
        public int UserID { get; set; }
       public int ProductID { get; set; }
        public List<Product> GameList { get; set; }
     
    }
}
