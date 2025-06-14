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
      padding: 40px;
    }

    .form-section {
      width: 500px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      font-weight: bold;
      font-size: 18px;
      display: block;
      margin-bottom: 5px;
    }

    .form-group input,
    .form-group select {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      background-color: #dcdcdc;
      border: 1px solid #ccc;
      border-radius: 5px;
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
    }

    .submit-section {
      text-align: center;
      margin-top: 30px;
    }

    .submit-section button {
      width: 100%;
      padding: 15px;
      font-size: 18px;
      background-color: #59a8a8;
      color: white;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .submit-section button:hover {
      background-color: #3f8e8e;
    }

    .signin-link {
      margin-top: 15px;
      font-size: 16px;
    }

    .signin-link a {
      color: blue;
      text-decoration: none;
      font-weight: bold;
    }

    .signin-link a:hover {
      text-decoration: underline;
    }

    .required {
      color: red;
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
    <!-- Registration Form -->
    <form class="form-section" action="RegisterPageServlet" method="post">
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
          <option value="Band 1">Band 1</option>
          <option value="Band 2">Band 2</option>
          <option value="Band 3">Band 3</option>
          <option value="Band 4">Band 4</option>
          <option value="Band 5">Band 5</option>
          <option value="Band 6">Band 6</option>
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

      <!-- Submit Button -->
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
