//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CommentsTrial.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblChildComment
    {
        public int CommentID { get; set; }
        public string Username { get; set; }
        public string CommentMessage { get; set; }
        public Nullable<System.DateTime> CommentDate { get; set; }
        public Nullable<int> ParentCommentID { get; set; }
    
        public virtual tblParentComment tblParentComment { get; set; }
        public virtual tblUser tblUser { get; set; }
    }
}
