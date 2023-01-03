﻿using System;
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
    }
}