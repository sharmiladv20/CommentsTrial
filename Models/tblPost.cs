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
    
    public partial class tblPost
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblPost()
        {
            this.tblParentComments = new HashSet<tblParentComment>();
        }
    
        public int PostID { get; set; }
        public string Message { get; set; }
        public Nullable<System.DateTime> PostedDate { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblParentComment> tblParentComments { get; set; }
        public virtual tblPost tblPosts1 { get; set; }
        public virtual tblPost tblPost1 { get; set; }
    }
}
