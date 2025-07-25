<%-- 
    Document   : Login
    Created on : Jun 6, 2025, 3:56:06 PM
    Author     : wafa
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
      height: 60px; 
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
      background-image: url("image/umpsa_1.png"); 
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

    /* Role selector styles */
    .roles {
      margin-bottom: 10px;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 10px;
    }

    .roles input[type="radio"] {
      display: none;
    }

    .roles label {
      font-weight: normal;
      font-size: 1.1em;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      background-color: #f0f0f0;
      color: #333;
      transition: background-color 0.3s, color 0.3s;
    }

    .roles label:hover {
      background-color: #cceeff;
      color: #0066cc;
    }

    .roles input[type="radio"]:checked + label {
      background-color: #0066cc;
      color: white;
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
      background-color: #e0ffff;
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

    .error-message {
      color: red;
      font-size: 0.9em;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>

  <!-- Header -->
  <div class="header">
    <img src="image/logoUMP.jpg" alt="Logo" class="logo">
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

  <% if ("invalid_role".equals(request.getParameter("error"))) { %>
    <p style="color:red; font-weight: bold; margin-bottom: 20px;">
      Please select a valid role before submitting.
    </p>
  <% } %>
  <% if ("wrong_password".equals(request.getParameter("error"))) { %>
    <p style="color:red; font-weight: bold; margin-bottom: 20px;">
      Wrong password. Please try again.
    </p>
  <% } %>

  <form action="<%= request.getContextPath() %>/LoginServlet" method="post" onsubmit="return validateForm();">


        <div class="roles" id="roleContainer">
          <input type="radio" id="admin" name="role" value="admin" onclick="location.href='indexAdmin.jsp'">
          <label for="admin">Admin</label>

          <input type="radio" id="staff" name="role" value="staff" onclick="location.href='indexStaff.jsp'">
          <label for="staff">Staff</label>

          <input type="radio" id="club" name="role" value="club" onclick="location.href='indexClub.jsp'">
          <label for="club">Club</label>

          <input type="radio" id="student" name="role" value="student" onclick="location.href='indexStudent.jsp'">
          <label for="student">Student</label>
        </div>

        <p id="roleError" class="error-message"></p>

        <label>Username:</label>
        <input type="text" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <div class="forgot-password">
          <a href="#">Forgot Password?</a>
        </div>

        <button type="submit" class="button">SIGN IN</button>
        <button type="button" class="button">SIGN UP</button>

      </form>
    </div>
  </div>

  <!-- JS Validation -->
  <script>
    function validateForm() {
      const roles = document.getElementsByName("role");
      let selected = false;

      for (let i = 0; i < roles.length; i++) {
        if (roles[i].checked) {
          selected = true;
          break;
        }
      }

      if (!selected) {
        document.getElementById("roleError").innerText = "You haven't selected a role!";
        return false;
      }

      document.getElementById("roleError").innerText = "";
      return true;
    }
  </script>

</body>
</html>
