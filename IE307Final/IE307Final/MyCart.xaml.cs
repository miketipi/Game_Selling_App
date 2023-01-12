﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using System.Net.Http;
using Newtonsoft.Json;

namespace IE307Final
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class MyCart : ContentPage
    {
        List<Product> game = new List<Product>();
        public MyCart()
        {
            InitializeComponent();
            CreateCartList();
        }
        private async void CreateCartList()
        {
            CV_Cart.ItemsSource = null;
            HttpClient http = new HttpClient();
            var lst_cart = await http.GetStringAsync("http://" + BoSung.DiaChiIPMay + "/doanie307/api/HelloWebAPIController/Load_Cart?userID=" + Account.usr.UserID.ToString());
            var cart = JsonConvert.DeserializeObject<List<Product>>(lst_cart);
            game = cart;
            float total = 0;
            foreach (Product p in game)
            {
                total += p.Price;
            }
            CV_Cart.ItemsSource = game;
        }
        protected override void OnAppearing()
        {
            CreateCartList();
            base.OnAppearing();
        }
        private async void cmdMuahang_Clicked(object sender, EventArgs e)
        {
            if(Account.usr.UserID==0)
            {
                await DisplayAlert("Thông báo", "Bạn chưa đăng nhập", "OK");
                return;
            }
            Account.usrCart.UserID = Account.usr.UserID;
            HttpClient http = new HttpClient();
            string jsonlh = JsonConvert.SerializeObject(Account.usrCart);
            StringContent httpcontent = new StringContent(jsonlh, Encoding.UTF8, "application/json");
            HttpResponseMessage kq;

            kq = await http.PostAsync("http://" + BoSung.DiaChiIPMay + "", httpcontent);
            var kqtv = await kq.Content.ReadAsStringAsync();
            if (int.Parse(kqtv.ToString()) > 0)
            {
                await DisplayAlert("Thông báo", "Thêm vào giỏ hàng thành công", "OK");

                Account.usrCart.GameList = new List<Product>();
            }
            else
                await DisplayAlert("Thông báo", "Thêm dữ liệu bị lỗi", "OK");
        }

        private void cmdxoa_Clicked(object sender, EventArgs e)
        {

        }

        private void cmdCapnhat_Clicked(object sender, EventArgs e)
        {

        }

        private void btn_Xoa_Clicked(object sender, EventArgs e)
        {
            ImageButton bt = (ImageButton)sender;
            Product SanPham = (Product)bt.BindingContext;
            Account.usrCart.GameList.Remove(SanPham);
            DisplayAlert("Thông báo", "Đã xoá thành công", "OK");
            CV_Cart.ItemsSource = Account.usrCart.GameList;
        }
    }
}