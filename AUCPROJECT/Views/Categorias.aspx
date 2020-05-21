<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Admin.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="AUCPROJECT.Views.Categorias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1> Productos </h1>

    <% if (Request.QueryString["New"] != null){%>
        <h2> Nueva Categoria </h2>
        <hr />
        <div class="row">

            <div class="form-group col-4">
                <div class=" d-flex">
                   <label class="p-1"> Nombre: </label>
                   <asp:TextBox runat="server" ID="TxtCategoryName" PlaceHolder="Joyeria" CssClass="form-control"  required> </asp:TextBox>
                </div>
            </div>

            <div class="form-group col-6">
                <div class=" d-flex">
                   <label class="p-1"> Descripcion: </label>
                   <asp:TextBox runat="server" ID="TxtCategoryDescription" PlaceHolder="Accesorios de oro: Relojes, Anillos, Collares, etc." CssClass="form-control"  required> </asp:TextBox>
                </div>
            </div>
            
            <div class="form-group col-2">
                <div class=" d-flex">
                   <asp:Button runat="server" ID="BtnAdd" Text="Registrar" CssClass="btn btn-primary" OnClick="BtnAdd_Click" />
                </div>
            </div>

        </div>
    <%} %>



    <% else if (Request.QueryString["Edit"] != null){
            var id = int.Parse(Request.QueryString["Edit"]);
            var cat = db.Category.First(st => st.idCategory == id);
            %>
        <h2> Editar Categoria </h2>
        <hr />
        <div class="row">

            <div class="form-group col-4">
                <div class=" d-flex">
                   <label class="p-1"> Nombre: </label>
                    <%TxtECategoryName.Text = cat.Name; %>
                   <asp:TextBox runat="server" ID="TxtECategoryName" PlaceHolder="Joyeria" CssClass="form-control"  required> </asp:TextBox>
                </div>
            </div>

            <div class="form-group col-6">
                <div class=" d-flex">
                   <label class="p-1"> Descripcion: </label>
                    <%TxtECategoryDescription.Text = cat.Description; %>
                    <asp:TextBox runat="server" ID="TxtECategoryDescription" PlaceHolder="Accesorios de oro: Relojes, Anillos, Collares, etc." CssClass="form-control"  required> </asp:TextBox>
                </div>
            </div>
            
            <div class="form-group col-2">
                <div class=" d-flex">
                   <asp:Button runat="server" ID="BtnEdit" Text="Guardar" CssClass="btn btn-primary" OnClick="BtnEdit_Click"  />
                </div>
            </div>

        </div>
    <%} %>
    
    <h2> Productos Permitidos <strong>(Categorias)</strong></h2>
    <hr />
       <div class="d-block">
        <a href="Categorias.aspx?New=true" class="btn btn-success" style="float: right;"> Nuevo </a>
       </div>
    <br />
    <hr />
    <table class="table border">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Categoria</th>
          <th scope="col">Descripcion</th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
          <% foreach (var category in CatList)
          { %>
            
            <tr>
              <th scope="row"><%= category.Name %></th>
              <td><%= category.Description %></td>
              <td>
                  <a href="Categorias.aspx?Edit=<%= category.idCategory %>" class="btn btn-warning"> Editar  </a>
                  <a href="Categorias.aspx?Delete=<%= category.idCategory %>" class="btn btn-danger"> Eliminar </a>
              </td>
            </tr>

        <%} %>
      </tbody>
    </table>
  



     <% if (Request.QueryString["fb"] != null)
        { %>
                <% if (Request.QueryString["fb"] == "0")
                   { %>
                            <script>
                                swal("Categoria Registrada", "La categoria fue registrada.", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "1")
                    { %>
                            <script>
                                swal("Categoria Editada!", "La categoria fue editada", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "2")
                    { %>
                            <script>
                                swal("Algo salio mal!", "Error al registrar la categoria", "warning");
                            </script>
                    <%}

                     if (Request.QueryString["fb"] == "3")
                    { %>
                            <script>
                                swal("Algo salio mal!", "Error al editar la categoria", "warning");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "4")
                    { %>
                            <script>
                                swal("Categoria Eliminada!", "La categoria fue eliminada", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "5")
                    { %>
                            <script>
                                swal("Imposible eliminar categoria!", "No se puede eliminar esta categoria, debido a que se encuentra en uso.", "error");
                            </script>
                    <%}
                }%>
</asp:Content>
