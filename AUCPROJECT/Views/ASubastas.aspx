<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Admin.Master" AutoEventWireup="true" CodeBehind="ASubastas.aspx.cs" Inherits="AUCPROJECT.Views.ASubastas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1> Subastas </h1>
    <hr />

    <table class="table border">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Dueño subasta</th>
          <th scope="col">Nombre</th>
          <th scope="col">Precio Inicial</th>
          <th scope="col">Fecha de Finalizacion </th>
          <th scope="col">Puja mayor</th>
          <th scope="col">Ganancia neta</th>
          <th scope="col">Acciones</th>
        </tr>
      </thead>
      <tbody>
          <% foreach (var auct in auctList)
          { %>
            <tr>
          <th scope="row"> <%= db.User.Where(st => st.idUser == auct.AutionOwner).First().ContactData.Names %> </th>
          <th scope="row"> <%= auct.Product.Name %> </th>
          <td> $<%= auct.InitialPrice %></td>
          <td><%= auct.FinishDate %></td>  
          <td>$<%= auct.Bids.Last().Value %> </td>
          <td>$<%=auct.Bids.Last().Value - auct.Bids.Count %> </td>
          <td>
              <a href="Producto.aspx?id=<%= auct.idAution %>" class="btn btn-primary" target="_blank"> Ver </a>

          </td>
      <%} %>
        
        
      </tbody>
    </table> 
</asp:Content>
