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
    
    public partial class Ordererd
    {
        public Ordererd()
        {
            this.OrdersDetails = new HashSet<OrdersDetail>();
        }
    
        public int OrderID { get; set; }
        public int CustomerID { get; set; }
        public System.DateTime OrderDate { get; set; }
        public string ReceiverName { get; set; }
        public string ReceiverPhone { get; set; }
        public string ReceiverAddress { get; set; }
        public double TotalPrice { get; set; }
    
        public virtual CUSTOMER CUSTOMER { get; set; }
        public virtual ICollection<OrdersDetail> OrdersDetails { get; set; }
    }
}