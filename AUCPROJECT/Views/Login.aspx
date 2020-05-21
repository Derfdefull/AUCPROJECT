<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainView.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AUCPROJECT.Views.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title> Login </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="bg-Login">
        <div class="row">
            <div class="col-6">
                <div class="loginPanel bg-main">                  
                    <h1 class="text-center"> Iniciar Sesion </h1>
                     <br />
                    
                    <div class="form-group">
                        <label> Usuario: </label>
                        <asp:TextBox runat="server" ID="TxtUserLogin" PlaceHolder="Kardas1997" CssClass="LC" style="color: indigo;" > </asp:TextBox>
                        <small> Introduzca su Nombre de Usuario. </small>
                    </div>

                    <div class="form-group">
                        <label> Contraseña: </label>
                        <asp:TextBox runat="server" ID="TxtPswLogin" PlaceHolder="*************" CssClass="LC text-main" style="color: indigo;" TextMode="Password"> </asp:TextBox>
                        <small> Introduzca su Contraseña. </small>
                    </div>
                        <br />
                        <h6 class="text-center"> <a> Olvide mi contraseña. </a> </h6>
                        <h6 class="text-center"> <asp:Button ID="BtnHelpLogin" runat="server" Text="Necesito Ayuda." CssClass="link-help text-center" CausesValidation="False" OnClick="BtnHelpLogin_Click" target ='_blank' UseSubmitBehavior="False" /> </h6>
                        <br /> <br />

                    <asp:Button runat="server" ID="BtnLogin" CssClass="btn btn-sumit-2" Text="Ingresar" OnClick="BtnLogin_Click" />
               
                </div>
            </div>
            <div class="col-6">
                <div class="loginPanelRegister">
                    <div class="RegisterPanel bg-white">
                        
                        <h1 class="text-center p-0 m-0 mt-3 "> Crea una Cuenta </h1>
                        <h6 class="text-center "> Rellena todos los campos con tu informacion </h6>
                        <h6 class="text-center"> 
                            <asp:Button ID="BtnHelpRegister" runat="server" Text="Necesito Ayuda." CssClass="link-help-2 text-center" CausesValidation="False"  target ='_blank' UseSubmitBehavior="False" OnClick="BtnHelpRegister_Click" /> </h6>
                            <div class="row">

                                <div class="form-group col-12 pr-5 pl-5 pb-0">
                                    <label> Nombre: </label>
                                    <asp:TextBox runat="server" ID="TxtNameRegister" PlaceHolder="Ivan Kardas" CssClass="bg-main RC"  > </asp:TextBox>
                                    <small> Introduzca su Nombre Completo. </small>
                                </div>

                                <div class="form-group col-6 pr-1 pt-0 pb-0">
                                    <label> Usuario: </label>
                                    <asp:TextBox runat="server" ID="TxtUsernameRegister" PlaceHolder="Kardas1997" CssClass="bg-main RC "  > </asp:TextBox>
                                    <small> Introduzca un nombre de Usuario. </small>
                                </div>

                                <div class="form-group col-6 pl-1 pt-0 pb-0">
                                    <label> Contraseña: </label>
                                    <asp:TextBox runat="server" ID="TxtPswRegister" PlaceHolder="*************" CssClass="bg-main RC " TextMode="Password" > </asp:TextBox>
                                    <small> Introduzca una Contraseña. </small>
                                </div>
                             
                                <div class="form-group col-12 pr-5 pl-5 pt-0 pb-0">
                                    <label> Correo Electronico: </label>
                                    <asp:TextBox runat="server" ID="TxtEmailRegister" PlaceHolder="Ivan.Kardas@ESauctions.com" TextMode="Email" CssClass="bg-main RC" > </asp:TextBox>
                                    <small> Introduzca su Correo Electronico. </small>
                                </div>

                                <div class="form-group col-12 pr-5 pl-5 pt-0 pb-0">
                                   <input runat="server" type="checkbox" class="check" id="cmbRegister" /> Acepto los terminos y Condiciones.
                                </div>

                                
                                <asp:Button runat="server" ID="BtnRegister" CssClass="btn btn-sumit" Text="Registrar" OnClick="BtnSummit" />
                           
                                </div> 
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <% if (Request.QueryString["fb"] != null)
        { %>
                <% if (Request.QueryString["fb"] == "0")
                   { %>
                            <script>
                                swal("Creacion de Cuenta exitosa!", "Has creado tu cuenta, utiliza el panel de sesion para poder ingresar.", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "1")
                    { %>
                            <script>
                               swal("Algo salio mal!", "Fallo al crear la cuenta, puede que el nombre de usuario o correo electronico ya exista en nuestro sistema", "warning");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "2")
                    { %>
                        <script>
                            swal("Algo salio mal!", "Constraseña o Usuario incorrecto", "warning");
                        </script>
                    <%}
                        if (Request.QueryString["fb"] == "3")
                    { %>
                        <script>
                            swal("Cuenta Baneada!", "Un administrador a deshabilitado tu cuenta por incumplir normas, ponte en contacto con servicio al cliente.", "error");
                        </script>
                    <%}

                          if (Request.QueryString["fb"] == "4")
                    { %>
                        <script>
                            swal("Campos vacios", "No se aceptan campos vacios", "error");
                        </script>
                    <%}
                }%>

</asp:Content>
