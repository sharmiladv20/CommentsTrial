using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CommentsTrial.Models;

namespace CommentsTrial.Controllers
{
    public class RegisterController : Controller
    {
        // GET: UserLogin
        [HttpGet]
        public ActionResult RegisterUser(int id = 0)
        {
            tblUser users = new tblUser();
            return View(users);
        }
        // GET: UserLogin
        [HttpPost]
        public ActionResult RegisterUser(tblUser userModel)
        {
            using (CommentSystemEntities db = new CommentSystemEntities())
            {
                var user = db.tblUsers.Where(u => u.Username.ToLower() == userModel.Username.ToLower()).FirstOrDefault();
                if (user == null)
                {
                    db.tblUsers.Add(userModel);
                    db.SaveChanges();
                    ModelState.Clear();
                    return RedirectToAction("LoginUser", "Login");

                }
                else
                {
                    ViewBag.message = "User Already Exists, Please Login";
                    ModelState.Clear();
                    return RedirectToAction("LoginUser", "Login");

                }

            }
        }

    }




}