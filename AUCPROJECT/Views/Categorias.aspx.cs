using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AUCPROJECT.Models;

namespace AUCPROJECT.Views
{
    public partial class Categorias : System.Web.UI.Page
    {
        protected AuctionsDBEntities db;
        protected List<Category> CatList;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserLoged"] != null)
            {
                var user = (User)Session["UserLoged"];
                if (user.Control == 1)
                {
                    db = new AuctionsDBEntities();
                    CatList = db.Category.ToList();

                    if (Request.QueryString["Delete"] != null)
                    {
                        DeleteCategory(int.Parse(Request.QueryString["Delete"]));
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

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                db = new AuctionsDBEntities();
                db.Category.Add(new Category()
                {
                    Name = TxtCategoryName.Text,
                    Description = TxtCategoryDescription.Text
                }); db.SaveChanges();
                Response.Redirect("~/Views/Categorias.aspx?fb=0");
            }
            catch (DbEntityValidationException)
            {
                Response.Redirect("~/Views/Categorias.aspx?fb=2");
            }
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                db = new AuctionsDBEntities();
                var id = int.Parse(Request.QueryString["Edit"]);
                var cat = db.Category.First(st => st.idCategory == id);
                cat.Name = TxtECategoryName.Text;
                cat.Description = TxtECategoryDescription.Text;
                db.SaveChanges();
                Response.Redirect("~/Views/Categorias.aspx?fb=1");
            }
            catch (DbUpdateException)
            {
                Response.Redirect("~/Views/Categorias.aspx?fb=3");
            }
        }


        private void DeleteCategory(int id)
        {
            try
            {
                db = new AuctionsDBEntities();
                var category = db.Category.First(st => st.idCategory == id);
                db.Category.Remove(category);
                db.SaveChanges();
                Response.Redirect("~/Views/Categorias.aspx?fb=4");
            }
            catch (DbUpdateException)
            {
                Response.Redirect("~/Views/Categorias.aspx?fb=5");
            }
           
        }
    }
}