<%@page import="java.util.Map"%>
<%@page import="com.hukr.shopping.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.hukr.shopping.entities.Category"%>
<%@page import="com.hukr.shopping.helper.FactoryProvider"%>
<%@page import="com.hukr.shopping.dao.CategoryDao"%>
<%@page import="com.hukr.shopping.entities.User"%>
<% 
     User user= (User)session.getAttribute("current-user");
     if(user==null){
      session.setAttribute("message", "you are not logined in !! Login First");
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

<%
    CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list= categoryDao.getCategories();
    
//counter
 Map<String,Long> m = Helper.getCounter(FactoryProvider.getFactory());
 
    %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
        <script type="text/javascript" src="js/script.js"></script>
       
    </head>
    <body>
        
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %> 
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 120px;" class="img-fluid rounded-circle" src="img/man.png" alt="
                                     "/>
                            </div>
                            <h1><%= m.get("userCount")%></h1>
                            <h1>Users</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body  text-center">
                            <div class="container">
                                <img style="max-width: 120px;" class="img-fluid rounded-circle" src="img/app.png" alt="
                                     "/>
                            </div>
                             <h1><%=list.size() %></h1>
                            <h1>Categories</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body  text-center">
                            <div class="container">
                                <img style="max-width: 120px;" class="img-fluid rounded-circle" src="img/new-product.png" alt="
                                     "/>
                            </div>
                            <h1><%= m.get("productCount")%></h1>
                            <h1>Products</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body  text-center">
                            <div class="container">
                                <img style="max-width: 120px;" class="img-fluid rounded-circle" src="img/app.png" alt="
                                     "/>
                            </div>
                             <h1>22</h1>
                             <p class="mt-2">Click here to add new Category</p>
                            <h1>Add Category</h1>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body  text-center">
                            <div class="container">
                                <img style="max-width: 120px;" class="img-fluid rounded-circle" src="img/add.png" alt="
                                     "/>
                            </div>
                             <h1>22</h1>
                             <p class="mt-2">Click here to add new Product</p>
                            <h1>Add Product</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
<!--        add category model-->


<!-- Modal -->
<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Fill Category Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post">
              <input type="hidden" name="operation" value="addcategory">
                  
              <div class="form-group">
                  <input type="text" class="form-control" name="cat_title" placeholder="Enter Category">
              </div>
              
              <div class="form-group">
                  <textarea style="height:300px;" class="form-control" name="cat_desc" placeholder="Enter Category Description"></textarea>
              </div>
              
              <div class="container text-center">
                 <button class="btn btn-outline-success">Add Category</button>
                 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
          </form>
      </div>
      
    </div>
  </div>
</div>
<!--        add category model-->

<!--add product modal-->

<!-- Modal -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add Product</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
              <input type="hidden" name="operation" value="addproduct">
              
             <div class="form-group">
                  <input type="text" class="form-control" name="pName" placeholder="Enter Title of Product">
              </div>
              
              <div class="form-group">
                  <textarea style="height:300px;" class="form-control" name="pDesc" placeholder="Enter Product Description"></textarea>
              </div> 
              
                <div class="form-group">
                  <input type="number" class="form-control" name="pPrice" placeholder="Enter Product Price"  required/>
              </div>
              
               <div class="form-group">
                  <input type="number" class="form-control" name="pDiscount" placeholder="Enter Product Discount" required/>
              </div>
              
               <div class="form-group">
                   <input type="number" class="form-control" name="pQuantity" placeholder="Enter Product Quantity" required/>
              </div>
              
               
              <div class="form-group">
                  <select name="catId" class="form-control" id="">
                      <% 
                        for(Category c:list){
                      %>
<!--                      <option value="laptop"><%= c.getCategoryTitle()%></option>-->
                       <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>
                      <% } %>
                  </select>  
              </div>
              
             
              <div class="form-group">
                  <label for="">Select Pic for Product</label><br>
                  <input type="file" name="pPic" required/>
              </div>
              
              <div class="container text-center">
                  <button class="btn btn-outline-success">Add Product</button>
                 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              </div>
          </form>
      </div>
      
    </div>
  </div>
</div>
<!--add product modal-->
<%@include file="components/common_modal.jsp"  %>
    </body>
</html>
