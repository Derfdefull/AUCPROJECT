<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainView.Master" AutoEventWireup="true" CodeBehind="Publicacion.aspx.cs" Inherits="AUCPROJECT.Views.Publicacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="pub-panel">
        <h1 class="text-center p-0 m-0 mt-3 "> Nueva Subasta</h1>
        <h6 class="text-center "> Rellena los siguientes campos de forma correcta para poder publicar una nueva subasta. </h6>
        <h6 class="text-center"> <asp:Button ID="BtnHelpPubli" runat="server" Text="Necesito Ayuda." CssClass="link-help-2 text-center" CausesValidation="False"  target ='_blank' UseSubmitBehavior="False" /> </h6>
           <div class="row">
           
               <div class="form-group col-4 pr-3 pl-3 pb-0">
                  <label> Nombre de Articulo: </label>
                  <asp:TextBox runat="server" ID="TxtPrdName" PlaceHolder="Reloj de Lujo" CssClass="bg-main RC" required> </asp:TextBox>
                  <small> Introduzca el nombre del producto. </small>
               </div>

               <div class="form-group col-4 pr-3 pl-3 pb-0">
                  <label> Precio Directo: </label>
                  <asp:TextBox runat="server" ID="TxtPrdPrice" PlaceHolder="10,000" TextMode="Number" CssClass="bg-main RC" required> </asp:TextBox>
                  <small> Introduzca el valor de compra directa. </small>
               </div>

               <div class="form-group col-4 pr-2 pl-3 pb-0">
                  <label> Precio Inicial: </label>
                  <asp:TextBox runat="server" ID="TxtPrdAuc" PlaceHolder="99,99" TextMode="Number" CssClass="bg-main RC" required> </asp:TextBox>
                  <small> Introduzca el valor inicial de la subasta. </small>
               </div>

                <div class="form-group  col-6 pr-4 pl-4 pb-0">
                  <label> Fecha de Finalizacion: </label>
                  <asp:TextBox runat="server" ID="TxtPrdEndDate"  TextMode="Date" CssClass="bg-main RC" required> </asp:TextBox>
                  <small> Introduzca la fecha de finalizacion. </small>
               </div>

               <div class="form-group col-6 pr-4 pl-4 pb-0">
                  <label> Categoria: </label>
                   <asp:DropDownList ID="CmbCategories" runat="server" CssClass="bg-main RC" required>

                   </asp:DropDownList>
                  <small> Selecciona el valor inicial de la subasta. </small>
               </div>

               <div class="form-group col-6 pr-2 pl-2 pb-0">
                  <label> Descripcion: </label>
                  <asp:TextBox runat="server" ID="TxtPrdDesc" PlaceHolder="Reloj de Lujo marca roljer 2020..." TextMode="MultiLine"  CssClass="bg-main RC" required> </asp:TextBox>
                  <small> Introduzca la descripcion del Articulo. </small>
               </div>

               <div class="form-group col-6 pr-2 pl-2 pb-0">
                  <label> Especificaciones: </label>
                  <asp:TextBox runat="server" ID="TxtPrdSpc" PlaceHolder="*Broche de Oro *Marco de Plata" TextMode="MultiLine"  CssClass="bg-main RC" required> </asp:TextBox>
                  <small> Introduzca las especificaciones del Articulo. </small>
               </div>

               <div class="form-group col-12 pr-2 pl-2 pb-0">
                  <label> Fotografías del producto: </label>
                  <small> Adjunta Fotos de tu Articulo. (Min 1; Max 4) (Formato permitido <strong>.jpeg </strong>) </small>
                   <br />
                    <div class="gallery"></div>
                 
               </div>
               <asp:FileUpload ID="Files" runat="server" accept=".jpeg" required AllowMultiple="True" />
               <br />
               <br />
           </div>
            <asp:Button runat="server" ID="BtnRegister" CssClass="btn btn-sumit mb-2 d-block" Text="Registrar" OnClick="BtnRegister_Click" />
    </div>

    <script src="../Scripts/jquery-3.0.0.js"></script>
               <script>$(function () {
                       // Multiple images preview in browser
                       var imagesPreview = function (input, placeToInsertImagePreview) {

                           if (input.files) {
                               var filesAmount = input.files.length;

                               for (i = 0; i < filesAmount ; i++) {
                                   var reader = new FileReader();

                                   reader.onload = function (event) {
                                       $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
                                   }

                                   reader.readAsDataURL(input.files[i]);
                               }
                           }

                       };

                           $('#ContentPlaceHolder1_Files').on('change', function () {
                           $('div.gallery').empty();
                           imagesPreview(this, 'div.gallery');
                       });
                   });</script>

     <% if (Request.QueryString["fb"] != null)
        { %>
                <% if (Request.QueryString["fb"] == "0")
                   { %>
                            <script>
                                swal("Algo salio mal!", "La subasta no pudo ser registrada", "warning");
                            </script>
                    <%}

                }%>

</asp:Content>
