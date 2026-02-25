package entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serializable;

@Entity
@Table(name = "user_accounts")
public class UserAccounts implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "username", unique = true, nullable = false, length = 50)
    private String username;

    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "password", nullable = false, length = 255)
    private String password;

    @NotNull
    @Column(name = "role", nullable = false)
    private Integer role; // Ghi chú Role: 1 = Manager, 2 = Staff, 3 = Guest

    public UserAccounts() {
    }

    public UserAccounts(Integer id) {
        this.id = id;
    }

    public UserAccounts(Integer id, String username, String password, Integer role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // --- Getters và Setters ---

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    @Override
    public String toString() {
        // LƯU Ý BẢO MẬT: Đã xóa thuộc tính 'password' khỏi hàm toString. 
        // Không bao giờ nên in password ra log hoặc console.
        return "UserAccounts{" + 
               "id=" + id + 
               ", username='" + username + '\'' + 
               ", role=" + role + 
               '}';
    }
}