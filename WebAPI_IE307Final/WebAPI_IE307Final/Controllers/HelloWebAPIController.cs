using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebAPI_IE307Final.Models;
using System.Data;
namespace WebAPI_IE307Final.Controllers
{
    public class HelloWebAPIController : ApiController
    {
        [Route("api/HelloWebAPIController/HelloWebAPI")]
        [HttpGet]
        public IHttpActionResult HelloWebAPI()
        {
            return Ok("Chao mung web API");
        }
        [Route("api/HelloWebAPIController/GameList")]
        [HttpGet]
       public IHttpActionResult GameList()
        {
            try
            {
                DataTable tb = Database.GameList();
                return Ok(tb);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/LoadGame")]
        [HttpGet]
        public IHttpActionResult LoadGame()
        {
            try
            {
                DataTable tb = Database.LoadGame();
                return Ok(tb);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/LayGameTheoLoai")]
        [HttpGet]
        public IHttpActionResult LayGameTheoLoai(int Game_Type)
        {
            try
            {
                DataTable tb = Database.LayGameTheoLoai(Game_Type);
                return Ok(tb);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/Login")]
        [HttpGet]
        public IHttpActionResult Login(string UserName, string PassWord)
        {
            try
            {
                Account acc = Database.Login(UserName, PassWord);
                return Ok(acc);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/AddUser")]
        [HttpPost]
        public IHttpActionResult AddUser (Account nd)
        {
            try
            {
                Account kq = Database.AddUser(nd);
                return Ok(kq);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/AddCart")]
        [HttpPost]
        public IHttpActionResult AddCart(Cart crt)
        {
            try
            {
                int kq = Database.AddCart(crt);
                return Ok(crt);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/Update_Account")]
        [HttpPost]
        public IHttpActionResult Update_Account(Account nd)
        {
            try
            {
                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("mand", nd.UserID);
                param.Add("usrname", nd.UserName);
                param.Add("dt", nd.phone);
                param.Add("pwd", nd.PWD);
                param.Add("email", nd.Email);
                int kq = int.Parse(Database.Exec_Command("Update_Account", param).ToString());
                string kqtv = Database.Exec_Command("Update_Account", param).ToString();
                return Ok(nd);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/Them_Game")]
        [HttpPost]
        public IHttpActionResult Them_Game(Product pd)
        {
            try
            {
                Product kq = Database.Them_Game(pd);
                return Ok(kq);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/AddToCart")]
        [HttpPost]
        public IHttpActionResult AddToCart(Cart crt)
        {
            try
            {
                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("pdid", crt.ProductID);
                param.Add("usrID", crt.UserID);
                int kq = int.Parse(Database.Exec_Command("AddToCart", param).ToString());
                string kqtv = Database.Exec_Command("AddToCart", param).ToString();
                if (kqtv == null || kq < 0) crt.UserID = kq;
                return
                 Ok(crt);
            }
            catch
            {
                return NotFound();
            }
        }
        [Route("api/HelloWebAPIController/Load_Cart")]
        [HttpGet]
        public IHttpActionResult Load_Cart(int userID)
        {
            try
            {
                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("usrID", userID);
                DataTable tb = Database.Read_Table("Load_Cart", param);
                return Ok(tb);
            }
            catch
            {
                return NotFound();
            }
        }
    }
}
