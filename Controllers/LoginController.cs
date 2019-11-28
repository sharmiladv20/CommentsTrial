using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CommentsTrial.Models;

namespace CommentsTrial.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult LoginUser()
        {
            return View();

        }
        [HttpPost]
        public ActionResult Authorize( tblUser userModel)
        {
            using (CommentSystemEntities db = new CommentSystemEntities())
            {
                var userDetails = db.tblUsers.Where(x => x.Username == userModel.Username && x.Password == userModel.Password ).FirstOrDefault();
                if (userDetails== null)
                {
                    userModel.UserErrorMessage = "Wrong User Name or Password";
                    return View("LoginUser", userModel);
                }
                else
                {
                    Session["Username"] = userDetails.Username;
                    return RedirectToAction("GetPosts", "Comments");
                }
            }
               
        }
        
    }
}