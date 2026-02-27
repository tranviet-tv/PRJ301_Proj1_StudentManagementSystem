<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : login
    Created on : Feb 25, 2026, 7:14:04 PM
    Author     : tranv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Login Page</h1>
        <form action="login" method="POST">
            Username <input type="text" name="username" value="" /> <br>
            Password <input type="password" name="password" value="" /> <br>
            <c:if test="${not empty msg}">
                <div> 
                    ${msg}
                </div>
            </c:if>
            <input type="submit" value="Login" name="Login" />
        </form>
    </body>
</html>
