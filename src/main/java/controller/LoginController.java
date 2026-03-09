package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.UserAccountDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import entity.UserAccounts;
import jakarta.persistence.Persistence;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name="LoginController", urlPatterns={"/login"})
public class LoginController extends HttpServlet {
    
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("PRJ301Proj1_PU");
    private EntityManager em = emf.createEntityManager();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserAccountDAO userDAO = new UserAccountDAO(em);
        UserAccounts user = userDAO.findByUsername(username);
        
        if(user != null && BCrypt.checkpw(password, user.getPassword())){
            HttpSession loginSession = request.getSession();
            loginSession.setAttribute("account", user);
            response.sendRedirect("student");
        }else{
            request.setAttribute("msg", "Dang nhap khong thanh cong");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
