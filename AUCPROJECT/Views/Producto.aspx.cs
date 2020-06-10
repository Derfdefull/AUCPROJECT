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
    public partial class Producto : System.Web.UI.Page
    {
        protected AuctionsDBEntities db;
        protected Aution auction;
        protected User user;
        protected string idprod;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserLoged"] != null)
            {
                if (Request.QueryString["id"] != null)
                {
                    idprod = Request.QueryString["id"];
                    db = new AuctionsDBEntities();
                    user = (User)Session["UserLoged"];
                    var id = int.Parse(Request.QueryString["id"]);
                    auction = db.Aution.First(st => st.idAution == id);
                    if(auction.FinishDate <= DateTime.Now && auction.AuctionBuyer == null)
                    {
                        var winner = db.Aution.Where(st => st.idAution == auction.idAution).First();
                        winner.AuctionBuyer = auction.Bids.Last().Bidder;
                        db.SaveChanges();
                        Response.Redirect("~/Views/MiCuenta.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/Views/Login.aspx");
                }
            }
            else
            {
                Response.Redirect("~/Views/Login.aspx?fb=5");
            }
        }

        protected void BtnPull_Click(object sender, EventArgs e)
        {
            try
            {
                var bidvalue = (float)auction.Bids.Count;
                _ = auction.Bids.Count > 0 ? bidvalue += auction.Bids.Last().Value : bidvalue += auction.InitialPrice;
                var bid = new Bids()
                {
                    Value = bidvalue,
                    Bidder = user.idUser,
                    DateTime = DateTime.Now,
                    Aution = auction.idAution
                };
                auction.Bids.Add(bid);
                if (bid.Value < auction.Bids.Last().Value)
                {
                    Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=2", idprod));
                }
                db.SaveChanges();
                Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=0", idprod));
            }
            catch (DbEntityValidationException)
            {
                Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}", idprod));
            }
        }

        protected void BtnBuy_Click(object sender, EventArgs e)
        {
            try
            {
                var bidvalue = (float)auction.Bids.Count;
                _ = auction.Bids.Count > 0 ? bidvalue += auction.Bids.Last().Value : bidvalue += auction.InitialPrice;
                var bid = new Bids()
                {
                    Value = bidvalue,
                    Bidder = user.idUser,
                    DateTime = DateTime.Now,
                    Aution = auction.idAution
                };
                auction.Bids.Add(bid);
                auction.AuctionBuyer = user.idUser;
                if (bid.Value < auction.Bids.Last().Value)
                {
                    Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=2", idprod));
                }
                db.SaveChanges();
                Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=0", idprod));
            }
            catch (DbEntityValidationException)
            {
                Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}", idprod));
            }
            
        }

        protected void BtnCustom_Click(object sender, EventArgs e)
        {
            try
            {
                if(TxtBidValue.Text.Trim() != "" )
                {
                    try
                    {
                       float value = 0;
                       value = float.Parse(TxtBidValue.Text);

                        var bid = new Bids()
                        {
                            Value = value,
                            Bidder = user.idUser,
                            DateTime = DateTime.Now,
                            Aution = auction.idAution
                        };
                        auction.Bids.Add(bid);

                        if (bid.Value < auction.Bids.Last().Value)
                        {
                            Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=2", idprod));
                        }
                        db.SaveChanges();
                        Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=0", idprod));
                    }
                    catch (Exception)
                    {
                        Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=3", idprod));
                    }
                }
                Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}&fb=3", idprod));
            }
            
            catch (DbEntityValidationException)
            {
                Response.Redirect(string.Format("~/Views/Producto.aspx?id={0}", idprod));
            }
            
        }
    }
}