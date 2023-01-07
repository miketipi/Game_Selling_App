using System;
using System.Collections.Generic;
using System.Text;
using Xamarin.Forms;
namespace IE307Final
{
    public class Cart
    {
        public int UserID { get; set; }
        public string Deliver_Address { get; set; }
        public string Note { get; set; }
        public List<Product> GameList { get; set; }
     
    }
}
