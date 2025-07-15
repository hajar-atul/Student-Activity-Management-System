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
      padding: 30px 20px 30px 20px;
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
      .sidebar { position: static; width: 100%; height: auto; }
      .toggle-btn { display: block; }
      .container { margin: 20px 5px; padding: 10px; }
      table { font-size: 15px; }
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
  <div style="width: 80%; margin: 0 auto; margin-top: auto; margin-bottom: 40px;">
    <form action="index.jsp">
        <button type="submit" class="activity-btn">Logout</button>
    </form>
</div>
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
