-- Tạo Database (Nếu bạn chưa có)
-- CREATE DATABASE PRJ301_Project1;
-- GO
-- USE PRJ301_Project1;
-- GO

-- 1. TẠO BẢNG user_accounts
CREATE TABLE user_accounts (
    id INT IDENTITY(1,1) PRIMARY KEY, -- Auto-increment trong SQL Server là IDENTITY
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role INT NOT NULL CHECK (role IN (1, 2, 3)) -- 1 = Manager, 2 = Staff, 3 = Guest
);
GO

-- 2. TẠO BẢNG departments
CREATE TABLE departments (
    id INT PRIMARY KEY, -- Theo thiết kế không ghi auto-increment nên ta nhập thủ công
    departmentname VARCHAR(50) NOT NULL CHECK (LEN(departmentname) >= 5 AND LEN(departmentname) <= 50)
);
GO

-- 3. TẠO BẢNG students
CREATE TABLE students (
    id INT PRIMARY KEY, -- Giống departments, nhập thủ công
    studentid NVARCHAR(20) UNIQUE NOT NULL,
    name NVARCHAR(50) NOT NULL CHECK (LEN(name) >= 5 AND LEN(name) <= 50),
    gpa FLOAT CHECK (gpa >= 0 AND gpa <= 10),
    department_id INT,
    created_at DATE,
    updated_at DATE,
    created_by NVARCHAR(50), -- Username của người tạo
    FOREIGN KEY (department_id) REFERENCES departments(id) -- Many-to-One
);
GO

-- ==========================================
-- CHÈN DỮ LIỆU MẪU (SAMPLE DATA)
-- ==========================================

-- Dữ liệu mẫu bảng user_accounts
INSERT INTO user_accounts (username, password, role) VALUES 
('manager_admin', '123456', 1),
('staff_john', '123456', 2),
('guest_user', '123456', 3);
GO

-- Dữ liệu mẫu bảng departments
INSERT INTO departments (id, departmentname) VALUES 
(1, 'Software Engineering'),
(2, 'Artificial Intelligence'),
(3, 'Information Assurance');
GO

-- Dữ liệu mẫu bảng students
INSERT INTO students (id, studentid, name, gpa, department_id, created_at, updated_at, created_by) VALUES 
(1, 'SE12345', 'Nguyen Van A', 8.5, 1, CAST(GETDATE() AS DATE), CAST(GETDATE() AS DATE), 'manager_admin'),
(2, 'AI67890', 'Tran Thi B', 9.2, 2, CAST(GETDATE() AS DATE), CAST(GETDATE() AS DATE), 'staff_john'),
(3, 'IA11223', 'Le Van C', 7.0, 3, '2024-01-15', '2024-02-12', 'manager_admin');
GO