<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .form-container {
            width: 400px;
            margin: auto;
        }
        input[type=text], input[type=password], input[type=email], select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            box-sizing: border-box;
        }
        .submit-btn {
            background-color: teal;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Register</h2>
    <form action="RegisterServlet" method="post" enctype="multipart/form-data">
        <label>Full Name:</label>
        <input type="text" name="fullName" required>

        <label>ID:</label>
        <input type="text" name="id" required>

        <label>User Type:</label>
        <select name="userType" required>
            <option value="Student">Student</option>
            <option value="Admin">Admin</option>
        </select>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <label>Confirm Password:</label>
        <input type="password" name="confirmPassword" required>

        <label>Profile Picture:</label>
        <input type="file" name="profilePic" accept="image/*" required>

        <input type="submit" value="Sign Up" class="submit-btn">
    </form>
    <p>Already have an account? <a href="login.jsp">Sign In</a></p>
</div>

</body>
</html>
