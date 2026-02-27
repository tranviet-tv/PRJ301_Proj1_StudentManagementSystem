package dal;

import entity.Departments;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class DepartmentDAO {
    private final EntityManager em;

    public DepartmentDAO(EntityManager em) {
        this.em = em;
    }

    // Lấy tất cả phòng ban (phục vụ Dropdown và danh sách)
    public List<Departments> findAll() {
        String jpql = "SELECT d FROM Departments d";
        return em.createQuery(jpql, Departments.class).getResultList();
    }

    // Tìm phòng ban theo ID
    public Departments findById(Integer id) {
        return em.find(Departments.class, id);
    }

    // Thêm phòng ban mới
    public boolean create(Departments department) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(department);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật phòng ban
    public boolean update(Departments department) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(department);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }

    // Xóa phòng ban
    public boolean delete(Integer id) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Departments dept = em.find(Departments.class, id);
            if (dept != null) {
                em.remove(dept);
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