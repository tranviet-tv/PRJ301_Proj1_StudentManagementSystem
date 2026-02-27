<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : department
    Created on : Feb 26, 2026, 9:43:49 PM
    Author     : tranv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Department Manager</title>
    </head>
    <body>
        <form action="department" method="POST">
            ID<input type="text" name="id" value="" /><br> 
            Department Name<input type="text" name="departmentname" value="" /> <br> 
            
            <input type="submit" value="add" name="action" />
            <input type="submit" value="update" name="action" />
        </form>
        
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>DEPARTMENT NAME</th>
                    <th>EDIT</th>
                    <th>DELETE</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dep" items="${requestScope.listDepartments}">
                <tr>
                    <td>${dep.getId()}</td>
                    <td>${dep.getDepartmentname()}</td>
                    <td><form name="edit" action="department">
                        </form></td>
                    <td></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </body>
</html>
