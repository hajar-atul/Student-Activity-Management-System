<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Promote Student to Admin - Student Activities Management System</title>
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
      background-color: #f8f8f8;
      padding: 30px 40px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      min-width: 350px;
      max-width: 400px;
      width: 100%;
    }
    .form-group {
      margin-bottom: 25px;
    }
    .form-group label {
      font-weight: bold;
      font-size: 16px;
      display: block;
      margin-bottom: 5px;
      color: #333;
    }
    .form-group input {
      width: 100%;
      padding: 10px;
      font-size: 14px;
      background-color: #ffffff;
      border: 1px solid #ddd;
      border-radius: 5px;
      transition: border-color 0.3s ease;
    }
    .form-group input:focus {
      border-color: #0a8079;
      outline: none;
    }
    .submit-section {
      text-align: center;
      margin-top: 30px;
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
    .message {
      text-align: center;
      margin-bottom: 15px;
      color: #d8000c;
      background: #ffd2d2;
      padding: 10px;
      border-radius: 5px;
      font-size: 15px;
    }
    .success {
      color: #155724;
      background: #d4edda;
    }
  </style>
</head>
<body>
  <div class="header">
    <img src="image/logoUMP.jpg" alt="UMP Logo">
    <h1>PROMOTE TO ADMIN</h1>
    <div style="width: 60px;"></div>
  </div>
  <div class="container">
    <form class="form-section" action="AdminRegisterServlet" method="post">
      <% if (request.getParameter("status") != null) { %>
        <div class="message <%= "success".equals(request.getParameter("status")) ? "success" : "" %>">
          <%= "success".equals(request.getParameter("status")) ? "Admin added successfully!" : (request.getParameter("message") != null ? request.getParameter("message").replace("+", " ") : "Error occurred.") %>
        </div>
      <% } %>
      <div class="form-group">
        <label>Student ID <span style="color:#ff4444;">*</span></label>
        <input type="text" name="studID" placeholder="Enter existing Student ID" required>
      </div>
      <div class="form-group">
        <label>Admin Email <span style="color:#ff4444;">*</span></label>
        <input type="email" name="adminEmail" placeholder="Enter admin email (e.g. 2006@mpp.ump.my)" required>
      </div>
      <div class="submit-section">
        <button type="submit">Promote to Admin</button>
      </div>
    </form>
  </div>
</body>
</html> 