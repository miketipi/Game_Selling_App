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
        [Route("api/LoaiGame/GameList")]
        [HttpGet]
       
            
    }
}
