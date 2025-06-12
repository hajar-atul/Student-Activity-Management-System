<%-- 
    Document   : pastActivitiesList
    Created on : Jun 9, 2025, 1:46:36 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Activity List</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', Arial, sans-serif;
    }

    /* Sidebar */
    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #00796B;
      color: white;
      position: fixed;
      padding: 70px 20px 20px 20px;
      transition: transform 0.3s ease;
      overflow-y: auto;
      text-align: center;
      z-index: 10;
    }

    .sidebar.closed {
      transform: translateX(-100%);
    }

    .sidebar img.profile-pic {
      width: 100px;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 15px;
      border: 3px solid white;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
    }

    .sidebar h4,
    .sidebar p {
      margin-bottom: 10px;
    }

    .sidebar ul {
      list-style: none;
      padding-left: 0;
      margin-top: 20px;
    }

    .sidebar ul li {
      margin-bottom: 15px;
    }

    .sidebar ul li a {
      color: white;
      text-decoration: none;
      padding: 10px;
      display: block;
      border-radius: 5px;
      transition: background-color 0.2s ease;
    }

    .sidebar ul li a:hover,
    .sidebar ul li a.active {
      background-color: rgba(0, 0, 0, 0.2);
    }

    /* Toggle Button */
    .toggle-btn {
      position: fixed;
      left: 10px;
      top: 10px;
      z-index: 1000;
      background-color: #00796B;
      color: white;
      border: none;
      padding: 10px 15px;
      cursor: pointer;
      border-radius: 5px;
    }

    /* Main Content */
    .main-content {
      margin-left: 270px;
      transition: margin-left 0.3s ease;
    }

    .main-content.full-width {
      margin-left: 20px;
    }

    /* Header */
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #0a8079;
      color: white;
      padding: 20px 40px;
      width: 100%;
    }

    .header-title {
      font-size: 28px;
      font-weight: bold;
    }

    .top-icons {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .top-icons img.umpsa-icon {
      width: 36px;
      height: 36px;
    }

    .notification-btn {
      background: none;
      border: none;
      cursor: pointer;
      padding: 0;
    }

    .notification-btn img {
      width: 30px;
      height: 30px;
    }

    .profile-icon {
      width: 40px;
      height: 40px;
      border-radius: 50%;
    }

    .notification-dropdown {
      position: absolute;
      top: 80px;
      right: 40px;
      background-color: white;
      color: black;
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 10px;
      width: 200px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      display: none;
      z-index: 100;
    }

    /* Activity Section */
    .activity-section {
      padding: 40px;
    }

    .activity-section h2 {
      text-align: center;
      font-size: 32px;
      font-weight: bold;
    }

    .summary-container {
      display: flex;
      justify-content: space-around;
      margin-bottom: 30px;
      flex-wrap: wrap;
      gap: 20px;
    }

    .summary-card {
      background: #D0F0EF;
      padding: 20px;
      border-radius: 12px;
      width: 25%;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .summary-card:nth-child(3) {
      background: #E8E6F1;
    }

    .summary-icon img {
      height: 60px;
      width: 60px;
      object-fit: contain;
    }

    .summary-text h3 {
      margin: 0;
      font-size: 16px;
    }

    .summary-text p {
      font-size: 24px;
      font-weight: bold;
      margin: 5px 0 0;
    }

    /* Table Section */
    .table-wrapper {
      border: 1px solid #ccc;
      border-radius: 8px;
      overflow-x: auto;
    }

    .table-wrapper .title-bar {
      padding: 12px 20px;
      font-weight: bold;
      border-bottom: 3px solid #009688;
      background-color: #f5f5f5;
      text-align: left;
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

    tbody tr:hover {
      background-color: #f9f9f9;
    }

    button {
      background: #00796B;
      color: white;
      border: none;
      border-radius: 20px;
      padding: 5px 15px;
      cursor: pointer;
      transition: 0.2s ease;
    }

    button:hover {
      opacity: 0.9;
      transform: scale(1.02);
    }

    /* Responsive */
    @media (max-width: 768px) {
      .main-content {
        margin-left: 0 !important;
      }

      .sidebar {
        width: 100%;
        height: auto;
        position: static;
        transform: none !important;
      }

      .toggle-btn {
        position: absolute;
        left: 10px;
        top: 10px;
      }

      .activity-section {
        padding: 20px;
      }

      .summary-card {
        width: 100%;
        flex-direction: column;
        align-items: center;
        text-align: center;
      }
    }
  </style>
</head>
<body>

  <!-- Toggle Sidebar Button -->
  <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <img src="image/Raccoon.gif" alt="User Profile Picture" class="profile-pic">
    <h4>MUHAMMAD AMINUDDIN BIN HASNAN</h4>
    <p>2023217854</p>

    <ul>
      <li><a href="studentDashboardPage.jsp">Dashboard</a></li>
      <li><a href="activities.jsp" class="active">Activities</a></li>
      <li><a href="studentClub.jsp">Clubs</a></li>
      <li><a href="achievements.jsp">Achievements</a></li>
      <li><a href="settings.jsp">Settings</a></li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">
    <div class="header">
      <div class="header-title">Activities</div>
      <div class="top-icons">
        <img src="image/umpsa.png" alt="Universiti Malaysia Pahang Logo" class="umpsa-icon" />
        <button class="notification-btn" id="notificationBtn">
          <img src="image/bell.png" alt="Notifications" />
        </button>
        <img src="image/Raccoon.gif" alt="User Avatar" class="profile-icon" />
      </div>
    </div>

    <!-- Notification Dropdown -->
    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>

    <div class="activity-section">
      <!-- Summary Cards -->
      <div class="summary-container">
        <div class="summary-card">
          <div class="summary-icon">
            <img src="image/activity_icon.png" alt="Activities Icon">
          </div>
          <div class="summary-text">
            <h3>TOTAL ACTIVITIES JOINED</h3>
            <p>8</p>
          </div>
        </div>
        <div class="summary-card">
          <div class="summary-icon">
            <img src="image/club_icon.png" alt="Clubs Icon">
          </div>
          <div class="summary-text">
            <h3>CLUBS PARTICIPATED</h3>
            <p>3</p>
          </div>
        </div>
        <div class="summary-card">
          <div class="summary-icon">
            <img src="image/trophy.jpg" alt="Achievements Icon">
          </div>
          <div class="summary-text">
            <h3>ACHIEVEMENTS</h3>
            <p>0</p>
          </div>
        </div>
      </div>

      <!-- Table -->
      <div class="table-wrapper">
        <div class="title-bar">My Activities</div>
        <table>
          <thead>
            <tr style="background-color: #f0f0f0;">
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
    </div>
  </div>

  <!-- Script -->
  <script>
    function toggleSidebar() {
      const sidebar = document.getElementById('sidebar');
      const main = document.getElementById('mainContent');
      sidebar.classList.toggle('closed');
      main.classList.toggle('full-width');
    }

    document.getElementById("notificationBtn").addEventListener("click", function () {
      const dropdown = document.getElementById("notificationDropdown");
      dropdown.style.display = dropdown.style.display === "none" ? "block" : "none";
    });
  </script>

</body>
</html>