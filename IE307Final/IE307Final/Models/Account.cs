﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IE307Final.Models
{
    public class Account
    {
        public int UserID { get; set; }
        public string UserName { get; set; }
        public string PassWord { get; set; }
        public string Role { get; set; }
        public string Email { get; set; }
        public string phone { get; set; }
        public string Address { get; set; }
        public static Cart usrCart;
        public static Account usr;
    }
}
