<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainView.Master" AutoEventWireup="true" CodeBehind="Subastas.aspx.cs" Inherits="AUCPROJECT.Views.Subastas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <%if (AuctionList.Count > 0)
        { %>
            <%foreach (var auction in AuctionList)
                { %>
        <a href="Producto.aspx?id=<%= auction.idAution %>" class="d-block text-decoration-none text-main">
            <div class="auc-panel">
                <div class="row">
                    <div class="col-3">
                        <% ProdImg.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(auction.Product.Product_img); %>
                      <asp:Image  runat="server" ID="ProdImg"  CssClass="img-product"/>
                       
                    </div>
                
                    <div class="col-6">
                        <div class="detail-product">
                            <h3 class="m-0"><%= auction.Product.Name %></h3>
                            <h5 class="text-muted "> <small> por <%= db.User.First(st => st.idUser == auction.AutionOwner).ContactData.Names %> </small> </h5>
                            <p class=" item-desc"> <%= auction.Product.Description %> </p>
                        
                        </div>
                    </div>
                
                    <div class="col-3 text-center">
                        <%if (auction.Bids.Count > 0)
                            {
                                var aux = auction.Bids.ToList().Last();
                                var lastbider = db.User.First(st => st.idUser == aux.Bidder); %>

                            <h3 class="text-center font-weight-bolder"> $<%= aux.Value %> </h3>
                            <h4 class="m-0 text-center"> <%= lastbider.Nickname %> </h4>
                            <h6 class="text-muted text-center "> <small> Mayor Pujador </small> </h6>
                        
                        <%}
                            else
                            {%>
                            <h5 class="text-center"> Sin Pujas </h5>
                            <h6 class="text-center"> Se el primero en participar! </h6>
                            <h5 class="text-center font-weight-bolder"> $<%= auction.InitialPrice %> </h5>
                        
                        <%} %>

                        <h6 class="text-center"> Termina en </h6>
                        <ul id="<%= auction.idAution %>" class="m-0 p-0 time-panel"> </ul>
                        <script>
                            new function () {
                                const second = 1000,
                                    minute = second * 60,
                                    hour = minute * 60,
                                    day = hour * 24;

                                let countDown = new Date('<%= auction.FinishDate.ToString("MMM d, yyyy hh:mm:ss.F", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))%>').getTime(),
                                    x = setInterval(function () {
                               
                                        let d = '<%= auction.idAution %>' + 'days';
                                        let h = '<%= auction.idAution %>'+ 'hours';
                                        let m = '<%= auction.idAution %>' + 'minutes';
                                        let s = '<%= auction.idAution %>' + 'seconds';
                                        console.log(d);
                                        let now = new Date().getTime(),
                                            distance = countDown - now;

                                        document.getElementById('<%= auction.idAution %>').innerHTML = '<li><span id="' + d + '"></span></li> <li><span id="' + h + '"></span></li> <li><span id="' + m + '"></span></li> <li><span id="' + s + '"></span></li>';
       

                                        document.getElementById(d).innerText = Math.floor(distance / (day)) + ' D',
                                            document.getElementById(h).innerText = Math.floor((distance % (day)) / (hour)) + ' H',
                                            document.getElementById(m).innerText = Math.floor((distance % (hour)) / (minute)) + ' M',
                                            document.getElementById(s).innerText = Math.floor((distance % (minute)) / second) + ' S';

                                        
                                        if (distance < 0) {
                                            clearInterval(x);
                                            document.getElementById('<%= auction.idAution %>').innerHTML = '<li> <span> Ya ha finalizado </span> </li>'
                                       }

                                    }, second)
                            }
                        </script>

                    </div>
                </div>        
            </div>
        </a>
    <%} %>
    <%} else { %>
    <div class="text-center text-main m-5 ">
        <h1> Estamos sin subastas :(</h1>
        <h2> Se el primero en subastar un producto! </h2>
        <br />
        <a href="Publicacion.aspx" class="btn btn-sumit" > Crear publicacion </a>
        <hr />

    </div>
   
        
    <%} %>
</asp:Content>
