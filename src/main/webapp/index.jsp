<%-- 
    Document   : index
    Created on : 20-Sept-2023, 6:26:40 am
    Author     : KumarHimansh
--%>

<%@page import="com.hukr.shopping.helper.Helper"%>
<%@page import="com.hukr.shopping.entities.Category"%>
<%@page import="com.hukr.shopping.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.hukr.shopping.entities.Product"%>
<%@page import="com.hukr.shopping.dao.ProductDao"%>
<%@page import="com.hukr.shopping.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart Home</title>
        <%@include file="components/common_css_js.jsp" %>
        <script type="text/javascript" src="js/script.js"></script>
    </head>
    <body>
         
        
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            <div class="row mt-3 mx-2">
            <%
                String cat=request.getParameter("category");
             
            ProductDao productDao=new ProductDao(FactoryProvider.getFactory());
            List<Product> l= null;
            
            if(cat==null || cat.trim().equals("all")){
                 l=productDao.getallproducts();
                }else{
                    int cid=Integer.parseInt(cat.trim());
                    l=productDao.getallproductsbyId(cid);
                }
                
                    
            
            CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> cl= categoryDao.getCategories();
            
                
            %>
<!--            show categories-->
            <div class="col-md-2">
                <div class="list-group mt-4">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                     All Products
                    </a>
                    
                </div>
                    <%
                    for(Category c:cl){
                    %>
                    <a href="index.jsp?category=<%=c.getCategoryId() %>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle() %></a>
                    <%
                    
                        }
                    %>
            </div>
<!--            show Products-->
            <div class="col-md-10">
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card-columns">
<!--                            //traversing products-->
                            <%
                            for(Product p:l){
                            
                            %>
                            <div class="card product-card">
                                <div class="container text-center">
                                    <img src="img/products/<%=p.getpPhoto()%>" style="max-height: 270px; max-width: 100%;" class="card-img-top mt-2" alt="...">
                                </div>
                                 <div class="card-body">
                                    <h5 class="card-title"><%=p.getpName()%></h5>
                                    <p class="card-text">
                                        <%= Helper.get10words(p.getpDesc()) %>
                                    </p>
                                </div>
                                    <div class="card-footer">
                                        <button class="btn btn-primary text-white" onclick= "add_to_cart(<%=p.getpId() %>,'<%= p.getpName() %>',<%= p.getPriceAfterApplyingDiscount() %>)">Add to Cart</button>
                                        <button class="btn btn-outline-primary">&#8377; <%= p.getPriceAfterApplyingDiscount() %>/-<span class="text-secondary discount-label">&nbsp; &nbsp;  &#8377;<%=p.getpPrice() %>&nbsp; <%= p.getpDiscount() %>% off </span></button>
                                    </div>
                            </div>
                                    
                            <%
                                }

                             if(l.size()==0){
                                  out.println("<h3>No Item in this Category</h3>");
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
                            <%@include file="components/common_modal.jsp"  %>
    </body>
</html>
