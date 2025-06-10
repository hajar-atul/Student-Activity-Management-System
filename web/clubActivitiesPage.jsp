<%-- 
    Document   : ClubActivitiesPage
    Created on : Jun 9, 2025, 10:46:41 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Club Activities</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
    }

 /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #008b8b;
            color: white;
            padding: 20px;
            height: 100vh;
        }

        .sidebar img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            display: block;
            margin: 0 auto;
        }

        .sidebar h3 {
            text-align: center;
            font-size: 14px;
            margin: 10px 0 0;
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

    /* New Boxes Section */
    .box-section {
      height: calc(100vh - 100px);
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 40px;
      flex-wrap: wrap;
      padding: 20px;
    }


    .action-box {
      width: 250px;
      height: 250px;
      border: 3px solid #004d40;
      border-radius: 12px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.3s ease;
      text-align: center;
      background-color: white;
    }

    .action-box:hover {
      transform: scale(1.02);
    }

    .action-box.active {
      background-color: #004d40;
      color: white;
    }

    .action-box img {
      width: 90px;
      height: 90px;
      margin-bottom: 15px;
      transition: filter 0.3s ease;
    }

    .action-box.active img {
      filter: brightness(0) invert(1);
    }

    .action-title {
      font-size: 18px;
      font-weight: bold;
    }

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

      .box-section {
        flex-direction: column;
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
    <h3>Basketball Clubs</h3>
    <ul>
      <li><a href="clubDashboardPage.jsp">Dashboard</a></li>
      <li><a href="clubActivitiesPage.jsp" class="active">Activities</a></li>
      
      <li><a href="clubAchievements.jsp">Achievements</a></li>
      <li><a href="clubSettings.jsp">Settings</a></li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">
    <div class="header">
      <div class="header-title">ACTIVITIES</div>
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

    <!-- Action Boxes Section -->
    <div class="box-section">
      <div class="action-box" onclick="selectBox(this)">
        <img src="image/create_icon.png" alt="Create Icon">
        <div class="action-title">Create Activity</div>
      </div>

      <div class="action-box" onclick="selectBox(this)">
        <img src="image/track_icon.png" alt="Track Icon">
        <div class="action-title">Track Approval</div>
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

    function selectBox(box) {
      const boxes = document.querySelectorAll('.action-box');
      boxes.forEach(b => b.classList.remove('active'));
      box.classList.add('active');
    }
  </script>

</body>
</html>
