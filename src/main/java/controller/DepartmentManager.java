package controller;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Departments;
import dal.DepartmentDAO;
import jakarta.persistence.Persistence;
import java.util.List;

@WebServlet(name="DepartmentManager", urlPatterns={"/department"})
public class DepartmentManager extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("PRJ301Proj1_PU");;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; 
        }

        DepartmentDAO departmentDAO = new DepartmentDAO(em);

        try {
            switch (action) {
                case "edit":
                    Integer idToEdit = Integer.parseInt(request.getParameter("id"));
                    Departments deptToEdit = departmentDAO.findById(idToEdit);
                    request.setAttribute("department", deptToEdit);
                    request.getRequestDispatcher("/department-form.jsp").forward(request, response);
                    break;
                    
                case "delete":
                    Integer idToDelete = Integer.parseInt(request.getParameter("id"));
                    departmentDAO.delete(idToDelete);

                    response.sendRedirect(request.getContextPath() + "/department");
                    break;
                    
                case "list":
                default:
                    List<Departments> list = departmentDAO.findAll();
                    request.setAttribute("listDepartments", list);
                    request.getRequestDispatcher("/department.jsp").forward(request, response);
                    break;
            }
        } finally {
            em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        EntityManager em = emf.createEntityManager();
        
        String action = request.getParameter("action");
        DepartmentDAO departmentDAO = new DepartmentDAO(em);

        try {
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            String departmentname = request.getParameter("departmentname");

            if (departmentname == null || departmentname.trim().length() < 5 || departmentname.trim().length() > 50) {
                request.setAttribute("errorMessage", "Department name must be between 5 and 50 characters!");
                
                if (idStr != null && !idStr.isEmpty()) {
                    request.setAttribute("department", new Departments(id, departmentname));
                } else {
                    request.setAttribute("department", new Departments(null, departmentname));
                }
                request.getRequestDispatcher("/department.jsp").forward(request, response);
                return;
            }

            if ("update".equals(action) && idStr != null && !idStr.isEmpty()) {
                Departments dept = new Departments(id, departmentname);
                departmentDAO.update(dept);
            } else {
                Departments newDept = new Departments(id, departmentname);
                departmentDAO.create(newDept);
            }

            response.sendRedirect(request.getContextPath() + "/department");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing the request.");
            request.getRequestDispatcher("/department.jsp").forward(request, response);
        } finally {
            em.close(); 
        }
    }
    
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
