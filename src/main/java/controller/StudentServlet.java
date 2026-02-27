package controller;

import dal.DepartmentDAO;
import dal.StudentDAO;
import entity.Students;
import entity.UserAccounts;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name="StudentServlet", urlPatterns={"/student"})
public class StudentServlet extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("PRJ301Proj1_PU");
        
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Kiểm tra session (đăng nhập)
    HttpSession session = request.getSession();
    UserAccounts currentUser = (UserAccounts) session.getAttribute("account");
    
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath()+"/login");
        return;
    }

    EntityManager em = emf.createEntityManager();
    try {
        StudentDAO studentDAO = new StudentDAO(em);
        DepartmentDAO departmentDAO = new DepartmentDAO(em);

        // 2. Lấy danh sách phòng ban đẩy lên Dropdown (Luôn cần)
        request.setAttribute("departments", departmentDAO.findAll());

        // 3. Xử lý logic nếu người dùng bấm "Edit"
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            Integer editId = Integer.parseInt(request.getParameter("id"));
            Students editStudent = studentDAO.findById(editId);
            request.setAttribute("studentEdit", editStudent);
        }

        // 4. Lấy danh sách sinh viên dựa trên Role
        int role = currentUser.getRole();
        
        if (role == 1) { 
            List<Students> top5Students = studentDAO.findTop5ByGpa();
            request.setAttribute("listStudents", top5Students);
            
        } else if (role == 2) { 
            // STAFF: Xem tất cả, có phân trang (5 items / page)
            int page = 1;
            int pageSize = 5;
            
            // Lấy trang hiện tại từ URL (nếu có)
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            // Đếm tổng số sinh viên để tính số trang
            long totalStudents = studentDAO.countTotalStudents();
            int totalPages = (int) Math.ceil((double) totalStudents / pageSize);

            // Lấy danh sách theo trang
            // Cần hàm findAllWithPagination(page, pageSize) trong StudentDAO sử dụng setFirstResult() và setMaxResults()
            List<Students> pagedStudents = studentDAO.findAllWithPagination(page, pageSize);

            request.setAttribute("listStudents", pagedStudents);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
        }

        // 5. Chuyển tiếp sang giao diện
        request.getRequestDispatcher("/student.jsp").forward(request, response);
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        em.close();
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
