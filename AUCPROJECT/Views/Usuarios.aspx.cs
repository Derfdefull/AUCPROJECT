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
    public partial class Usuarios : System.Web.UI.Page
    {
        protected AuctionsDBEntities db;
        protected List<User> UserList;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserLoged"] != null)
            {
                var user = (User)Session["UserLoged"];
                if (user.Control == 1)
                {
                    db = new AuctionsDBEntities();
                    UserList = db.User.Where(st => st.Control == 0).ToList();
                    if (Request.QueryString["block"] != null)
                    {
                        setAccessToUser(int.Parse(Request.QueryString["block"]));
                    }
                    else if (Request.QueryString["undo"] != null)
                    {
                        setAccessToUser(int.Parse(Request.QueryString["undo"]));
                    }
                }
                else
                {
                    Response.Redirect("~/Views/MiCuenta.aspx");
                }
            }
            else
            {
                Response.Redirect("~/Views/Login.aspx");
            }
            
        }


        private void setAccessToUser(int id)
        {
            try
            {
                var user = db.User.First(st => st.idUser == id);
                if (user.Access == true)
                {
                    user.Access = false;
                    db.SaveChanges();
                    Response.Redirect("~/Views/Usuarios.aspx?fb=1");
                }
                else
                {
                    user.Access = true;
                    db.SaveChanges();
                    Response.Redirect("~/Views/Usuarios.aspx?fb=0");
                }
            }
            catch (DbEntityValidationException)
            {
                Response.Redirect("~/Views/Usuarios.aspx?fb=2");
            }
            
        }
    }
}