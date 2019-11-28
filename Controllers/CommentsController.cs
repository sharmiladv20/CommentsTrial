using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CommentsTrial.Models;
using CommentsTrial.ViewModels;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace CommentsTrial.Controllers
{
    public class CommentsController : Controller
    {
        private CommentSystemEntities db = new CommentSystemEntities();

        // GET: Comments
        [HttpGet]
        public ActionResult GetUsers()
        {
            return View();
        }
        [HttpPost]
        // Post: Comments
        public ActionResult GetUsers(string username)
        {
            using (CommentSystemEntities db = new CommentSystemEntities())
            {
                var user = db.tblUsers.Where(u => u.Username.ToLower() == username.ToLower()).FirstOrDefault();
                if (user != null)
                {
                    Session["Username"] = user.Username;
                    return RedirectToAction("GetPosts");

                }
                ViewBag.message = "User Name does not exists";
                return View();
            }
        }
        // Get All Posts from tblPosts
        [HttpGet]
        public ActionResult GetPosts()
        {
            if (Session["Username"]==null)
            {
                return RedirectToAction("LoginUser", "Login");
            }
            IQueryable<PostsVM> posts = db.tblPosts.Select(p => new PostsVM
            {
                PostID = p.PostID,
                Message = p.Message,
                PostedDate = p.PostedDate.Value
            }).AsQueryable();
            return View(posts);
        }

        //Get Comments
        public PartialViewResult GetComments(int postId)
        {
            IQueryable<ParentCommentVM> comments = db.tblParentComments.Where(c => c.PostID == postId)
                                                .Select(c => new ParentCommentVM
                                                {
                                                    CommentID = c.CommentID,
                                                    CommentDate = c.CommentDate.Value,
                                                    CommentMessage = c.CommentMessage,
                                                    Username = c.Username
                                                }).AsQueryable();

            return PartialView("~/Views/Shared/GetComments.cshtml", comments);
        }

        //Add Comments
        [HttpPost]
        public ActionResult AddComment(ParentCommentVM comment, int postId)
        {
            //bool result = false;  
            tblParentComment commentEntity = null;
            string username = (string)Session["Username"];

            var user = db.tblUsers.FirstOrDefault(u => u.Username == username);
            var post = db.tblPosts.FirstOrDefault(p => p.PostID == postId);

            if (comment != null)
            {
                commentEntity = new tblParentComment
                {
                    CommentMessage = comment.CommentMessage,
                    CommentDate = comment.CommentDate,
                };

                if (user != null && post != null)
                {
                    post.tblParentComments.Add(commentEntity);
                    user.tblParentComments.Add(commentEntity);
                    

                    db.SaveChanges();
                }
            }
            return RedirectToAction("GetComments", "Comments", new { postId = postId });
        }

        //Get SubComments
        [HttpGet]
        public PartialViewResult GetSubComments(int ComID)
        {
            IQueryable<ChildCommentVM> subComments = db.tblChildComments.Where(sc => sc.tblParentComment.CommentID == ComID)
                                       .Select(sc => new ChildCommentVM
                                       {
                                           CommentID = sc.CommentID,
                                           CommentMessage = sc.CommentMessage,
                                           CommentDate = sc.CommentDate.Value,
                                           Username = sc.Username
                                       }).AsQueryable();
            return PartialView("~/Views/Shared/GetSubComments.cshtml", subComments);
        }

        //Add SubComment
        [HttpPost]
        public ActionResult AddSubComment(tblChildComment subComment, int ComID)
        {
            tblChildComment subCommentEntity = null;
            string username = (string)Session["Username"];

            var user = db.tblUsers.FirstOrDefault(u => u.Username == username);
            var comment = db.tblParentComments.FirstOrDefault(p => p.CommentID == ComID);

            if (subComment != null)
            {
                subCommentEntity = new tblChildComment
                {
                    CommentMessage = subComment.CommentMessage,
                    CommentDate = subComment.CommentDate,
                };
                if (user != null && comment != null)
                {
                    comment.tblChildComments.Add(subCommentEntity);
                    user.tblChildComments.Add(subCommentEntity);
                    db.SaveChanges();
                    //result = true;  
                }
            }
            return RedirectToAction("GetSubComments", "Comments", new { ComID = ComID });
        }
    }
}
