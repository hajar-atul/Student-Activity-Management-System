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
      gap: 40px;
      padding: 40px;
    }

    .profile-section {
      text-align: center;
    }

    .profile-section label {
      display: block;
      margin-bottom: 10px;
      font-weight: bold;
      font-size: 18px;
    }

    .profile-img {
      width: 200px;
      height: 200px;
      border: 5px solid black;
      border-radius: 50%;
      background-color: #f2f2f2;
      background-image: url('https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png');
      background-size: 70%;
      background-repeat: no-repeat;
      background-position: center;
      margin: 10px auto;
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
    <img src="logoUMP.jpg" alt="UMP Logo">
    <h1>REGISTER</h1>
    <div style="width: 60px;"></div>
  </div>

  <div class="container">
    <!-- Profile Image -->
    <div class="profile-section">
      <label>Profile Picture <span class="required">*</span></label>
      <div class="profile-img"></div>
      <input type="file" name="profileImage" accept="image/*" required>
      <p>Select Image</p>
    </div>

    <!-- Registration Form -->
    <form class="form-section" action="RegisterServlet" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label>Full Name <span class="required">*</span></label>
        <input type="text" name="fullName" placeholder="Enter your full name" required>
      </div>

      <div class="form-group">
        <label>ID <span class="required">*</span></label>
        <input type="text" name="userId" placeholder="Enter your ID" required>
      </div>

      <div class="form-group">
        <label>User <span class="required">*</span></label>
        <select name="userRole" required>
          <option value="" disabled selected>Select Role</option>
          <option value="admin">Admin</option>
          <option value="student">Student</option>
        </select>
      </div>

      <div class="form-group">
        <label>Email <span class="required">*</span></label>
        <input type="email" name="email" placeholder="Enter your Email" required>
      </div>

      <div class="form-group password-toggle">
        <label>Password <span class="required">*</span></label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>
        <button type="button" onclick="togglePassword('password')">👁️</button>
      </div>

      <div class="form-group password-toggle">
        <label>Confirm Password <span class="required">*</span></label>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
        <button type="button" onclick="togglePassword('confirmPassword')">👁️</button>
      </div>

      <!-- Submit Button -->
      <div class="submit-section">
        <button type="submit">SIGN UP</button>
        <div class="signin-link">
          Already have an account? <a href="login.jsp">Sign In</a>
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