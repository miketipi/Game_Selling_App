using System;
using System.Collections.Generic;
using System.Text;
using IE307Final.Models;
namespace IE307Final
{
    public static class SharedFunct
    {
        public static void CreateGameList (List<Product>games)
        {
            games.Add(new Product
            {
                Name = "Age of Empire",
                Description = "Game De Che",
                Game_Type = "RPS",
                Game_Img = "http://genk.mediacdn.vn/2017/photo-1-1508117938308.jpg",
                Price = 25000,
                ProductID = "1",
                Rating = 5
            });
            games.Add(new Product
            {
                Name = "Age of Empire",
                Description = "Game De Che",
                Game_Type = "RPS",
                Game_Img = "http://genk.mediacdn.vn/2017/photo-1-1508117938308.jpg",
                Price = 25000,
                ProductID = "1",
                Rating = 5
            });
            games.Add(new Product
            {
                Name = "Age of Empire",
                Description = "Game De Che",
                Game_Type = "RPS",
                Game_Img = "http://genk.mediacdn.vn/2017/photo-1-1508117938308.jpg",
                Price = 25000,
                ProductID = "1",
                Rating = 5
            });
        }
    }
}
