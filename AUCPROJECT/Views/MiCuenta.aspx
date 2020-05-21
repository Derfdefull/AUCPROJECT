<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainView.Master" AutoEventWireup="true" CodeBehind="MiCuenta.aspx.cs" Inherits="AUCPROJECT.Views.MiCuenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <h2 class="text-main"> <%= user.ContactData.Names %> </h2>

    <hr />
    <div class="container">    
    
    <h3 class="text-main"> Publicaciones</h3> <a href="Publicacion.aspx" class="btn btn-sumit " style="float:right"> Crear publicacion </a>
        <br />
        
       <h4> Tus Publicaciones </h4>
        
        <%if (MyAuctList.Count > 0)
        { %>
            <%foreach (var auction in MyAuctList)
                { %>

        <h6 class="text-center text-main"> <%= auction.AuctionState == 0 ? 
          "Los Administradores aun no han aprobado tu publicacion, espera un poco.<br> <strong> Importante: Si tu Publicacion desaparece, Significa que los administradores rechazaron tu subasta.</strong>" :
          "Tu Publicacion fue aceptada!, los usuarios ya pueden realizar pujas." %> 
        </h6>

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
                
                    <div class="col-3">
                        <%if (auction.Bids.Count > 0)
                            {
                                var aux = auction.Bids.ToList().Last();
                                var lastbider = db.User.First(st => st.idUser == aux.Bidder); %>

                            <h3 class="text-center font-weight-bold"> $<%= aux.Value %> </h3>
                            <h4 class="m-0 text-center"> <%= lastbider.Nickname %> </h4>
                            <h6 class="text-muted text-center "> <small> Mayor Pujador </small> </h6>
                        
                        <%}
                            else
                            {%>
                            <h5 class="text-center"> Sin Pujas </h5>
                            <h6 class="text-center"> Espera hasta que alguien participe. </h6>
                            <h5 class="text-center font-weight-bolder"> Valor Actual: $<%= auction.InitialPrice %> </h5>
                        
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
                                        let h = '<%= auction.idAution %>' + 'hours';
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
        <h1> No has publicado ninguna subasta aun. </h1>
        <h2> publica una pulsando el boton de abajo! </h2>
        <br />
        <a href="Publicacion.aspx" class="btn btn-sumit" > Crear publicacion </a>
        <hr />

    </div>  
    <%} %>


        <br />
        <br />

    <h3 class="text-main"> Mis Subastas </h3>
        <br />
     <nav class="bg-main border-radius rounded-border-top rounded ">
              <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <a class="nav-item nav-link active notes-link" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Activas</a>
                <a class="nav-item nav-link notes-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Ganadas</a>
                <a class="nav-item nav-link notes-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Finalizadas</a>
              </div>
            </nav>

            <div class="tab-content bg-main notes p-4" id="nav-tabContent">

          <!-- Subastas Activas -->
              <div class="tab-pane fade show active m-2" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
             <%foreach(var auct in AcAuctList) { %>
                 
                  <div class="note-card p-2 m-2" >
                      <a href="Producto.aspx?id=<%= auct.idAution %>" class="btn link d-flex" style="font-size: 12px; text-decoration:none ; "> 
                        <div class="detail-product">
                      
                            <img class="img-product " src="<%= ("data:image/jpeg;base64," + Convert.ToBase64String(auct.Product.Product_img)) %>"  />
                        
                        <h4 class="m-0"> <%= auct.Product.Name %>  </h4>
                        <h6 class="text-muted "> <small> por por <%= db.User.First(st => st.idUser == auct.AutionOwner).ContactData.Names %> </small> </h6>

                    <h6> Descripcion del Producto </h6>
                        <p class=" item-desc"> 
                            <%= auct.Product.Description %>
                        </p>
                        
                             <% var aux = auct.Bids.ToList().Last();
                                var lastbider = db.User.First(st => st.idUser == aux.Bidder); %>

                            <h4 class="text-center font-weight-bolder text-main"> $<%= aux.Value %> </h4>
                            <h4 class="m-0 text-center"> <%= lastbider.Nickname %> </h4>
                            <h6 class="text-muted text-center "> <small> Mayor Pujador </small> </h6>
                        <h6> Termina en </h6>
                          <ul id="<%= auct.idAution %>" class="m-0 p-0 time-panel">
                            
                          </ul>
                    </div>
                    </a>
                  </div>

                  <script>
                      new function () {
                          const second = 1000,
                              minute = second * 60,
                              hour = minute * 60,
                              day = hour * 24;

                          let countDown = new Date('<%= auct.FinishDate.ToString("MMM d, yyyy hh:mm:ss.F", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))%>').getTime(),
                                    x = setInterval(function () {

                                        let d = '<%= auct.idAution %>' + 'days';
                                        let h = '<%= auct.idAution %>' + 'hours';
                                        let m = '<%= auct.idAution %>' + 'minutes';
                                        let s = '<%= auct.idAution %>' + 'seconds';
                                        console.log(d);
                                        let now = new Date().getTime(),
                                            distance = countDown - now;

                                        document.getElementById('<%= auct.idAution %>').innerHTML = '<li><span id="' + d + '"></span></li> <li><span id="' + h + '"></span></li> <li><span id="' + m + '"></span></li> <li><span id="' + s + '"></span></li>';


                                        document.getElementById(d).innerText = Math.floor(distance / (day)) + ' D',
                                            document.getElementById(h).innerText = Math.floor((distance % (day)) / (hour)) + ' H',
                                            document.getElementById(m).innerText = Math.floor((distance % (hour)) / (minute)) + ' M',
                                            document.getElementById(s).innerText = Math.floor((distance % (minute)) / second) + ' S';


                                        if (distance < 0) {
                                            clearInterval(x);
                                            document.getElementById('<%= auct.idAution %>').innerHTML = '<li> <span> Ya ha finalizado </span> </li>'
                                        }

                                    }, second)
                      }
                        </script>
               <% } %>

               </div>
                <!-- Subastas Ganadas -->
              <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                   <%foreach(var wauct in  WonAuctList) { %>
                 
                  <div class="note-card p-2 m-2" >
                      <a href="Producto.aspx?id=<%= wauct.idAution %>" class="btn link d-flex" style="font-size: 12px; text-decoration:none ; "> 
                        <div class="detail-product">
                      
                            <img class="img-product " src="<%= ("data:image/jpeg;base64," + Convert.ToBase64String(wauct.Product.Product_img)) %>"  />
                        
                        <h4 class="m-0"> <%= wauct.Product.Name %>  </h4>
                        <h6 class="text-muted "> <small> por por <%= db.User.First(st => st.idUser == wauct.AutionOwner).ContactData.Names %> </small> </h6>

                    <h6> Descripcion del Producto </h6>
                        <p class=" item-desc"> 
                            <%= wauct.Product.Description %>
                        </p>
                        
                             <% var aux = wauct.Bids.ToList().Last();
                                var lastbider = db.User.First(st => st.idUser == aux.Bidder); %>

                            <h4 class="text-center font-weight-bolder text-main"> $<%= aux.Value %> </h4>
                            <h4 class="m-0 text-center"> <%= lastbider.Nickname %> </h4>
                            <h6 class="text-muted text-center "> <small> Mayor Pujador </small> </h6>
                        <h6> Termina en </h6>
                          <ul id="<%= wauct.idAution %>" class="m-0 p-0 time-panel">
                            
                          </ul>
                    </div>
                    </a>
                  </div>

                  <script>
                      new function () {
                          const second = 1000,
                              minute = second * 60,
                              hour = minute * 60,
                              day = hour * 24;

                          let countDown = new Date('<%= wauct.FinishDate.ToString("MMM d, yyyy hh:mm:ss.F", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))%>').getTime(),
                              x = setInterval(function () {

                                  let d = '<%= wauct.idAution %>' + 'days';
                                        let h = '<%= wauct.idAution %>' + 'hours';
                                        let m = '<%= wauct.idAution %>' + 'minutes';
                                        let s = '<%= wauct.idAution %>' + 'seconds';
                                        console.log(d);
                                        let now = new Date().getTime(),
                                            distance = countDown - now;

                                        document.getElementById('<%= wauct.idAution %>').innerHTML = '<li><span id="' + d + '"></span></li> <li><span id="' + h + '"></span></li> <li><span id="' + m + '"></span></li> <li><span id="' + s + '"></span></li>';


                                        document.getElementById(d).innerText = Math.floor(distance / (day)) + ' D',
                                            document.getElementById(h).innerText = Math.floor((distance % (day)) / (hour)) + ' H',
                                            document.getElementById(m).innerText = Math.floor((distance % (hour)) / (minute)) + ' M',
                                            document.getElementById(s).innerText = Math.floor((distance % (minute)) / second) + ' S';


                                        if (distance < 0) {
                                            clearInterval(x);
                                            document.getElementById('<%= wauct.idAution %>').innerHTML = '<li> <span> Ya ha finalizado </span> </li>'
                                        }

                                    }, second)
                      }
                        </script>
               <% } %>
              
              </div>

                <!-- Subastas Finalizadas -->
              <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">

                   <%foreach(var fauct in AcAuctList) { %>
                 
                  <div class="note-card p-2 m-2" >
                      <a href="Producto.aspx?id=<%= fauct.idAution %>" class="btn link d-flex" style="font-size: 12px; text-decoration:none ; "> 
                        <div class="detail-product">
                      
                            <img class="img-product " src="<%= ("data:image/jpeg;base64," + Convert.ToBase64String(fauct.Product.Product_img)) %>"  />
                        
                        <h4 class="m-0"> <%= fauct.Product.Name %>  </h4>
                        <h6 class="text-muted "> <small> por por <%= db.User.First(st => st.idUser == fauct.AutionOwner).ContactData.Names %> </small> </h6>

                    <h6> Descripcion del Producto </h6>
                        <p class=" item-desc"> 
                            <%= fauct.Product.Description %>
                        </p>
                        
                             <% var aux = fauct.Bids.ToList().Last();
                                var lastbider = db.User.First(st => st.idUser == aux.Bidder); %>

                            <h4 class="text-center font-weight-bolder text-main"> $<%= aux.Value %> </h4>
                            <h4 class="m-0 text-center"> <%= lastbider.Nickname %> </h4>
                            <h6 class="text-muted text-center "> <small> Mayor Pujador </small> </h6>
                        <h6> Termina en </h6>
                          <ul id="<%= fauct.idAution %>" class="m-0 p-0 time-panel">
                            
                          </ul>
                    </div>
                    </a>
                  </div>

                  <script>
                      new function () {
                          const second = 1000,
                                minute = second * 60,
                                hour = minute * 60,
                                day = hour * 24;

                          let countDown = new Date('<%= fauct.FinishDate.ToString("MMM d, yyyy hh:mm:ss.F", System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))%>').getTime(),
                              x = setInterval(function () {

                                  let d = '<%= fauct.idAution %>' + 'days';
                                        let h = '<%= fauct.idAution %>' + 'hours';
                                        let m = '<%= fauct.idAution %>' + 'minutes';
                                        let s = '<%= fauct.idAution %>' + 'seconds';
                                        console.log(d);
                                        let now = new Date().getTime(),
                                            distance = countDown - now;

                                        document.getElementById('<%= fauct.idAution %>').innerHTML = '<li><span id="' + d + '"></span></li> <li><span id="' + h + '"></span></li> <li><span id="' + m + '"></span></li> <li><span id="' + s + '"></span></li>';


                                        document.getElementById(d).innerText = Math.floor(distance / (day)) + ' D',
                                            document.getElementById(h).innerText = Math.floor((distance % (day)) / (hour)) + ' H',
                                            document.getElementById(m).innerText = Math.floor((distance % (hour)) / (minute)) + ' M',
                                            document.getElementById(s).innerText = Math.floor((distance % (minute)) / second) + ' S';


                                        if (distance < 0) {
                                            clearInterval(x);
                                            document.getElementById('<%= fauct.idAution %>').innerHTML = '<li> <span> Ya ha finalizado </span> </li>'
                                        }

                                    }, second)
                      }
                        </script>
               <% } %>
              </div>



            </div>
        </div>

    <br />
    <br />

    <% if (Request.QueryString["fb"] != null)
        { %>
                <% if (Request.QueryString["fb"] == "0")
                   { %>
                       <script>
                          swal("Publicacion Registrada!", "Tu publicacion ha sido registrada, espera a que los administradores comprueben los datos y completen la publicacion.", "success");
                       </script>
                    <%}

                   
                }%>
</asp:Content>
