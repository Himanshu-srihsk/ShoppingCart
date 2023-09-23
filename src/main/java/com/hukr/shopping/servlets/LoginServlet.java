/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hukr.shopping.servlets;

import com.hukr.shopping.dao.UserDao;
import com.hukr.shopping.entities.User;
import com.hukr.shopping.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author KumarHimansh
 */
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            System.out.println("email="+email+ " and password ="+password);
            //validations
             UserDao userDao= new UserDao(FactoryProvider.getFactory());
             User user=(User) userDao.getUserByEmailAndPassword(email,password);
             //System.out.println(user);
            //authentication
            HttpSession httpSession=  request.getSession();
            if(user==null){
               out.println("<h1>  Invalid Details </h1>");
               
                    httpSession.setAttribute("message","Invalid Details Try another one !!");
                    response.sendRedirect("login.jsp");
           }else{
                System.out.println("came here");
                out.println("<h1>Welcome "+user.getUserName()+"</h1>");
                
                //login
                httpSession.setAttribute("current-user", user);
                
                if(user.getUserType().equals("admin")){
                    response.sendRedirect("admin.jsp");
                }else if(user.getUserType().equals("normal")){
                    response.sendRedirect("normal.jsp");
                }else{
                    out.println("We could not identify UserType");
                }
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
