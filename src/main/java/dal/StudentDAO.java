package dal;

import entity.Students;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class StudentDAO {
    private EntityManager em;

    public StudentDAO(EntityManager em) {
        this.em = em;
    }

    // Tìm sinh viên theo ID (Dùng để kiểm tra quyền sửa/xóa có đúng người tạo không)
    public Students findById(Integer id) {
        return em.find(Students.class, id);
    }

    // Manager: Lấy Top 5 sinh viên có GPA cao nhất
    public List<Students> findTop5ByGpa() {
        String jpql = "SELECT s FROM Students s ORDER BY s.gpa DESC";
        TypedQuery<Students> query = em.createQuery(jpql, Students.class);
        query.setMaxResults(5); // Giới hạn 5 kết quả
        return query.getResultList();
    }

    // Staff: Lấy danh sách sinh viên có phân trang (5 sinh viên/trang)
    public List<Students> findAllWithPagination(int pageNumber, int pageSize) {
        String jpql = "SELECT s FROM Students s ORDER BY s.id DESC"; // Sắp xếp mới nhất lên đầu
        TypedQuery<Students> query = em.createQuery(jpql, Students.class);
        
        int offset = (pageNumber - 1) * pageSize;
        query.setFirstResult(offset); // Vị trí bắt đầu
        query.setMaxResults(pageSize); // Số lượng lấy ra
        
        return query.getResultList();
    }

    // Đếm tổng số sinh viên (Hỗ trợ logic tính tổng số trang)
    public long countTotalStudents() {
        String jpql = "SELECT COUNT(s) FROM Students s";
        return em.createQuery(jpql, Long.class).getSingleResult();
    }

    // Thêm sinh viên (Các trường created_at, created_by cần set sẵn ở Controller)
    public boolean create(Students student) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(student);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật thông tin sinh viên (Trường updated_at cần set sẵn ở Controller)
    public boolean update(Students student) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(student);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }

    // Xóa sinh viên
    public boolean delete(Integer id) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Students student = em.find(Students.class, id);
            if (student != null) {
                em.remove(student);
            }
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }
}