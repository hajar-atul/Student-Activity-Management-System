<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Promote Student to Admin - Student Activities Management System</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; }
    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #238B87;
      color: white;
      position: fixed;
      padding: 40px 20px 20px 20px;
      overflow-y: auto;
      z-index: 10;
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .sidebar img.profile-pic {
      width: 170px;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 30px;
      border: 3px solid white;
      background: #fff;
    }
    .sidebar ul {
      list-style: none;
      padding-left: 0;
      margin-top: 20px;
      width: 100%;
    }
    .sidebar ul li {
      margin-bottom: 15px;
    }
    .sidebar ul li a {
      color: white;
      text-decoration: none;
      padding: 12px 0;
      display: block;
      border-radius: 5px;
      font-size: 16px;
      transition: background-color 0.2s ease;
      width: 100%;
      text-align: center;
    }
    .sidebar ul li a.active, .sidebar ul li a:hover {
      background-color: #1a7e7c;
      font-weight: bold;
    }
    .main-content {
      margin-left: 270px;
      min-height: 100vh;
      background: #f6f6f6;
    }
    .header {
      display: flex;
      align-items: center;
      background-color: #238B87;
      color: #fff;
      padding: 18px 40px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
      position: sticky;
      top: 0;
      z-index: 5;
      gap: 20px;
      justify-content: space-between;
    }
    .header-title {
      font-size: 32px;
      font-weight: bold;
      letter-spacing: 1px;
    }
    .header .top-icons {
      display: flex;
      align-items: center;
      gap: 18px;
      position: relative;
    }
    .header .top-icons img {
      width: 45px;
      height: 45px;
      object-fit: contain;
      background: transparent;
    }
    .header .top-icons .profile-icon {
      width: 45px;
      height: 45px;
      border-radius: 50%;
      border: none;
      background: transparent;
    }
    .notification-dropdown {
      display: none;
      position: absolute;
      top: 60px;
      right: 60px;
      background-color: #fff;
      color: #222;
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 14px 18px;
      width: 240px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      z-index: 100;
      font-size: 16px;
    }
    .activity-btn {
      width: 100%;
      padding: 15px;
      background-color: #f44336;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.2s;
      margin: 0;
    }
    .activity-btn:hover {
      background-color: #d32f2f;
    }
    /* Remove sidebar and header styles */
    /* Keep only main content styles */
    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: calc(100vh - 100px);
      padding: 40px 0;
      width: 100%;
      max-width: 900px;
      margin: 0 auto;
    }
    .form-section {
      background: #fff;
      padding: 56px 56px 48px 56px;
      border-radius: 10px;
      box-shadow: none;
      min-width: 500px;
      max-width: 700px;
      width: 100%;
      border: 1px solid #e0e0e0;
      display: flex;
      flex-direction: column;
      gap: 28px;
    }
    .form-section label {
      font-weight: 500;
      font-size: 15px;
      color: #222;
      margin-bottom: 6px;
      letter-spacing: 0.1px;
    }
    .form-section input[type="text"],
    .form-section input[type="email"] {
      width: 100%;
      padding: 11px 14px;
      font-size: 15px;
      background: #fafbfc;
      border: 1.2px solid #d0e2e2;
      border-radius: 6px;
      transition: border-color 0.2s, box-shadow 0.2s;
      outline: none;
      color: #222;
      margin-bottom: 2px;
    }
    .form-section input[type="text"]:focus,
    .form-section input[type="email"]:focus {
      border-color: #0a8079;
      box-shadow: 0 0 0 2px #d0f0ef;
      background: #fff;
    }
    .form-group {
      margin-bottom: 0;
      display: flex;
      flex-direction: column;
      gap: 2px;
    }
    .submit-section {
      margin-top: 10px;
      text-align: center;
    }
    .submit-section button {
      width: 100%;
      padding: 12px 0;
      font-size: 16px;
      background: #0a8079;
      color: #fff;
      font-weight: 600;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background 0.2s, box-shadow 0.2s;
      box-shadow: none;
      letter-spacing: 0.5px;
    }
    .submit-section button:hover {
      background: #00796B;
      box-shadow: 0 2px 8px rgba(10,128,121,0.08);
    }
    .message {
      text-align: center;
      margin-bottom: 10px;
      color: #d8000c;
      background: #fff6f6;
      padding: 10px 0;
      border-radius: 5px;
      font-size: 15px;
      border: 1px solid #ffd2d2;
    }
    .success {
      color: #155724;
      background: #f2fff6;
      border: 1px solid #b2f7d4;
    }
    @media (max-width: 900px) {
      .main-content { margin-left: 0; }
      .sidebar { position: static; width: 100%; height: auto; }
      .toggle-btn { display: block; }
      .container { height: auto; }
    }
  </style>
</head>
<body>

<div class="sidebar" id="sidebar">
  <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-pic">
  <ul>
    <li><a href="adminDashboardPage.jsp">MANAGE ACTIVITIES</a></li>
    <li><a href="adminStudentList.jsp">STUDENT LIST</a></li>
    <li><a href="adminFeedback.jsp">FEEDBACK</a></li>
    <li><a href="addAdmin.jsp" class="active">ADD ADMIN</a></li>
    <li><a href="adminReport.jsp">REPORT</a></li>
  </ul>
  <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
    <form action="index.jsp">
        <button type="submit" class="activity-btn">Logout</button>
    </form>
  </div>
</div>

<div class="main-content" id="mainContent">
  <div class="header">
    <div class="header-title">ADD ADMIN</div>
    <div class="top-icons">
      <img src="image/umpsa.png" alt="UMPSA Logo">
      <img src="image/bell.png" alt="Notifications" id="notificationBtn" style="cursor:pointer;">
      <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-icon">
      <div class="notification-dropdown" id="notificationDropdown">
        <strong>Notifications</strong>
        <ul style="margin:10px 0 0 0; padding:0 0 0 18px;">
          <li>No new notifications</li>
        </ul>
      </div>
    </div>
  </div>
  <div class="container">
    <form class="form-section minimalist-form" action="AdminRegisterServlet" method="post">
      <% if (request.getParameter("status") != null) { %>
        <div class="message <%= "success".equals(request.getParameter("status")) ? "success" : "" %>">
          <%= "success".equals(request.getParameter("status")) ? "Admin added successfully!" : (request.getParameter("message") != null ? request.getParameter("message").replace("+", " ") : "Error occurred.") %>
        </div>
      <% } %>
      <div class="form-group">
        <label for="studID">Student ID <span style="color:#ff4444;">*</span></label>
        <input type="text" id="studID" name="studID" placeholder="Enter existing Student ID" required autocomplete="off">
      </div>
      <div class="form-group">
        <label for="adminEmail">Admin Email <span style="color:#ff4444;">*</span></label>
        <input type="email" id="adminEmail" name="adminEmail" placeholder="e.g. 2006@mpp.ump.my" required autocomplete="off">
      </div>
      <div class="submit-section">
        <button type="submit">Promote to Admin</button>
      </div>
    </form>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    var bell = document.getElementById('notificationBtn');
    var dropdown = document.getElementById('notificationDropdown');
    bell.addEventListener('click', function(e) {
      e.stopPropagation();
      dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
    });
    document.addEventListener('click', function(e) {
      if (dropdown.style.display === 'block') {
        dropdown.style.display = 'none';
      }
    });
  });
</script>

</body>
</html> 