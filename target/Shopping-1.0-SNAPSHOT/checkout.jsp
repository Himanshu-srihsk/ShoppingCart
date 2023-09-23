<%
    User user= (User)session.getAttribute("current-user");
     if(user==null){
      session.setAttribute("message", "you are not logined in !! Login First to access checkout page");
      response.sendRedirect("login.jsp");
      return;
    }else{
       if(user.getUserType().equals("normal")){
        session.setAttribute("message", "you are not admin !! Access not allowed");
        response.sendRedirect("login.jsp");
        return;
      }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
        <%@include file="components/common_css_js.jsp" %>
        <script type="text/javascript" src="js/script.js"></script>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="row mt-5">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="text-center mb-3"> Your Selected Items</h1>
                            <div class="cart-body">
                         
                        </div>
                        </div>
                        
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="text-center mb-3"> Your Details for Order</h1>
                            <form action="#">
                                <div class="form-group">
                                  <label for="exampleInputEmail1">Email address</label>
                                  <input type="email" value="<%= user.getUserEmail() %>" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                  <label for="exampleInputEmail1">Your Name </label>
                                  <input type="text" value="<%= user.getUserName()%>" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter name">
                                </div>
                                
                                <div class="form-group">
                                  <label for="exampleInputEmail1">Your Contact Number </label>
                                  <input type="number" value="<%= user.getUserPhone()%>" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Contact no">
                                </div>
                                
                                <div class="form-group">
                                    <label for="exampleFormControlTextarea1">Enter Shipping address</label>
                                    <textarea value="<%= user.getUserAddress()%>"class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Enter your address"></textarea>
                                  </div>
                                <div class="container">
                                    <button class="btn btn-outline-success">Order Now </button>
                                    <button class="btn btn-outline-primary">Continue Shopping </button>
                                </div>
                            </form>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
       <%@include file="components/common_modal.jsp"  %>
    </body>
</html>
