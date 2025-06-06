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
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', Arial, sans-serif;
      background-color: #e6f2ff;
      height: 100vh;
      display: flex;
      flex-direction: column;
    }

    /* Header bar */
    .header {
  background-color: #0a8079;
  color: white;
  padding: 20px 40px;
  display: flex;
  align-items: center;
}

.logo {
  height: 60px; /* Adjust size as needed */
  margin-right: 20px;
}

.header-text {
  display: flex;
  flex-direction: column;
}

.header-text .welcome {
  font-size: 32px;
  font-weight: bold;
}

.header-text .system-name {
  font-size: 22px;
  margin-top: 5px;
}


    /* Layout wrapper */
    .main-content {
      display: flex;
      flex: 1;
    }

    /* Left image section */
    .image-section {
      flex: 1;
      background-image: url("umpsa.jpg"); /* Replace with actual path */
      background-size: cover;
      background-position: center;
    }

    /* Right login form */
    .login-container {
      flex: 1;
      background-color: white;
      padding: 50px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
    }

    .login-container form {
      width: 100%;
      max-width: 400px;
    }

    .roles {
      margin-bottom: 30px;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
    }

    .roles label {
      font-weight: normal;
      font-size: 1.1em;
      margin-right: 10px;
    }

    label {
      font-weight: bold;
      margin-top: 15px;
      display: block;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      background-color: #e0ffff; /* Light cyan */
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .forgot-password {
      text-align: right;
      margin-top: 10px;
      margin-bottom: 20px;
    }

    .forgot-password a {
      font-size: 0.9em;
      color: #0066cc;
      text-decoration: none;
    }

    .forgot-password a:hover {
      text-decoration: underline;
    }

    .button {
      width: 100%;
      padding: 12px;
      background-color: #007b7b;
      color: white;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      margin-bottom: 15px;
      cursor: pointer;
      font-size: 1em;
    }

    .button:hover {
      background-color: #005f5f;
    }

  </style>
</head>
<body>

  <!-- Header -->
  <div class="header">
    <img src="logoUMP.jpg" alt="Logo" class="logo">
    <div class="header-text">
      <div class="welcome">Welcome To</div>
      <div class="system-name">STUDENT ACTIVITIES MANAGEMENT SYSTEM</div>
    </div>
  </div>   

  <!-- Page layout -->
  <div class="main-content">
    
    <!-- Left half image -->
    <div class="image-section"></div>

    <!-- Right login form -->
    <div class="login-container">
      <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
        
        <div class="roles">
          <label><input type="radio" name="role" value="admin" required> Admin</label>
          <label><input type="radio" name="role" value="staff"> Staff</label>
          <label><input type="radio" name="role" value="club"> Club</label>
          <label><input type="radio" name="role" value="student"> Student</label>
        </div>

        <label>Username:</label>
        <input type="text" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <div class="forgot-password">
          <a href="#">Forgot Password?</a>
        </div>

        <button type="submit" class="button">SIGN IN</button>
        <button type="button" class="button" onclick="location.href='register.jsp'">SIGN UP</button>

      </form>
    </div>
  </div>

</body>
</html>
