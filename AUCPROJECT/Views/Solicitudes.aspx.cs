using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AUCPROJECT.Models;

namespace AUCPROJECT.Views
{
    public partial class Solicitudes : System.Web.UI.Page
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
                    auctList = db.Aution.Where(st => st.AuctionState == 0).ToList();

                    try
                    {
                        if (Request.QueryString["A"] != null)
                        {
                            var id = int.Parse(Request.QueryString["A"]);
                            var aution = db.Aution.First(st => st.idAution == id);
                            aution.AuctionState = 1;
                            db.SaveChanges();
                            Response.Redirect("~/Views/Solicitudes.aspx?fb=0");
                        }
                        if (Request.QueryString["notA"] != null)
                        {
                            var id = int.Parse(Request.QueryString["notA"]);
                            var aution = db.Aution.First(st => st.idAution == id);
                            db.Product.Remove(aution.Product);
                            db.Aution.Remove(aution);
                            db.SaveChanges();
                            Response.Redirect("~/Views/Solicitudes.aspx?fb=1");
                        }

                    }
                    catch (DbEntityValidationException)
                    {
                        Response.Redirect("~/Views/Solicitudes.aspx?fb=2");
                    }
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