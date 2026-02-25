package dal;

import entity.UserAccounts;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class UserAccountDAO {
    private EntityManager em;

    public UserAccountDAO(EntityManager em) {
        this.em = em;
    }

    // Hàm kiểm tra đăng nhập
    public UserAccounts findByUsernameAndPassword(String username, String password) {
        try {
            String jpql = "SELECT u FROM UserAccounts u WHERE u.username = :username AND u.password = :password";
            TypedQuery<UserAccounts> query = em.createQuery(jpql, UserAccounts.class);
            query.setParameter("username", username);
            query.setParameter("password", password);
            return query.getSingleResult(); 
        } catch (NoResultException e) {
            return null;
        }
    }
}