using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AUCPROJECT.Models;
using AUCPROJECT.Class;

namespace AUCPROJECT.Views
{
    public partial class Publicacion : System.Web.UI.Page
    {
        AuctionsDBEntities db;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserLoged"] != null)
            {
                var user = (User)Session["UserLoged"];
                if (user.Control == 0)
                {
                    db = new AuctionsDBEntities();
                    foreach (var category in db.Category.ToList())
                    {
                        CmbCategories.Items.Add(new ListItem() { Value = category.idCategory.ToString(), Text = category.Name + ", " + category.Description });
                    }
                }
                else
                {
                    Response.Redirect("~/Views/Usuarios.aspx");
                }
            }
            else
            {
                Response.Redirect("~/Views/Login.aspx");
            }
            
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                db = new AuctionsDBEntities();
                

                var product = new Product()
                {
                    Name = TxtPrdName.Text,
                    Description = TxtPrdDesc.Text,
                    Specs = TxtPrdSpc.Text,
                    Category = int.Parse(CmbCategories.SelectedValue)
                };

                for(int i = 0; i < Files.PostedFiles.Count; i++)
                {
                  var img = Encrypter.imageToByteArray(System.Drawing.Image.FromStream(Files.PostedFiles[i].InputStream));
                  switch (i)
                    {
                        case 0: product.Product_img = img; break;
                        case 1: product.Product_img_1 = img; break;
                        case 2: product.Product_img_2 = img; break;
                        case 3: product.Product_img_3 = img; break;
                    }

                }
                db.Product.Add(product);

                var date = DateTime.Parse(TxtPrdEndDate.Text);
                var owner = (User)Session["UserLoged"];
                db.Aution.Add(new Aution()
                {
                    FinishDate = date,
                    Product = product,
                    AutionOwner = owner.idUser,
                    AuctionState = 0,
                    InitialPrice = float.Parse(TxtPrdAuc.Text),
                    SoldPrice = float.Parse(TxtPrdPrice.Text)
                });

                db.SaveChanges();  
                Response.Redirect("~/Views/MiCuenta.aspx?fb=0");
            }
            catch (DbEntityValidationException)
            {
                Response.Redirect("~/Views/Publicacion.aspx?fb=0");
            }
        }
    }
}