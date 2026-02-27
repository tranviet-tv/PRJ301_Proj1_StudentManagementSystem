<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management Page</title>
    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 5px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;}
        .error { color: red; font-weight: bold; }
        .pagination { margin-top: 15px; }
        .pagination a { margin-right: 10px; text-decoration: none; padding: 5px 10px; border: 1px solid #ccc; }
        .pagination .active { background-color: #007bff; color: white; border-color: #007bff; }
    </style>
</head>
<body>
    <div class="header">
        <h2>Student Management System</h2>
        <div>
            Welcome, <b>${sessionScope.user.username}</b> (Role: ${sessionScope.user.role == 1 ? 'Manager' : 'Staff'})
            <a href="logout" style="margin-left: 15px; color: red;">Logout</a>
        </div>
    </div>

    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <c:if test="${sessionScope.user.role == 2}">
        <h3>${not empty studentEdit ? 'Edit Student' : 'Add New Student'}</h3>
        <form action="student" method="post">
            <input type="hidden" name="action" value="${not empty studentEdit ? 'update' : 'add'}">
            <input type="hidden" name="id" value="${studentEdit.id}">

            <table>
                <tr>
                    <td>Student ID:</td>
                    <td><input type="text" name="studentId" value="${studentEdit.studentId}" required></td>
                </tr>
                <tr>
                    <td>Name:</td>
                    <td><input type="text" name="name" value="${studentEdit.name}" required></td>
                </tr>
                <tr>
                    <td>GPA:</td>
                    <td><input type="number" step="0.1" name="gpa" value="${studentEdit.gpa}" required></td>
                </tr>
                <tr>
                    <td>Department:</td>
                    <td>
                        <select name="departmentId" required>
                            <option value="">-- Select Department --</option>
                            <c:forEach items="${departments}" var="dept">
                                <option value="${dept.id}" ${studentEdit.department.id == dept.id ? 'selected' : ''}>
                                    ${dept.departmentname}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <c:choose>
                            <c:when test="${not empty studentEdit}">
                                <button type="submit">Update</button>
                                <a href="student">Cancel</a>
                            </c:when>
                            <c:otherwise>
                                <button type="submit">Add</button>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
        </form>
        <hr>
    </c:if>

    <h3>Student List</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Student ID</th>
                <th>Name</th>
                <th>GPA</th>
                <th>Department</th>
                <th>Created By</th>
                <th>Created At</th>
                <th>Updated At</th>
                <c:if test="${sessionScope.user.role == 2}">
                    <th>Actions</th>
                </c:if>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listStudents}" var="s">
                <tr>
                    <td>${s.id}</td>
                    <td>${s.studentId}</td>
                    <td>${s.name}</td>
                    <td>${s.gpa}</td>
                    <td>${s.department.departmentname}</td>
                    <td>${s.createdBy}</td>
                    <td>${s.createdAt}</td>
                    <td>${s.updatedAt}</td>
                    
                    <c:if test="${sessionScope.user.role == 2}">
                        <td>
                            <c:if test="${sessionScope.user.username == s.createdBy}">
                                <a href="student?action=edit&id=${s.id}">Edit</a> | 
                                <a href="student?action=delete&id=${s.id}">Delete</a>
                            </c:if>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${sessionScope.user.role == 2 && totalPages > 1}">
        <div class="pagination">
            <span>Page: </span>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="student?page=${i}" class="${currentPage == i ? 'active' : ''}">
                    ${i}
                </a>
            </c:forEach>
        </div>
    </c:if>

</body>
</html>