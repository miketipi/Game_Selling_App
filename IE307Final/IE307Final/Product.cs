using System;
using System.Collections.Generic;
using System.Text;
using Xamarin.Forms;
namespace IE307Final
{
    public class Product
    {
        public string ProductID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Game_Img { get; set; }
        public int Game_Type { get; set; }
        public float Rating { get; set; }
        public float Price { get; set; }
        public bool Status { get; set; }
        public string Platform { get; set; }
        public string TenLoai { get; set; }
        public void LayTenLoai (int a)
        {
            switch(a)
            {
                case 1:
                    this.TenLoai = "FPS";
                    break;
                case 2:
                    this.TenLoai = "Bắn súng góc nhìn thứ ba";
                    break;
                case 3:
                    this.TenLoai = "Mô phỏng nhập vai";
                    break;
                case 4:
                    this.TenLoai = "Đua xe";
                    break;
                case 5:
                    this.TenLoai = "PVP";
                    break;
                case 6:
                    this.TenLoai = "Hành động";
                    break;
                case 7:
                    this.TenLoai = "Giải đố";
                    break;
                case 8:
                    this.TenLoai = "Thể thao";
                    break;

            }
        }
        
        

    }
}
