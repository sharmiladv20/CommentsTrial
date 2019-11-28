using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CommentsTrial.ViewModels
{
    public class PostsVM
    {
        public int PostID { get; set; }
        public string Message { get; set; }
        public Nullable<System.DateTime> PostedDate { get; set; }
    }

    public class ParentCommentVM
    {
        public int CommentID { get; set; }
        public string Username { get; set; }
        public string CommentMessage { get; set; }
        public Nullable<System.DateTime> CommentDate { get; set; }
        public PostsVM Posts { get; set; }
    }

    public class ChildCommentVM
    {
        public int CommentID { get; set; }
        public string Username { get; set; }
        public string CommentMessage { get; set; }
        public Nullable<System.DateTime> CommentDate { get; set; }
        public ParentCommentVM ParentComments { get; set; }
    }
}
