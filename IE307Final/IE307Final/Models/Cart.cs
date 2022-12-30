using System;
using System.Collections.Generic;
using System.Text;

namespace IE307Final.Models
{
    public class Cart
    {
        public string UserID { get; set; }
        public string Deliver_Address { get; set; }
        public string Note { get; set; }
        public List<Product> GameList { get; set; }
    }
}
