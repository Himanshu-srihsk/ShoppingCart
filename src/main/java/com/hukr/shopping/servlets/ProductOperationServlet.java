
package com.hukr.shopping.servlets;

import com.hukr.shopping.dao.CategoryDao;
import com.hukr.shopping.dao.ProductDao;
import com.hukr.shopping.entities.Category;
import com.hukr.shopping.entities.Product;
import com.hukr.shopping.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author KumarHimansh
 */
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String op=request.getParameter("operation");
            if(op.trim().equals("addcategory")){
                    String title=request.getParameter("cat_title");
                    String desc=request.getParameter("cat_desc");
                    
                   Category category= new Category();
                   category.setCategoryTitle(title);
                   category.setCategoryDescription(desc);
                   CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                   int catId= categoryDao.saveCategory(category);
                   out.println("saved");
                   HttpSession httpSession = request.getSession();
                   httpSession.setAttribute("message","Category added Successfully"+catId);
                   response.sendRedirect("admin.jsp");
                   return;
            }else if(op.trim().equals("addproduct")){
                System.out.println("My request cam here Just for chevl");
                    
                 String pName=request.getParameter("pName");
                 System.out.println("pNmae:"+pName);
                    String pDesc=request.getParameter("pDesc");
                     
                     int pPrice=Integer.parseInt(request.getParameter("pPrice"));
                     
                    int pDiscount=Integer.parseInt(request.getParameter("pDiscount"));
                   
                    int pQuantity=Integer.parseInt(request.getParameter("pQuantity"));
  
                    int catId= Integer.parseInt(request.getParameter("catId"));
                    
                    
                    Part part=request.getPart("pPic");
                    Product p= new Product();
                    p.setpName(pName);
                    p.setpDesc(pDesc);
                    p.setpPrice(pPrice);
                    p.setpDiscount(pDiscount);
                    p.setpQuantity(pQuantity);
                    p.setpPhoto(part.getSubmittedFileName());
                    
                    System.out.println("pnamr:"+ pName +" pDiscout:"+pDiscount+"cat ID:"+ catId+" p Quantity:"+pQuantity);
                    //get category by ID
                    CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                    Category category = categoryDao.getCategoryById(catId);
                    
                    p.setCategory(category);
                    
                    //save product to Database
                    ProductDao pdao= new ProductDao(FactoryProvider.getFactory());
                    pdao.saveProduct(p);
                    
                    //pic upload
                    String targetpath = request.getServletContext().getRealPath("img");
                    
                    String foldername = "products";
                    File folder = new File(targetpath,foldername);
                    if(!folder.exists()){
                        if(folder.mkdir()){
                            System.out.println("folder created Successfully");
                        }else{
                            System.out.println("folder creation failed");
                        }
                    }
                    String path= request.getServletContext().getRealPath("img")+File.separator+"products"+File.separator+part.getSubmittedFileName();
                    System.out.println("path:"+path);
                    
                    try{
                    
                    //upload file
                    FileOutputStream fos=new FileOutputStream(path);
                    InputStream is=part.getInputStream();
                    
                    //reading data
                    byte[] data= new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.close();
                       
                    }catch(Exception e){
                        e.printStackTrace();
                    }
                    
                    out.println("product saved into DB");
                    HttpSession httpSession = request.getSession();
                   httpSession.setAttribute("message","Product added Successfully"+catId);
                   response.sendRedirect("admin.jsp");
                   return;
                    
            }else{
                System.out.println("came into this else part");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
