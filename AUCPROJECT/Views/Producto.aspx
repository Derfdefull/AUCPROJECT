<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainView.Master" AutoEventWireup="true" CodeBehind="Producto.aspx.cs" Inherits="AUCPROJECT.Views.Producto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="p-5">

        <div class="row">
            <div class="col-6">
                <div class="detail-product">
                        <h3 class="m-0"> <%= auction.Product.Name %>  </h3>
                        <h4 class="text-muted pl-2"> <small> por <%= db.User.First(st => st.idUser == auction.AutionOwner).ContactData.Names %> </small> </h4>

                        
                        <% if (auction.Product.Product_img != null) ProdImg.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(auction.Product.Product_img); else { Image3.Visible = false; }  %>
                        <% if (auction.Product.Product_img_1 != null) Image1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(auction.Product.Product_img_1);  else { Image3.Visible = false; } %>
                        <% if (auction.Product.Product_img_2 != null) Image2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(auction.Product.Product_img_2); else { Image3.Visible = false; }  %>
                        <%if (auction.Product.Product_img_3 != null) Image3.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(auction.Product.Product_img_3); else { Image3.Visible = false; } %>
                        
                    <div class="row">
                        <div class="col-6">
                            <asp:Image  runat="server" ID="ProdImg"  CssClass="img-product imglo " />
                          </div>
                        <div class="col-6">
                          <asp:Image  runat="server" ID="Image1"  CssClass="img-product imglo "/>
                        </div>
                        <div class="col-6">
                             <asp:Image  runat="server" ID="Image2"  CssClass="img-product imglo "/>
                        </div>
                        <div class="col-6">
                            <asp:Image  runat="server" ID="Image3"  CssClass="img-product imglo"/>
                        </div>
                    </div>
                    
                
                              

                              
                   
                    <br /> <br />
                    <hr />

                        <h3> Descripcion del Producto </h3>
                        <p class="">
                            <%= auction.Product.Description %>
                        </p>

                    <hr />
                        <h3> Especificaciones del producto </h3>
                        <pre class=""> <%= auction.Product.Specs.Trim() %> </pre>

                    </div>
            </div>

             <div class="col-6 text-center">
                 
                        <%if (auction.Bids.Count > 0)
                            {
                                var aux = auction.Bids.ToList().Last();
                                var lastbider = db.User.First(st => st.idUser == aux.Bidder); %>

                            <h3 class="text-center font-weight-bolder text-main"> $<%= aux.Value %> </h3>
                            <h4 class="m-0 text-center"> <%= lastbider.Nickname %> </h4>
                            <h6 class="text-muted text-center "> <small> Mayor Pujador </small> </h6>
                        
                        <%}
                            else
                            {%>
                            <h4> Sin Pujas </h4>
                            <h4> Se el primero en participar! </h4>
                            <h3 class="text-main font-weight-bolder"> Has una puja por solo $<%= auction.InitialPrice %> </h3>
                        
                        <%} %>
                        <h6> Termina en </h6>
                          <ul class="m-0 p-0 time-panel">
                            <li><span id="days"></span></li>
                            <li><span id="hours"></span></li>
                            <li><span id="minutes"></span></li>
                            <li><span id="seconds"></span></li>
                          </ul>
                 <br />

                 <% if (user.idUser != auction.AutionOwner)
                     {
                         var minval = auction.InitialPrice;
                         if(user.Control == 1)
                         {
                             BtnPull.Text = "Hacer una puja por $" + auction.InitialPrice;
                             BtnBuy.Text = "Comprar ahora por $" + auction.SoldPrice;
                             BtnBuy.Enabled = false; BtnPull.Enabled = false; BtnCustom.Enabled = false; TxtBidValue.ReadOnly = true;
                         }
                         else if (auction.Bids.Count > 0)
                         {
                             var bidvalue =  (float)auction.Bids.Count;
                             _ = auction.Bids.Count > 0 ? bidvalue += auction.Bids.Last().Value : bidvalue += 0;
                             BtnPull.Text = "Hacer una puja por $" + bidvalue;
                             BtnBuy.Text = "Comprar ahora por $" + auction.SoldPrice;
                             minval = bidvalue;
                             if (bidvalue > auction.SoldPrice)
                             {
                                 BtnBuy.Visible = false; BtnBuy.Enabled = false;
                             }


                         }
                         else
                         {
                             BtnPull.Text = "Hacer una puja por $" + auction.InitialPrice;
                             BtnBuy.Text = "Comprar ahora por $" + auction.SoldPrice;
                         }
                        %>
                 <br />


                         <div class="d-flex text-center">
                             <div class="col-3"></div>
                             <asp:TextBox runat="server" ID="TxtBidValue" placeholder="Valor de tu puja." CssClass="form-control col-4 " TextMode="number" >  </asp:TextBox>
                             <small class="text-main font-weight-bolder"> ( $<%= minval  %> Min.)</small>
                             <div class="col-3"> <asp:Button ID="BtnCustom" runat="server" CssClass="btn btn-sumit" Text="Pujar" OnClick="BtnCustom_Click" /> </div>
                         </div>
             

                 <hr />
                         <asp:Button ID="BtnPull" runat="server" CssClass="btn btn-sumit" OnClick="BtnPull_Click"/>
                         <asp:Button ID="BtnBuy" runat="server" CssClass="btn btn-sumit" OnClick="BtnBuy_Click"/>
                         
                    <%} else { %>

                    <h2> Eres dueño de esta subasta no puedes participar en ella.</h2>

                    <% } %>
                 
                 <br /> <br />
                 
                 <div class="pool-panel">

                 <% if (auction.Bids.Count > 0)
                     {
                        foreach (var bid in auction.Bids.ToList()) {%>
                 
                         <div class="w-100 bg-main text-white p-1 mt-1">
                             <%= db.User.First(st => st.idUser == bid.Bidder).Nickname %> ! <%= bid.DateTime.ToString("dd/MM/yyyy hh:mm:ss") %> ! $<%= bid.Value %>
                         </div>
                
                         <%}
                     }%>
                 </div>
            </div>
        </div>
    </div>

    <script>
        const second = 1000,
          minute = second * 60,
          hour = minute * 60,
          day = hour * 24;
       let countDown = new Date('<%= auction.FinishDate.ToString("MMM d, yyyy hh:mm:ss.F", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))%>').getTime(),
                                    x = setInterval(function () {  

              let now = new Date().getTime(),
                  distance = countDown - now;

                  document.getElementById('days').innerText = Math.floor(distance / (day)) + ' D',
                  document.getElementById('hours').innerText = Math.floor((distance % (day)) / (hour)) + ' H',
                  document.getElementById('minutes').innerText = Math.floor((distance % (hour)) / (minute)) + ' M',
                  document.getElementById('seconds').innerText = Math.floor((distance % (minute)) / second) + ' S';

              if (distance < 0) {
                  clearInterval(x);
                 document.getElementById('<%= auction.idAution %>').innerHTML = '<li> <span> Ya ha finalizado </span> </li>'
              }

            }, second)

    </script>

     <% if (Request.QueryString["fb"] != null)
        { %>
                <% if (Request.QueryString["fb"] == "0")
                   { %>
                            <script>
                                swal("Puja Realizada!", "Acabas de hacer una puja!", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "1")
                    { %>
                            <script>
                                swal("Subasta Ganada!", "Acabas de comprar este producto.", "success");
                            </script>
                    <%}

                    if (Request.QueryString["fb"] == "2")
                    { %>
                            <script>
                                swal("Uups!", "Lo sentimos, parece que alguien hizo una puja mayor a la tuya!", "warning");
                            </script>
                    <%}
                            if (Request.QueryString["fb"] == "3")
                    { %>
                            <script>
                                swal("Algo salio mal", "el valor ingresado no fue el correcto.", "warning");
                            </script>
                    <%}

                }%>

</asp:Content>
