-- Tạo Database (Nếu bạn chưa có)
-- CREATE DATABASE PRJ301_Project1;
-- GO
-- USE PRJ301_Project1;
-- GO


-- ==========================================================
-- 1. INSERT DATA FOR DEPARTMENTS (5 rows)
-- ==========================================================
-- Lưu ý: id của department được nhập thủ công vì không có auto-increment
INSERT INTO departments (id, departmentname) VALUES 
(1, 'Software Engineering'),
(2, 'Information Assurance'),
(3, 'Business Administration'),
(4, 'Graphic Design'),
(5, 'Artificial Intelligence');

-- ==========================================================
-- 2. INSERT DATA FOR STUDENTS (40 rows)
-- ==========================================================
-- Lưu ý: Cột 'id' trong bảng sinh viên tự tăng (IDENTITY) nên không cần insert.
INSERT INTO students (studentid, name, gpa, department_id, created_at, updated_at, created_by) VALUES
-- Software Engineering (8 students)
('SE160001', 'Nguyen Van A', 8.5, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('SE160002', 'Tran Thi B', 7.2, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('SE160003', 'Le Hoang C', 9.1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('SE160004', 'Pham Van D', 6.8, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('SE160005', 'Hoang Thi E', 8.9, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('SE160006', 'Vuong Hao F', 5.5, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('SE160007', 'Dang Tuan G', 7.9, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('SE160008', 'Ngo Thanh H', 8.0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),

-- Information Assurance (8 students)
('IA160009', 'Bui Xuan I', 6.5, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('IA160010', 'Dinh Quoc J', 9.5, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('IA160011', 'Ly Gia K', 7.4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('IA160012', 'Chau Phat L', 8.2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('IA160013', 'Truong My M', 9.0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('IA160014', 'Mai Anh N', 7.8, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('IA160015', 'Doan Khac O', 5.9, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('IA160016', 'Ton Nu P', 8.6, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),

-- Business Administration (8 students)
('BA160017', 'Ho Dang Q', 7.0, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('BA160018', 'Nguyen Quynh R', 9.2, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('BA160019', 'Tran Minh S', 6.7, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('BA160020', 'Le Anh T', 8.1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('BA160021', 'Pham Hoang U', 7.5, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('BA160022', 'Vo Tuan V', 5.2, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('BA160023', 'Vu Duc W', 8.8, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('BA160024', 'Dang My X', 9.4, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),

-- Graphic Design (8 students)
('GD160025', 'Nguyen Yen Y', 8.4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('GD160026', 'Tran Thanh Z', 6.9, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('GD160027', 'Le Phuong A1', 7.7, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('GD160028', 'Pham Kieu B1', 9.6, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('GD160029', 'Hoang Nhat C1', 8.3, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('GD160030', 'Vo Truc D1', 6.0, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('GD160031', 'Dang Ngoc E1', 8.7, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('GD160032', 'Ngo Bao F1', 7.1, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),

-- Artificial Intelligence (8 students)
('AI160033', 'Bui Hai G1', 9.8, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('AI160034', 'Dinh Tuan H1', 8.5, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('AI160035', 'Ly Kien I1', 7.3, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('AI160036', 'Chau Van J1', 6.4, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('AI160037', 'Truong Quoc K1', 9.1, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('AI160038', 'Mai Tien L1', 8.0, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('AI160039', 'Doan Vu M1', 7.6, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user'),
('AI160040', 'Ton That N1', 8.9, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'staff_user');