/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import entity.UserAccounts;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest  req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());
        
        //cho phep cac duong dan di qua ma kh can ktra
        if (path.startsWith("/login") || path.startsWith("/logout") || path.startsWith("/register")||
            path.contains(".css") || path.contains(".js") || path.contains(".jpg")) {
            chain.doFilter(request, response);
            return;
        }
        
        //ktra dang nhap 
        HttpSession session = req.getSession(false);
        UserAccounts userLogin = (session != null)? (UserAccounts) session.getAttribute("account"):  null;
        if(userLogin == null){
            req.setAttribute("msg", "You have no permission to access this function!");
            req.getRequestDispatcher("/login").forward(request, response);
        }
        
        int role = userLogin.getRole();
        if (role == 3) {
            req.setAttribute("errorMessage", "You have no permission to access this function!");
            req.getRequestDispatcher(req.getContextPath()).forward(req, resp);
            return;
        }
        
        if (path.startsWith("/department") && role != 1) {
            req.setAttribute("errorMessage", "You have no permission to access this function!");
            // Staff không vào được phòng ban thì đẩy về lại trang quản lý sinh viên
//            req.getRequestDispatcher("/student").forward(req, res);
            return;
        }

        chain.doFilter(request, response);
    }

}
