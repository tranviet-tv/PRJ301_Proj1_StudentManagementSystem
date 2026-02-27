package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.UserAccountDAO;
import entity.UserAccounts;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name="RegisterController", urlPatterns={"/register"})
public class RegisterController extends HttpServlet {
    
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("PRJ301Proj1_PU");;
    private EntityManager em = emf.createEntityManager();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("fullname");
        String roleStr = request.getParameter("role");
        int role = Integer.parseInt(roleStr);
        
        
        UserAccountDAO userDAO = new UserAccountDAO(em);
        if(userDAO.checkUsernameIsExist(username)){
            request.setAttribute("msg", "Username is  exist");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }

        String passwordEncryption = BCrypt.hashpw(password, BCrypt.gensalt());
        UserAccounts newUser = new UserAccounts(username, passwordEncryption, role);
        userDAO.register(newUser);
        
        response.sendRedirect(request.getContextPath()+"/login");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
