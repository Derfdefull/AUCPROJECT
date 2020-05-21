<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Admin.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="AUCPROJECT.Views.Usuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1> Usuarios Del Sistema </h1>
    <hr />
    <table class="table border">
  <thead class="thead-dark">
    <tr>
      <th scope="col">Usuario</th>
      <th scope="col">Nombre</th>
      <th scope="col">Correo</th>
      <th scope="col">Acciones</th>
    </tr>
  </thead>
  <tbody>
      <% foreach (var usr in UserList)
          { %>
            <tr>
              <th scope="row"><%= usr.Nickname %></th>
              <td><%= usr.ContactData.Names %></td>
              <td><%= usr.ContactData.Email %></td>
                <%if (usr.Access == true)
                    {%>
                    <td><a href="Usuarios.aspx?block=<%= usr.idUser %>" class="btn btn-warning"> Bloquear Acceso </a></td>
                <%}
                    else
                    {%>
                <td><a href="Usuarios.aspx?undo=<%= usr.idUser %>" class="btn btn-primary"> Conceder Acceso </a></td>

                <%} %>
            </tr>
      <%} %>
  </tbody>
</table> 



    <% if (Request.QueryString["fb"] != null)
        { %>
                <% if (Request.QueryString["fb"] == "0")
                   { %>
                            <script>
                                swal("Usuario Desbloqueado", "El Usuario ya puede iniciar sesion normalmente.", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "1")
                    { %>
                            <script>
                               swal("Usuario Bloqueado!", "El usuario ya no tiene acceso al sistema", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "2")
                    { %>
                            <script>
                                swal("Algo salio mal!", "No se pudo cambiar el acceso del usuario", "error");
                            </script>
                    <%}

                }%>
</asp:Content>
