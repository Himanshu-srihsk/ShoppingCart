<%-- 
    Document   : Register
    Created on : 20-Sept-2023, 10:00:22 pm
    Author     : KumarHimansh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            <div class="row mt-3">
                <div class="col-md-6  offset-md-4">
                    <div class="card">
                        <%@include file="components/message.jsp" %>
                        <div class="card-body">
                            <h3 class="text-center my-3">Signup here</h3>
                            <form action="ResisterServlet" method="post">
                                    <div class="form-group">
                                      <label for="name">User Name</label>
                                      <input type="text" class="form-control" name="user_name" aria-describedby="emailHelp" placeholder="Enter name">
                                    </div>
                                    <div class="form-group">
                                      <label for="email">User Email</label>
                                      <input type="email" class="form-control" name="user_email" placeholder="Enter Email">
                                    </div>

                                    <div class="form-group">
                                      <label for="password">User Password</label>
                                      <input type="password" class="form-control" name ="user_password" placeholder="Enter Password">
                                    </div>

                                    <div class="form-group">
                                      <label for="phone">User phone</label>
                                      <input type="number" class="form-control" name="user_phone" placeholder="Enter phone">
                                    </div>
                                  
                                    <div class="form-group">
                                        <label for="address">User Address </label>
                                      <textarea style="height:200px;" class="form-control"name="user_address" placeholder="Enter your Address"></textarea>

                                    </div>

                                    <div class="container text-center">
                                        <button class="btn btn-outline-warning">Register</button>
                                         <button class="btn btn-outline-success">Reset</button>
                                    </div>

                              </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
