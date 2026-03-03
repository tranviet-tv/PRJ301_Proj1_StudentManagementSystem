package controller;

import dal.DepartmentDAO;
import dal.StudentDAO;
import entity.Departments;
import entity.Students;
import entity.UserAccounts;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="StudentController", urlPatterns={"/student"})
public class StudentController extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("PRJ301Proj1_PU");
        
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra session (Đăng nhập và phân quyền cơ bản)
        HttpSession session = request.getSession();
        UserAccounts currentUser = (UserAccounts) session.getAttribute("account");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        EntityManager em = emf.createEntityManager();
        try {
            StudentDAO studentDAO = new StudentDAO(em);
            DepartmentDAO departmentDAO = new DepartmentDAO(em);

            // Luôn lấy danh sách phòng ban đẩy lên Dropdown
            List<Departments> listDepartments = departmentDAO.findAll();
            request.setAttribute("listDepartments", listDepartments);

            switch (action) {
                case "delete":
                    // QUYỀN: Chỉ Staff (Role 2) mới được xóa
                    if (currentUser.getRole() != 2) {
                        request.setAttribute("errorMessage", "Only Staff can delete students.");
                        action = "list";
                        break;
                    }

                    Integer idToDelete = Integer.parseInt(request.getParameter("id"));
                    Students studentToDelete = studentDAO.findById(idToDelete);

                    // LUẬT KINH DOANH: Chỉ được xóa sinh viên do mình tạo
                    if (studentToDelete != null && studentToDelete.getCreatedBy().equals(currentUser.getUsername())) {
                        studentDAO.delete(idToDelete);
                        response.sendRedirect(request.getContextPath() + "/student");
                        return; // Kết thúc request sau khi redirect
                    } else {
                        request.setAttribute("errorMessage", "You can only delete students that you created!");
                        action = "list"; // Quay lại trang list để hiển thị lỗi
                    }
                    break;

                case "edit":
                    // QUYỀN: Chỉ Staff (Role 2) mới được sửa
                    if (currentUser.getRole() != 2) {
                        request.setAttribute("errorMessage", "Only Staff can edit students.");
                        action = "list";
                        break;
                    }

                    Integer editId = Integer.parseInt(request.getParameter("id"));
                    Students studentToEdit = studentDAO.findById(editId);
                    
                    // LUẬT KINH DOANH: Chỉ được sửa sinh viên do mình tạo
                    if (studentToEdit != null && studentToEdit.getCreatedBy().equals(currentUser.getUsername())) {
                        request.setAttribute("student", studentToEdit);
                        request.getRequestDispatcher("/student.jsp").forward(request, response);
                        return;
                    } else {
                        request.setAttribute("errorMessage", "You can only edit students that you created!");
                        action = "list";
                    }
                    break;
                    
                case "create":
                    // Điều hướng sang form để thêm mới sinh viên
                    if (currentUser.getRole() != 2) {
                        request.setAttribute("errorMessage", "Only Staff can add students.");
                        action = "list";
                        break;
                    }
                    request.getRequestDispatcher("/student.jsp").forward(request, response);
                    return;
            }

            // XỬ LÝ HIỂN THỊ DANH SÁCH (READ & PAGINATION)
            if ("list".equals(action)) {
                int role = currentUser.getRole();
                
                if (role == 1) { 
                    // MANAGER: Chỉ xem Top 5 GPA cao nhất, không phân trang
                    List<Students> top5Students = studentDAO.findTop5ByGpa();
                    request.setAttribute("listStudents", top5Students);
                    
                } else if (role == 2) { 
                    // STAFF: Xem tất cả sinh viên, có phân trang (5 items/page)
                    int page = 1;
                    int pageSize = 5;
                    
                    String pageParam = request.getParameter("page");
                    if (pageParam != null && !pageParam.isEmpty()) {
                        page = Integer.parseInt(pageParam);
                    }

                    long totalStudents = studentDAO.countTotalStudents();
                    int totalPages = (int) Math.ceil((double) totalStudents / pageSize);

                    List<Students> pagedStudents = studentDAO.findAllWithPagination(page, pageSize);

                    request.setAttribute("listStudents", pagedStudents);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                }

                request.getRequestDispatcher("/student.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "System Error: " + e.getMessage());
            try {
                request.getRequestDispatcher("/student.jsp").forward(request, response);
            } catch (Exception ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Render Error: " + e.getMessage());
            }
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra session
        HttpSession session = request.getSession(false);
        UserAccounts currentUser = (UserAccounts) session.getAttribute("account");
        
        if (currentUser == null || currentUser.getRole() != 2) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        EntityManager em = emf.createEntityManager();
        try {
            StudentDAO studentDAO = new StudentDAO(em);
            DepartmentDAO departmentDAO = new DepartmentDAO(em);

            // Lấy thông tin từ form
            String idStr = request.getParameter("id");
            String studentid = request.getParameter("studentid");
            String name = request.getParameter("name");
            String gpaStr = request.getParameter("gpa");
            String departmentIdStr = request.getParameter("department_id");

            // VALIDATION DỮ LIỆU ĐẦU VÀO
            boolean hasError = false;
            StringBuilder errorMessage = new StringBuilder();

            // Validate Tên: 5-50 ký tự
            if (name == null || name.trim().length() < 5 || name.trim().length() > 50) {
                hasError = true;
                errorMessage.append("Name must be 5-50 characters. ");
            }

            // Validate GPA: 0.0 - 10.0
            Double gpa = null;
            try {
                gpa = Double.parseDouble(gpaStr);
                if (gpa < 0.0 || gpa > 10.0) {
                    hasError = true;
                    errorMessage.append("GPA must be between 0.0 and 10.0. ");
                }
            } catch (NumberFormatException e) {
                hasError = true;
                errorMessage.append("Invalid GPA format. ");
            }

            // Validate Department
            if (departmentIdStr == null || departmentIdStr.isEmpty()) {
                hasError = true;
                errorMessage.append("Department must be selected. ");
            }

            // NẾU CÓ LỖI VALIDATION -> Trả về form
            if (hasError) {
                request.setAttribute("errorMessage", errorMessage.toString());
                request.setAttribute("listDepartments", departmentDAO.findAll());
                
                // Trả lại các giá trị đang nhập dở để user không phải gõ lại
                Students tempStudent = new Students();
                tempStudent.setStudentid(studentid);
                tempStudent.setName(name);
                if(gpa != null) tempStudent.setGpa(gpa);
                if(idStr != null && !idStr.isEmpty()) tempStudent.setId(Integer.parseInt(idStr));
                request.setAttribute("student", tempStudent);
                
                request.getRequestDispatcher("/student.jsp").forward(request, response);
                return;
            }

            // TIẾN HÀNH THÊM / SỬA SAU KHI DỮ LIỆU ĐÃ HỢP LỆ
            Departments dept = departmentDAO.findById(Integer.parseInt(departmentIdStr));

            if (idStr == null || idStr.isEmpty()) {
                // LOGIC: THÊM SINH VIÊN (ADD)
                Students newStudent = new Students();
                newStudent.setStudentid(studentid);
                newStudent.setName(name);
                newStudent.setGpa(gpa);
                newStudent.setDepartmentId(dept);
                
                Date currentDate = new Date();
                newStudent.setCreatedAt(currentDate);
                newStudent.setUpdatedAt(currentDate);
                newStudent.setCreatedBy(currentUser.getUsername());

                studentDAO.create(newStudent);
                
            } else {
                // LOGIC: SỬA SINH VIÊN (UPDATE)
                Integer id = Integer.parseInt(idStr);
                Students existingStudent = studentDAO.findById(id);

                if (existingStudent != null) {
                    // Luật: Chỉ người tạo mới được update
                    if (!existingStudent.getCreatedBy().equals(currentUser.getUsername())) {
                        request.setAttribute("errorMessage", "You can only update students that you created!");
                        request.setAttribute("listDepartments", departmentDAO.findAll());
                        request.setAttribute("student", existingStudent);
                        request.getRequestDispatcher("/student.jsp").forward(request, response);
                        return;
                    }

                    existingStudent.setStudentid(studentid);
                    existingStudent.setName(name);
                    existingStudent.setGpa(gpa);
                    existingStudent.setDepartmentId(dept);
                    
                    // Cập nhật ngày chỉnh sửa
                    existingStudent.setUpdatedAt(new Date());

                    studentDAO.update(existingStudent);
                }
            }

            // Thành công thì quay về danh sách
            response.sendRedirect(request.getContextPath() + "/student");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while saving: " + e.getMessage());
            request.getRequestDispatcher("/student.jsp").forward(request, response);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Student Controller handling CRUD operations";
    }
}