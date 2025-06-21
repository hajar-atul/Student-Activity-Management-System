<%-- 
    Document   : pastActivitiesList
    Created on : Jun 9, 2025, 1:46:36 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Past Activities</title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet" />
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
    }

    .sidebar {
      width: 250px;
      background-color: #008b8b;
      color: white;
      padding: 20px;
      height: 100vh;
      position: fixed;
      left: 0;
      top: 0;
      z-index: 1001;
      display: flex;
      flex-direction: column;
      transition: transform 0.3s ease;
    }

    .sidebar.closed {
      transform: translateX(-100%);
    }

    .toggle-btn {
      position: fixed;
      top: 20px;
      left: 20px;
      background-color: #008b8b;
      color: white;
      border: none;
      padding: 8px 12px;
      border-radius: 4px;
      cursor: pointer;
      z-index: 1002;
    }

      .sidebar img.profile-pic {
       width: 100px;
       aspect-ratio: 1 / 1;
       border-radius: 50%;
       object-fit: cover;
       margin: 0 auto 15px;
       border: 3px solid white;
       box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
}


    .sidebar h2 {
      text-align: center;
      font-size: 14px;
      margin-top: 10px;
    }

    .menu {
      margin-top: 30px;
    }

    .menu a {
      display: block;
      padding: 10px;
      background-color: #0a6d6d;
      margin-top: 10px;
      text-decoration: none;
      color: white;
      border-radius: 5px;
      text-align: center;
    }

    .topbar {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      height: 80px;
      background-color: #008b8b;
      color: white;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 30px;
      z-index: 1000;
    }

    .search-container {
      display: flex;
      align-items: center;
      margin-left: 250px;
      transition: margin-left 0.3s ease;
    }

    .sidebar.closed ~ .topbar .search-container {
      margin-left: 70px;
    }

    .search-container input {
      padding: 8px 12px;
      border-radius: 20px;
      border: none;
      outline: none;
      width: 200px;
    }

    .search-btn {
      background: white;
      border: none;
      margin-left: -30px;
      cursor: pointer;
      font-weight: bold;
      border-radius: 50%;
      padding: 4px 8px;
      color: #009B9D;
    }

    .dashboard-title {
      font-size: 26px;
      font-weight: bold;
      text-align: center;
      flex-grow: 1;
      margin-left: 60px;
    }

    .top-icons {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .top-icons img {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      cursor: pointer;
    }

    .content {
      margin-left: 250px;
      padding: 100px 30px 50px;
      transition: margin-left 0.3s ease;
    }

    .sidebar.closed ~ .content {
      margin-left: 0;
    }

    .stats {
      display: flex;
      gap: 20px;
      margin-bottom: 40px;
    }

    .stat-box {
      background-color: #d8f6f5;
      padding: 20px;
      border-radius: 10px;
      flex: 1;
      display: flex;
      align-items: center;
      font-size: 14px;
      font-weight: bold;
    }

    .stat-box:nth-child(3) {
      background-color: #ece8f9;
    }

    .stat-box img {
      height: 32px;
      margin-right: 10px;
    }

    .stat-text {
      display: flex;
      flex-direction: column;
      line-height: 1.4;
    }

    .stat-text span {
      font-size: 24px;
      font-weight: bold;
    }

    .activity-table {
      width: 100%;
      background-color: white;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .activity-table table {
      width: 100%;
      border-collapse: collapse;
    }

    .activity-table th,
    .activity-table td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
      font-size: 14px;
    }

    .activity-table th {
      background-color: #f9f9f9;
      font-weight: bold;
    }

    .activity-table tr:last-child td {
      border-bottom: none;
    }

    .activity-table button {
      background-color: #008b8b;
      color: white;
      padding: 8px 16px;
      border: none;
      border-radius: 20px;
      font-size: 14px;
      cursor: pointer;
    }

    .back-btn {
      display: inline-block;
      margin-top: 40px;
      padding: 12px 24px;
      background-color: #008b8b;
      color: white;
      text-decoration: none;
      border-radius: 8px;
      font-weight: bold;
    }
  </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
  <img src="image/amin.jpg" alt="Profile" class="profile-pic" />
  <h2>
    <%= session.getAttribute("studName") %><br>
    <%= session.getAttribute("studID") %>
  </h2>
  <div class="menu">
    <a href="studentDashboardPage.jsp">DASHBOARD</a>
    <a href="activities.jsp">ACTIVITIES</a>
    <a href="studentClub.jsp">CLUBS</a>
    <a href="achievements.jsp">ACHIEVEMENTS</a>
    <a href="settings.jsp">SETTINGS</a>
  </div>
</div>

<!-- Toggle Button -->
<button class="toggle-btn" id="toggleBtn">☰</button>

<!-- Topbar -->
<div class="topbar">
  <div class="search-container">
    <input type="text" placeholder="Search..." />
    <button class="search-btn">X</button>
  </div>
  <div class="dashboard-title">ACTIVITIES</div>
  <div class="top-icons">
    <img src="image/umpsa.png" alt="UMPSA">
    <img src="image/bell.png" alt="Notification">
    <img src="image/amin.jpg" alt="Profile">
  </div>
</div>

<!-- Content -->
<div class="content">
  <div class="stats">
    <div class="stat-box">
      <img src="image/activity_icon.png" alt="Activities">
      <div class="stat-text">
        TOTAL ACTIVITIES JOINED
        <span>8</span>
      </div>
    </div>
    <div class="stat-box">
      <img src="image/club_icon.png" alt="Clubs">
      <div class="stat-text">
        CLUBS PARTICIPATED
        <span>3</span>
      </div>
    </div>
    <div class="stat-box">
      <img src="image/trophy.jpg" alt="Achievements">
      <div class="stat-text">
        ACHIEVEMENTS
        <span>0</span>
      </div>
    </div>
  </div>

  <div class="activity-table">
    <table>
      <thead>
        <tr>
          <th>ACTIVITY</th>
          <th>DATE</th>
          <th>STATUS</th>
          <th>ROLE</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>HACKATHON FACULTY</td>
          <td>12 Apr 2025</td>
          <td>Attended</td>
          <td>Participant</td>
          <td><button onclick="location.href='feedback.jsp'">Feedback →</button></td>
        </tr>
        <tr>
          <td>BADMINTON LEAGUE</td>
          <td>8 Apr 2025</td>
          <td>Attended</td>
          <td>Participant</td>
          <td><button onclick="location.href='feedback.jsp'">Feedback →</button></td>
        </tr>
        <tr>
          <td>ACADEMIC CONFERENCE</td>
          <td>23 March 2025</td>
          <td>Attended</td>
          <td>Participant</td>
          <td><button onclick="location.href='feedback.jsp'">Feedback →</button></td>
        </tr>
        <tr>
          <td>VISIT TO ORPHANAGE</td>
          <td>22 Feb 2025</td>
          <td>Attended</td>
          <td>Participant</td>
          <td><button onclick="location.href='feedback.jsp'">Feedback →</button></td>
        </tr>
      </tbody>
    </table>
  </div>

  <a href="activities.jsp" class="back-btn">← Back</a>
</div>

<!-- Script -->
<script>
  const sidebar = document.getElementById('sidebar');
  const toggleBtn = document.getElementById('toggleBtn');
  const content = document.querySelector('.content');
  const searchContainer = document.querySelector('.search-container');

  toggleBtn.addEventListener('click', () => {
    sidebar.classList.toggle('closed');
    content.classList.toggle('sidebar-closed');
    searchContainer.classList.toggle('sidebar-closed');
  });
</script>

</body>
</html>
