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
    
    public partial class OrdersDetail
    {
        public int OrderID { get; set; }
        public int FlowerID { get; set; }
        public int Quantity { get; set; }
        public double Price { get; set; }
        public double SumPrice { get; set; }
    
        public virtual Ordererd Ordererd { get; set; }
    }
}
