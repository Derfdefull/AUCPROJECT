//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AUCPROJECT.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Bids
    {
        public int idBid { get; set; }
        public System.DateTime DateTime { get; set; }
        public float Value { get; set; }
        public int Bidder { get; set; }
        public Nullable<int> Aution { get; set; }
    
        public virtual Aution Aution1 { get; set; }
    }
}
