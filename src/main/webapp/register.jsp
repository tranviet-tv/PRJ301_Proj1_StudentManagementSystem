<%-- 
    Document   : register
    Created on : Feb 25, 2026, 11:21:56 PM
    Author     : tranv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>register Page</title>
    </head>
    <body>
        <form action="register" method="POST">
            Full Name<input type="text" name="fullname" value="" /> <br> 
            User Name<input type="text" name="username" value="" /> <br>
            Password<input type="password" name="password" value="" /> <br> 
            Role<select name="role">
                <option value="1">Manager</option>
                <option value="2">Staff</option>
                <option value="3">Guest</option>
            </select>
            <input type="submit" value="register" name="Register"/>
        </form>
        
    </body>
</html>
