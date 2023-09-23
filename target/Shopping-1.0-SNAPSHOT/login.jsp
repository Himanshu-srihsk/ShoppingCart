
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Cart</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-3">
                    <div class="card mt-3">
                        <div class="card-header">
                            <h1>Login here</h1>
                        </div>
                        <div class="card-body custom-bg">
                            <%@include file="components/message.jsp" %>
                            <form action="LoginServlet" method="post">
                                <div class="form-group">
                                  <label for="exampleInputEmail1">Email address</label>
                                  <input type="email" class="form-control" name="email" aria-describedby="emailHelp" placeholder="Enter email">
                                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                  <label for="exampleInputPassword1">Password</label>
                                  <input type="password" class="form-control" name="password" placeholder="Password">
                                </div>
                                <a href="Register.jsp" class="text-center d-block mb-2">If not registered click here</a>
                                <div class="container text-center">
                                    <button type="submit" class="btn btn-primary border-0">Submit</button>
                                    <button type="submit" class="btn btn-danger border-0">Reset</button>
                                </div>
                                
                              </form>
                        </div>
                        <div class="card-footer">
                            
                        </div>
                    </div>
                </div>
            </div>  
            
        </div> 
    </body>
</html>
