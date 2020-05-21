using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AUCPROJECT.Models;
using AUCPROJECT.Class;

namespace AUCPROJECT.Views
{
    public partial class Subastas : System.Web.UI.Page
    {
        protected AuctionsDBEntities db;
        protected List<Aution> AuctionList;   
        protected void Page_Load(object sender, EventArgs e)
        {
            
            db = new AuctionsDBEntities();
            AuctionList = db.Aution.Where(st => st.AuctionState == 1).ToList();

        }
    }
}