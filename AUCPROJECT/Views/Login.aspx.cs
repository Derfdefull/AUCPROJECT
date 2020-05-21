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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if(Session["UserLoged"] != null)
            {
                Session["UserLoged"] = null;
            }

        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {

                var db = new AuctionsDBEntities();
                var scrpwd = Encrypter.ToHash(TxtPswLogin.Text);
                var query = db.User.Where(st => st.Nickname == TxtUserLogin.Text && st.Password == scrpwd).ToList();
                if(query.Count != 0)
                {
                    if(query.First().Access == true)
                    {
                        if(query.First().Control == 0)
                        {
                            Session["UserLoged"] = query.First();
                            Response.Redirect("~/Views/MiCuenta.aspx");
                        }
                        else if(query.First().Control == 1)
                        {
                            Session["UserLoged"] = query.First();
                            Response.Redirect("~/Views/Solicitudes.aspx");
                        }
                        else
                            Response.Redirect("~/Views/Login.aspx?fb=3");

                    }
                    else
                        Response.Redirect("~/Views/Login.aspx?fb=3");
                }
                else
                    Response.Redirect("~/Views/Login.aspx?fb=2");

            
        }

        protected void BtnSummit(object sender, EventArgs e)
        {
            try
            {
                string[] keys = Request.Form.AllKeys;
                for (int i = 0; i < keys.Length; i++)
                {
                    if(cmbRegister.Checked != true) { Response.Redirect("~/Views/Login.aspx?fb=4"); }
                    if ((Request.Form[keys[i]] is null || Request.Form[keys[i]].ToString().Trim() == "") && keys[i].ToString().Contains("Register"))
                    {
                        Response.Redirect("~/Views/Login.aspx?fb=4");
                    }
                }

                var dbr = new AuctionsDBEntities();
                var userinfo = new ContactData()
                {
                    Names = TxtNameRegister.Text,
                    Email = TxtEmailRegister.Text
                };
                dbr.ContactData.Add(userinfo);

                dbr.User.Add(new User()
                {
                    Nickname = TxtUsernameRegister.Text,
                    Password = Encrypter.ToHash(TxtPswRegister.Text),
                    ContactData = userinfo,
                    Access = true,
                    Control = 0
                });
                dbr.SaveChanges();
                Response.Redirect("~/Views/Login.aspx?fb=0");
            }
            catch (DbEntityValidationException)
            {
                Response.Redirect("~/Views/Login.aspx?fb=1");
            }
        }

         protected void BtnRegister_Click(object sender, EventArgs e)
            {
                try
                {
                    var dbr = new AuctionsDBEntities();
                    var userinfo = new ContactData()
                    {
                        Names = TxtNameRegister.Text,
                        Email = TxtEmailRegister.Text
                    };
                    dbr.ContactData.Add(userinfo);

                    dbr.User.Add(new User()
                    {
                        Nickname = TxtUsernameRegister.Text,
                        Password = Encrypter.ToHash(TxtPswRegister.Text),
                        ContactData = userinfo,
                        Access = true,
                        Control = 1
                    });
                    dbr.SaveChanges();
                    Response.Redirect("~/Views/Login.aspx?fb=0");
                }
                catch (DbEntityValidationException)
                {
                    Response.Redirect("~/Views/Login.aspx?fb=1");
                }
            }

        protected void BtnHelpLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Help/IniciarSesion.pdf");
        }

        protected void BtnHelpRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Help/Registro.pdf");
        }


    }
}