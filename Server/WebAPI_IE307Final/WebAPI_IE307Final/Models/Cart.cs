using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI_IE307Final.Models
{
    public class Cart
    {
        public int UserID { get; set; }
        public int ProductID { get; set; }
        public List<Product> GameList { get; set; }

    }
}