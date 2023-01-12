using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI_IE307Final.Models
{
    public class Product
    {
        public int ProductID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Game_Img { get; set; }
        public int Game_Type { get; set; }
        public float Rating { get; set; }
        public float Price { get; set; }
        public string Platform { get; set; }
        public bool Status { get; set; }
    }
}