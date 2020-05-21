<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Admin.Master" AutoEventWireup="true" CodeBehind="Solicitudes.aspx.cs" Inherits="AUCPROJECT.Views.Solicitudes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1> Subastas </h1>
    <hr />
    <h2> Solicitudes de Subastas </h2>
    <hr />

    <table class="table border">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Nombre</th>
          <th scope="col">Precio Inicial</th>
          <th scope="col">Fecha de Finalizacion </th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
          <% foreach (var auct in auctList)
          { %>
            <tr>
          <th scope="row"> <%= auct.Product.Name %> </th>
          <td> $<%= auct.InitialPrice %></td>
          <td><%= auct.FinishDate %></td>             
          <td>
              <a href="Producto.aspx?id=<%= auct.idAution %>" class="btn btn-primary" target="_blank"> Ver </a>
              <a href="Solicitudes.aspx?A=<%= auct.idAution %>" class="btn btn-success"> Aceptar </a>
              <a href="Solicitudes.aspx?notA=<%= auct.idAution %>" class="btn btn-danger float-right"> Rechazar </a>
          </td>
      <%} %>
        
        
      </tbody>
    </table> 


    <% if (Request.QueryString["fb"] != null)
        { %>
                <% if (Request.QueryString["fb"] == "0")
                   { %>
                            <script>
                                swal("Solicitud Aceptada", "La subasta fue concedida para el usuario.", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "1")
                    { %>
                            <script>
                               swal("Solicitud Denegada!", "Se le denego la subasta al usuario", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "2")
                    { %>
                            <script>
                                swal("Algo salio mal!", "Intente mas tarde.", "error");
                            </script>
                    <%}

                }%>
</asp:Content>
