# PRJ301 Student Management System

A robust, enterprise-level Student Management System built with Java Web Technologies. This project strictly follows the MVC N-Layer Architecture, utilizing Servlets, JSP + JSTL, and JPA (Hibernate) for data persistence. The frontend is fully modernized with responsive Tailwind CSS.

## 🚀 Features

- **Authentication & Authorization**: Secure login/registration system managed via `HttpSession`. Route protection is implemented strictly using Servlet Filters.
- **Role-Based Access Control (RBAC)**: Distinct permissions for Manager, Staff, and Guest.
- **Department Management**: Full CRUD operations restricted to Managers.
- **Student Management**: Full CRUD operations for Staff.
- **Top 5 highest GPA view** for Managers.
- Automated tracking of record creation (`created_at`, `created_by`) and updates (`updated_at`).
- Business rules enforce that users can only update/delete students they have created.
- **JPA Pagination**: Efficient data loading displaying 5 students per page.
- **Automated Initialization**: Uses Servlet Listeners to initialize the `EntityManagerFactory` and automatically seed database with sample data on the first run.
- **Modern UI/UX**: Completely restyled using Tailwind CSS for a premium, responsive, and user-friendly experience.

## 🛠️ Technology Stack

**Backend (Server-side):**
- Java Version: Java 11+
- Core: Servlet API, JSP (JavaServer Pages), JSTL
- ORM: JPA (Jakarta Persistence) with Hibernate Provider
- Server: Apache Tomcat 9.0+

**Frontend (Client-side):**
- Styling: Tailwind CSS (via CDN)
- Fonts/Icons: Google Fonts (Inter) & Google Material Symbols

**Database:**
- RDBMS: MySQL / SQL Server
- Connection: JDBC / JPA `persistence.xml`

## 🏗️ Architecture Design

The application strictly adheres to the MVC N-Layered Architecture:

1. **View Layer (JSP):** Renders data and captures user inputs.
2. **Controller Layer (Servlets):** Handles HTTP requests, manages navigation flow, validates inputs, and delegates tasks to the DAO layer. Controllers never access the database directly.
3. **DAO Layer:** Manages all data access operations using JPA (`EntityManager`).
4. **Entity Layer:** Java POJOs mapped to relational database tables via JPA Annotations (`@Entity`, `@Table`, `@ManyToOne`, etc.).

## 👥 Roles & Permissions

| Role      | Access Level | Permissions                                                                 |
|-----------|--------------|----------------------------------------------------------------------------|
| Manager   | High         | Manage Departments (CRUD). View Top 5 Students with the highest GPA. Cannot perform CRUD on students.
| Staff     | Medium       | Full Student CRUD operations (Add, Edit, Delete). Can view the paginated student list. Cannot manage departments.
| Guest     | Low          | Read-only access or restricted dashboard views.

## 🗄️ Database Schema

The database (`PRJ301`) is structured with JPA Object-Relational Mapping:

- `user_accounts`: Stores `id`, `username`, `password`, and `role`.
- `departments`: Stores `id` and `departmentname` (5-50 chars constraint).
- `students`: Stores `id`, `studentid`, `name`, `gpa`, foreign key `department_id`, and tracking timestamps (`created_at`, `updated_at`, `created_by`).

**Relationship:** `Student` → `Department` is `@ManyToOne`.

## ⚙️ Installation & Setup Guide

### Prerequisites

- JDK 11 or higher
- Apache Tomcat 9.0+
- MySQL Server or SQL Server
- IDE (NetBeans, IntelliJ IDEA Ultimate, or Eclipse Enterprise)

### Steps to Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/PRJ301-Student-Management.git
   cd PRJ301-Student-Management
   ```

2. **Database Configuration:**
   - Create an empty database named `PRJ301` in your SQL Server/MySQL.
   - Navigate to `src/conf/META-INF/persistence.xml` (or `src/main/resources/META-INF/persistence.xml`).
   - Update the database connection properties (URL, username, password):
     ```xml
     <property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/PRJ301"/>
     <property name="javax.persistence.jdbc.user" value="your_db_username"/>
     <property name="javax.persistence.jdbc.password" value="your_db_password"/>
     <property name="hibernate.hbm2ddl.auto" value="update"/> <!-- Generates schema automatically -->
     ```

3. **Build and Deploy:**
   - Open the project in your IDE.
   - Clean and Build the project.
   - Add your Apache Tomcat Server to the project.
   - Run the project.

4. **First Run Initialization:**
   - Thanks to the built-in `ServletContextListener`, the database tables and sample data (Admin accounts, mock departments, and students) will be automatically generated upon the first successful server startup.

5. **Access the Application:**
   - Open your browser and go to: `http://localhost:8080/YourProjectName/`

6. **Default accounts (if configured in Listener):**
   - Manager: `admin` / `admin123`
   - Staff: `staff` / `staff123`

## 📝 Business Rules Implemented

- **Validation:** Student names must be 5-50 chars. GPA must be between 0.0 and 10.0.
- **Data Integrity:** A student cannot be saved without a valid Department.
- **Audit Trail:** The system automatically injects the logged-in user's username into `created_by` and sets the current date for `created_at` and `updated_at`.
- **Ownership:** Staff members can only edit or delete records that they personally created.

Developed for PRJ301 Course Requirement.
