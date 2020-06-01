using AUCPROJECT.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AUCPROJECT.Views
{
    public partial class ASubastas : System.Web.UI.Page
    {

        protected AuctionsDBEntities db;
        protected List<Aution> auctList;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserLoged"] != null)
            {
                var user = (User)Session["UserLoged"];
                if (user.Control == 1)
                {
                    db = new AuctionsDBEntities();
                    auctList = db.Aution.ToList();

                }
                else
                {
                    Response.Redirect("~/Views/MiCuenta.aspx");
                }
            }
            else
            {
                Response.Redirect("~/Views/Login.aspx?fb=5");
            }
        }
    }
}