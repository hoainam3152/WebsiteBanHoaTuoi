//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebsiteHoaTuoi1080.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Category
    {
        public Category()
        {
            this.FlowerDetails = new HashSet<FlowerDetail>();
        }
    
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
    
        public virtual ICollection<FlowerDetail> FlowerDetails { get; set; }
    }
}
