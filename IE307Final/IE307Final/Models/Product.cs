﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IE307Final.Models
{
    public class Product
    {
        public string ProductID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Game_Img { get; set; }
        public string Game_Type { get; set; }
        public float Rating { get; set; }
        public float Price { get; set; }
    }
}
