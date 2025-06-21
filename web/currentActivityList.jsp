<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Activity Page</title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet" />
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      overflow: hidden;
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
      display: block;
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

    .top-icons img.umpsa-icon {
      width: 40px;
      height: 40px;
    }

    .notification-btn img,
    .profile-icon {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      cursor: pointer;
    }

    .notification-dropdown,
    .profile-dropdown {
      display: none;
      position: absolute;
      top: 80px;
      right: 30px;
      background: white;
      color: black;
      min-width: 200px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      z-index: 999;
      border-radius: 8px;
      overflow: hidden;
    }

    .notification-dropdown.show,
    .profile-dropdown.show {
      display: block;
    }

    .notification-dropdown p,
    .profile-dropdown a {
      margin: 0;
      padding: 10px 20px;
      border-bottom: 1px solid #eee;
      text-decoration: none;
      color: black;
      display: block;
    }

    .profile-dropdown a:hover {
      background-color: #f0f0f0;
    }

    .content {
      padding: 100px 30px 20px 30px;
      margin-left: 250px;
      height: calc(100vh - 100px);
      overflow-y: auto;
      transition: margin-left 0.3s ease;
    }

    .sidebar.closed ~ .content {
      margin-left: 0;
    }

    .activity-container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .activity-section {
      max-width: 1000px;
      margin: 0 auto;
    }

    .table-wrapper {
      border: 1px solid #ccc;
      border-radius: 10px;
      overflow: hidden;
      background: white;
    }

    .table-wrapper .title-bar {
      padding: 15px 20px;
      font-weight: bold;
      border-bottom: 3px solid #008b8b;
      background-color: #f5f5f5;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      text-align: left;
    }

    th, td {
      padding: 12px 20px;
      border-bottom: 1px solid #ccc;
    }

    thead tr {
      background-color: #f0f0f0;
    }

    tbody tr:hover {
      background-color: #f9f9f9;
    }

    .back-btn {
      display: inline-block;
      margin: 30px auto 0;
      padding: 12px 24px;
      background-color: #008b8b;
      color: white;
      text-decoration: none;
      border-radius: 8px;
      font-weight: bold;
      text-align: center;
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
    <img src="image/umpsa.png" class="umpsa-icon" alt="UMPSA">
    <button class="notification-btn" id="notificationBtn">
      <img src="image/bell.png" alt="Notification">
    </button>
    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>
    <img src="image/amin.jpg" alt="Profile" class="profile-icon" id="profileBtn">
    <div class="profile-dropdown" id="profileDropdown">
      <a href="profile.jsp">My Profile</a>
      <a href="logout.jsp">Logout</a>
    </div>
  </div>
</div>

<!-- Content -->
<div class="content">
  <div class="activity-section">
    <h2 style="text-align:center; font-size: 28px; margin-bottom: 20px;">ACTIVITY LIST</h2>
    <div class="table-wrapper">
      <div class="title-bar">My Activities</div>
      <table>
        <thead>
          <tr>
            <th>ACTIVITY</th>
            <th>DATE</th>
            <th>STATUS</th>
            <th>ROLE</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Flood Rescue Volunteer</td>
            <td>12 Jan 2026</td>
            <td>Upcoming</td>
            <td>Participant</td>
          </tr>
          <tr>
            <td>Basketball Clinic</td>
            <td>8 Sep 2025</td>
            <td>Upcoming</td>
            <td>Participant</td>
          </tr>
          <tr>
            <td>Elder Care Visit</td>
            <td>23 March 2025</td>
            <td>Upcoming</td>
            <td>Participant</td>
          </tr>
          <tr>
            <td>Biodiversity Seminar</td>
            <td>22 May 2026</td>
            <td>Upcoming</td>
            <td>Participant</td>
          </tr>
        </tbody>
      </table>
    </div>
    <a href="activities.jsp" class="back-btn">← Back</a>
  </div>
</div>

<!-- Script -->
<script>
  const sidebar = document.getElementById('sidebar');
  const toggleBtn = document.getElementById('toggleBtn');
  const notificationBtn = document.getElementById('notificationBtn');
  const notificationDropdown = document.getElementById('notificationDropdown');
  const profileBtn = document.getElementById('profileBtn');
  const profileDropdown = document.getElementById('profileDropdown');

  toggleBtn.addEventListener('click', () => {
    sidebar.classList.toggle('closed');
  });

  notificationBtn.addEventListener('click', function (e) {
    e.stopPropagation();
    notificationDropdown.classList.toggle('show');
    profileDropdown.classList.remove('show');
  });

  profileBtn.addEventListener('click', function (e) {
    e.stopPropagation();
    profileDropdown.classList.toggle('show');
    notificationDropdown.classList.remove('show');
  });

  window.addEventListener('click', function () {
    notificationDropdown.classList.remove('show');
    profileDropdown.classList.remove('show');
  });
</script>

</body>
</html>
