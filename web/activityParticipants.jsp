<%@ page import="java.util.List" %>
<%@ page import="model.STUDENT" %>
<!DOCTYPE html>
<html>
<head>
  <title>Activity Participants</title>
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
      overflow: hidden;
      height: 100vh;
      display: flex;
      flex-direction: column;
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
    .container {
      max-width: 1400px;
      margin: 40px auto;
      background: #fff;
      border-radius: 10px;
      padding: 30px 40px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      flex: 1 1 auto;
      overflow: auto;
    }
    h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 26px;
      font-weight: bold;
      color: #238B87;
    }
    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      margin-top: 20px;
      background: #fff;
      border-radius: 14px;
      overflow: hidden;
      box-shadow: 0 2px 12px rgba(34,139,135,0.07);
    }
    th, td {
      padding: 15px 18px;
      text-align: left;
      font-size: 16px;
      border: none;
    }
    th {
      background: #e0f7fa;
      font-size: 17px;
      font-weight: 600;
      color: #00796B;
      border-bottom: 2px solid #b2dfdb;
    }
    tr {
      transition: background 0.18s;
    }
    tr:nth-child(even) { background: #f7fafc; }
    tr:nth-child(odd) { background: #fff; }
    tr:hover { background: #e0f7fa; }
    td {
      color: #222;
      font-weight: 400;
      border-bottom: 1px solid #f0f0f0;
    }
    .back-link {
      display: inline-block;
      margin-bottom: 24px;
      background: #00796B;
      color: #fff;
      text-decoration: none;
      font-weight: 500;
      font-size: 16px;
      padding: 10px 26px;
      border-radius: 7px;
      border: none;
      transition: background 0.18s, box-shadow 0.18s;
      box-shadow: 0 2px 8px rgba(10,128,121,0.07);
      letter-spacing: 0.2px;
      cursor: pointer;
    }
    .back-link:hover {
      background: #005f56;
      color: #fff;
      text-decoration: none;
      box-shadow: 0 4px 16px rgba(10,128,121,0.13);
    }
    @media (max-width: 900px) {
      .main-content { margin-left: 0; }
      .container { margin: 20px 5px; padding: 10px; }
      table { font-size: 15px; }
    }
  </style>
</head>
<body>

<div class="sidebar" id="sidebar">
  <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-pic">
  <ul>
    <li><a href="adminDashboardPage.jsp">MANAGE ACTIVITIES</a></li>
    <li><a href="adminStudentList.jsp" class="active">STUDENT LIST</a></li>
    <li><a href="adminFeedback.jsp">FEEDBACK</a></li>
    <li><a href="addAdmin.jsp">ADD ADMIN</a></li>
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
    <div class="header-title">ACTIVITY PARTICIPANTS</div>
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
    <a href="adminStudentList.jsp" class="back-link">&larr; Back to Student List</a>
    <h2>Participants for Activity ID: <%= request.getAttribute("activityId") %></h2>
    <table>
      <tr>
        <th>Student ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Course</th>
        <th>Semester</th>
      </tr>
      <%
          List<STUDENT> students = (List<STUDENT>)request.getAttribute("students");
          if (students == null || students.isEmpty()) {
      %>
      <tr><td colspan="5">No students registered for this activity.</td></tr>
      <% } else {
          for (STUDENT s : students) { %>
        <tr>
          <td><%= s.getStudID() %></td>
          <td><%= s.getStudName() %></td>
          <td><%= s.getStudEmail() %></td>
          <td><%= s.getStudCourse() %></td>
          <td><%= s.getStudSemester() %></td>
        </tr>
      <% } } %>
    </table>
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
