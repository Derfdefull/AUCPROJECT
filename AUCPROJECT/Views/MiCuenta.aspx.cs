using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AUCPROJECT.Models;
namespace AUCPROJECT.Views
{
    public partial class MiCuenta : System.Web.UI.Page
    {

        protected AuctionsDBEntities db;
        protected User user;
        protected List<Aution> MyAuctList;
        protected List<Aution> AcAuctList;
        protected List<Aution> WonAuctList;
        protected List<Aution> FAuctList;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["UserLoged"] != null)
            {
                user = (User)Session["UserLoged"];
                if(user.Control == 0)
                {
                    db = new AuctionsDBEntities();
                    MyAuctList = db.Aution.Where(st => st.AutionOwner == user.idUser).ToList();
                    WonAuctList = db.Aution.Where(st => st.AuctionBuyer == user.idUser).ToList();
                    FAuctList = new List<Aution>();
                    AcAuctList = new List<Aution>();

                    var PAuctions = db.Bids.Where(st => st.Bidder == user.idUser).Select(st => st.Aution1).Distinct().ToList();
                   foreach (var aution in PAuctions)
                    {
                        if(aution.FinishDate < DateTime.Now)
                            FAuctList.Add(aution);
                        else
                            AcAuctList.Add(aution);
                    }
                }
                else
                {
                    Response.Redirect("~/Views/Usuarios.aspx");
                }
            }
            else
            {
                Response.Redirect("~/Views/Login.aspx?fb=5");
            }
        }
    }
}