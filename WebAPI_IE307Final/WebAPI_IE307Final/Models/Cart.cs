using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI_IE307Final.Models
{
    public class Cart
    {
        public string UserID { get; set; }
        public string Deliver_Address { get; set; }
        public string Note { get; set; }
        public List<Product> GameList { get; set; }
    }
}