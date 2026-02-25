package dal;

import entity.UserAccounts;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class UserAccountDAO {
    private final EntityManager em;

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
    
    public boolean checkUsernameIsExist(String username){
        try {
            String jpql = "SELECT u FROM UserAccounts u WHERE u.username = :username";
            TypedQuery<UserAccounts> query = em.createQuery(jpql, UserAccounts.class);
            query.setParameter("username", username);
            query.getSingleResult();
            return true; 
        } catch (NoResultException e) {
            return false;
        }
    }
    
    public boolean register(UserAccounts newUser){
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(newUser);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if(transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }
}