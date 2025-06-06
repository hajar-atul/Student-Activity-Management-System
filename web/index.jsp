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
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f2ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h2 {
            text-align: center;
            color: #003366;
            margin-bottom: 25px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .roles {
            margin-top: 15px;
        }

        .roles label {
            font-weight: normal;
            display: inline-block;
            margin-right: 15px;
        }

        .roles input[type="radio"] {
            margin-right: 5px;
        }

        .forgot-password {
            margin-top: 10px;
            text-align: right;
        }

        .forgot-password a {
            font-size: 0.9em;
            color: #0066cc;
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            background-color: #003366;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #002244;
        }

        .signup {
            text-align: center;
            margin-top: 15px;
        }

        .signup a {
            text-decoration: none;
            color: #0066cc;
            font-weight: bold;
        }

        .signup a:hover {
            text-decoration: underline;
        }
    </style>
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
            Don’t have an account? <a href="RegisterPage.jsp">SIGN UP</a>
        </div>
    </div>
</body>
</html>
