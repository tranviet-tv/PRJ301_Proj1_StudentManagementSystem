package entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.Collection;


@Entity
@Table(name = "departments")
public class Departments {

    @Id
    @NotNull
    @Column(name = "id")
    private Integer id;

    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "departmentname")
    private String departmentname;
    
    @OneToMany(mappedBy = "departmentId")
    private Collection<Students> studentsCollection;

    public Departments() {
    }

    public Departments(Integer id) {
        this.id = id;
    }

    public Departments(Integer id, String departmentname) {
        this.id = id;
        this.departmentname = departmentname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDepartmentname() {
        return departmentname;
    }

    public void setDepartmentname(String departmentname) {
        this.departmentname = departmentname;
    }

    public Collection<Students> getStudentsCollection() {
        return studentsCollection;
    }

    public void setStudentsCollection(Collection<Students> studentsCollection) {
        this.studentsCollection = studentsCollection;
    }

    @Override
    public String toString() {
        return "Departments{" + "id=" + id + ", departmentname=" + departmentname + ", studentsCollection=" + studentsCollection + '}';
    }

}
