<%@ page import="java.util.List" %>
<%@ page import="model.STUDENT" %>
<!DOCTYPE html>
<html>
<head>
  <title>Activity Participants</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    html, body { height: 100vh; overflow: hidden; }
    body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; margin: 0; }
    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #238B87;
      color: white;
      position: fixed;
      top: 0;
      left: 0;
      padding: 30px 20px 20px 20px;
      overflow-y: auto;
      z-index: 10;
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
      border-radius: 0;
    }
    .sidebar img.profile-pic {
      width: 170px;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 10px;
      border: 3px solid white;
      background: #fff;
    }
    .sidebar .mpp-title {
      font-weight: bold;
      font-size: 18px;
      margin-bottom: 30px;
      line-height: 1.2;
      letter-spacing: 1px;
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
    }
    .sidebar ul li a.active, .sidebar ul li a:hover {
      background-color: #1a7e7c;
      font-weight: bold;
    }
    .toggle-btn {
      position: fixed;
      left: 20px;
      top: 20px;
      z-index: 1000;
      background-color: #219a98;
      color: white;
      border: none;
      padding: 10px 15px;
      cursor: pointer;
      border-radius: 5px;
      font-size: 22px;
      display: none;
    }
    .main-content {
      margin-left: 270px;
      transition: margin-left 0.3s ease;
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
      color: #333;
      padding: 0 10px 0 40px;
      height: 70px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
      position: sticky;
      top: 0;
      left: 0;
      width: 100%;
      z-index: 5;
      gap: 20px;
      border-radius: 0;
    }
    .header .search-container {
      flex: 1;
      display: flex;
      justify-content: center;
    }
    .header .search-container input {
      width: 350px;
      padding: 8px 16px;
      border-radius: 20px;
      border: 1px solid #ccc;
      font-size: 16px;
      outline: none;
    }
    .header .top-icons {
      display: flex;
      align-items: center;
      gap: 18px;
      margin-left: auto;
      height: 100%;
      margin-right: 70px;
    }
    .header .top-icons img, .header .top-icons .profile-icon {
      width: 45px;
      height: 45px;
      object-fit: contain;
      background: transparent;
      display: block;
    }
    .header .top-icons .profile-icon {
      width: 45px;
      height: 45px;
      border-radius: 50%;
      border: none;
      background: transparent;
    }
    .container {
      max-width: 900px;
      margin: 40px auto;
      background: #fff;
      border-radius: 10px;
      padding: 30px;
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
      border-collapse: collapse;
      margin-top: 20px;
      background: #fff;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }
    th, td {
      padding: 16px 18px;
      border: 1px solid #e0e0e0;
      text-align: center;
      font-size: 17px;
    }
    th {
      background: #eaf6f6;
      font-size: 18px;
      font-weight: bold;
      color: #219a98;
    }
    tr:nth-child(even) { background: #f9f9f9; }
    a.back-link {
      display: inline-block;
      margin-bottom: 20px;
      color: #218c8d;
      text-decoration: none;
      font-weight: bold;
      font-size: 16px;
      transition: color 0.2s;
    }
    a.back-link:hover { text-decoration: underline; color: #1a7e7c; }
    @media (max-width: 900px) {
      .main-content { margin-left: 0; }
      .sidebar { position: static; width: 100%; height: auto; }
      .toggle-btn { display: block; }
      .container { margin: 20px 5px; padding: 10px; }
      table { font-size: 15px; }
    }
  </style>
</head>
<body>

<button class="toggle-btn" onclick="toggleSidebar()">☰</button>

<div class="sidebar" id="sidebar">
  <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-pic">
  <ul>
    <li><a href="adminDashboardPage.jsp">MANAGE ACTIVITIES</a></li>
    <li><a href="adminStudentList.jsp" class="active">STUDENT LIST</a></li>
    <li><a href="adminFeedback.jsp">FEEDBACK</a></li>
    <li><a href="addAdmin.jsp">ADD ADMIN</a></li>
    <li><a href="adminReport.jsp">REPORT</a></li>
  </ul>
</div>

<div class="main-content" id="mainContent">
  <div class="header">
    <button class="toggle-btn" onclick="toggleSidebar()" style="display:block;">☰</button>
    <div class="top-icons" style="margin-left:auto;">
      <img src="image/umpsa.png" alt="Logo UMP" style="width:45px;height:45px;">
      <button class="notification-btn" id="notificationBtn" style="background:none; border:none; cursor:pointer; padding:0;">
        <img src="image/bell.png" alt="Notifications">
      </button>
      <img src="image/mppUMPSA.jpg" alt="Profile" class="profile-icon">
    </div>
  </div>
  <div class="notification-dropdown" id="notificationDropdown" style="display:none; position:absolute; top:80px; right:60px; background-color:white; color:black; border:1px solid #ccc; border-radius:8px; padding:10px; width:200px; box-shadow:0 2px 8px rgba(0,0,0,0.15); z-index:100;">
    <p>No new notifications</p>
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
  function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('mainContent');
    sidebar.classList.toggle('closed');
    mainContent.classList.toggle('full-width');
  }
  document.getElementById("notificationBtn").addEventListener("click", function () {
    const dropdown = document.getElementById("notificationDropdown");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
  });
</script>

</body>
</html> 
