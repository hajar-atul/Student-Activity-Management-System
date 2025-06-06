<%-- 
    Document   : Login
    Created on : Jun 6, 2025, 3:56:06 PM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Student Activities Management System</title>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
    <label>Username:</label>
    <input type="text" name="email" required>

    <label>Password:</label>
    <input type="password" name="password" required>

    <div class="roles">
        <label><input type="radio" name="role" value="admin" required> Admin</label>
        <label><input type="radio" name="role" value="staff"> Staff</label>
        <label><input type="radio" name="role" value="club"> Club</label>
        <label><input type="radio" name="role" value="student"> Student</label>
    </div>

    <div class="forgot-password">
        <a href="#">Forgot password?</a>
    </div>

    <input type="submit" value="SIGN IN">
</form>


        <div class="signup">
            Don’t have an account? <a href="register.jsp">SIGN UP</a>
        </div>
    </div>
</body>
</html>
