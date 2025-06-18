<%-- 
    Document   : registerPage
    Created on : Jun 6, 2025, 1:46:36 PM
    Author     : wafa & aniq
--%>
<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
  <p style="color:red; text-align:center;"><%= error %></p>
<% } %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - Student Activities Management System</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', Arial, sans-serif;
      background-color: #ffffff;
      height: 100vh;
      overflow: hidden;
    }

    .header {
      background-color: #0a8079;
      color: white;
      padding: 20px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .header img {
      height: 60px;
      margin-left: 20px;
    }

    .header h1 {
      font-size: 36px;
      margin-right: 40px;
    }

    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: calc(100vh - 100px);
      padding: 20px;
    }

    .form-section {
      display: flex;
      gap: 30px;
      background-color: #f8f8f8;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      max-height: calc(100vh - 140px);
      overflow-y: auto;
    }

    .form-column {
      width: 400px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      font-weight: bold;
      font-size: 16px;
      display: block;
      margin-bottom: 5px;
      color: #333;
    }

    .form-group input,
    .form-group select {
      width: 100%;
      padding: 10px;
      font-size: 14px;
      background-color: #ffffff;
      border: 1px solid #ddd;
      border-radius: 5px;
      transition: border-color 0.3s ease;
    }

    .form-group input:focus,
    .form-group select:focus {
      border-color: #0a8079;
      outline: none;
    }

    .password-toggle {
      position: relative;
    }

    .password-toggle button {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      font-size: 20px;
      cursor: pointer;
      color: #666;
    }

    .submit-section {
      text-align: center;
      margin-top: 30px;
      grid-column: 1 / -1;
    }

    .submit-section button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      background-color: #0a8079;
      color: white;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .submit-section button:hover {
      background-color: #086e68;
    }

    .signin-link {
      margin-top: 15px;
      font-size: 14px;
      color: #666;
    }

    .signin-link a {
      color: #0a8079;
      text-decoration: none;
      font-weight: bold;
    }

    .signin-link a:hover {
      text-decoration: underline;
    }

    .required {
      color: #ff4444;
    }
  </style>
</head>
<body>
  <div class="header">
    <img src="image/logoUMP.jpg" alt="UMP Logo">
    <h1>REGISTER</h1>
    <div style="width: 60px;"></div>
  </div>

  <div class="container">
    <form class="form-section" action="RegisterPageServlet" method="post">
      <div class="form-column">
        <div class="form-group">
          <label>Student ID <span class="required">*</span></label>
          <input type="text" name="studID" placeholder="Enter your ID" required>
        </div>
        
        <div class="form-group">
          <label>Full Name <span class="required">*</span></label>
          <input type="text" name="studName" placeholder="Enter your full name" required>
        </div>

        <div class="form-group password-toggle">
          <label>Password <span class="required">*</span></label>
          <input type="password" id="password" name="studPassword" placeholder="Enter your password" required>
          <button type="button" onclick="togglePassword('password')">👁️</button>
        </div>
        
        <div class="form-group password-toggle">
          <label>Confirm Password <span class="required">*</span></label>
          <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
          <button type="button" onclick="togglePassword('confirmPassword')">👁️</button>
        </div>
        
        <div class="form-group">
          <label>Email <span class="required">*</span></label>
          <input type="email" name="studEmail" placeholder="Enter your Email" required>
        </div>

        <div class="form-group">
          <label>Course <span class="required">*</span></label>
          <input type="text" name="studCourse" placeholder="Enter your Course" required>
        </div>
      </div>

      <div class="form-column">
        <div class="form-group">
          <label>Semester <span class="required">*</span></label>
          <input type="text" name="studSemester" placeholder="Enter your Current Semester" required>
        </div>
        
        <div class="form-group">
          <label>Phone No <span class="required">*</span></label>
          <input type="text" name="studNoPhone" placeholder="Enter your phone number" required>
        </div>

        <div class="form-group">
          <label>Date of Birth <span class="required">*</span></label>
          <input type="date" name="dob" required>
        </div>

        <div class="form-group">
          <label>MUET Results <span class="required">*</span></label>
          <select name="muetStatus" required>
            <option value="" disabled selected>Select MUET Band</option>
            <option value="Band 3.0">Band 3.0</option>
            <option value="Band 3.5">Band 3.5</option>
            <option value="Band 4.0">Band 4.0</option>
            <option value="Band 4.5">Band 4.5</option>
            <option value="Band 5.0">Band 5.0</option>
            <option value="Band 5.5">Band 5.5</option>
            <option value="Band 6.0">Band 6.0</option>
            <option value="Not Taken">Not Taken</option>
          </select>
        </div>

        <div class="form-group">
          <label>Student Advisor <span class="required">*</span></label>
          <input type="text" name="advisor" placeholder="Enter your advisor's name" required>
        </div>

        <div class="form-group">
          <label>User <span class="required">*</span></label>
          <select name="studType" required>
            <option value="" disabled selected>Select Role</option>
            <option value="admin">Admin</option>
            <option value="student">Student</option>
          </select>
        </div>
      </div>

      <div class="submit-section">
        <button type="submit">SIGN UP</button>
        <div class="signin-link">
          Already have an account? <a href="index.jsp">Sign In</a>
        </div>
      </div>
    </form>
  </div>

  <script>
    function togglePassword(id) {
      const input = document.getElementById(id);
      if (input.type === "password") {
        input.type = "text";
      } else {
        input.type = "password";
      }
    }
  </script>
</body>
</html>
