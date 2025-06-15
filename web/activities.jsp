<%-- 
    Document   : Activities
    Created on : Jun 6, 2025, 3:49:37 PM
    Author     : wafa
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Student Activities</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

          body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            background-color: #f0f0f0;
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

        .sidebar h2 {
            text-align: center;
            font-size: 14px;
            margin: 10px 0 0;
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

    /* Content Layout */
    .activity-section {
      display: flex;
      flex-wrap: wrap;
      padding: 20px;
      gap: 20px;
    }

    .activity-images {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-auto-rows: 180px;
      gap: 20px;
      flex: 1;
      min-width: 500px;
    }

    .activity-images img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.2);
      transition: transform 0.3s ease;
    }

    .activity-images img:hover {
      transform: scale(1.05);
    }

    /* Action Buttons */
    .action-buttons {
      position: fixed;
      right: 30px;
      bottom: 30px;
      display: flex;
      flex-direction: column;
      gap: 15px;
      max-width: 250px;
      z-index: 5;
    }

    .action-buttons button {
      padding: 12px;
      background-color: #004D40;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .action-buttons button:hover {
      background-color: #00332c;
    }

    @media (max-width: 768px) {
      .main-content {
        margin-left: 0;
      }

      .activity-section {
        flex-direction: column;
        align-items: center;
      }

      .activity-images {
        grid-template-columns: 1fr;
      }

      .action-buttons {
        margin-left: 0;
        margin-top: 20px;
      }

      .header {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
      }

      .top-icons {
        align-self: flex-end;
      }
    }
  </style>
</head>
<body>

  <!-- Toggle Sidebar Button -->
  <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

  <!-- Sidebar -->
    <div class="sidebar">
        <img src="image/amin.jpg" alt="Profile Picture">
        <h2><%= session.getAttribute("studName") %><br><%= session.getAttribute("studID") %></h2>
        <div class="menu">
            <a href="studentDashboardPage.jsp">DASHBOARD</a>
            <a href="ActivitiesServlet">ACTIVITIES</a>
            <a href="studentClub.jsp">CLUBS</a>
            <a href="achievements.jsp">ACHIEVEMENTS</a>
            <a href="settings.jsp">SETTINGS</a>
        </div>
    </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">

    <!-- Header with icons on the right -->
    <div class="header">
      <div class="header-title">ACTIVITIES</div>
      <div class="top-icons">
        <img src="image/umpsa.png" alt="UMPSA" class="umpsa-icon">
        <button class="notification-btn" id="notificationBtn">
          <img src="image/bell.png" alt="Notification">
        </button>
        <img src="image/amin.jpg" alt="Profile" class="profile-icon">
      </div>
    </div>

    <!-- Dropdown for notifications -->
    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>

    <!-- Activities Section -->
    <div class="activity-section">
      <div class="activity-images">
        <img src="image/palap1.jfif" alt="Activity 1">
        <img src="image/palap6.jfif" alt="Activity 2">
        <img src="image/palap5.jfif" alt="Activity 3">
        <img src="image/palap4.jfif" alt="Activity 4">
        <img src="image/hiking.jfif" alt="Activity 5">
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons">
        <button onclick="location.href='currentActivityList.jsp'">Current Activity List</button>
        <button onclick="location.href='availableActivityList.jsp'">Join Activity</button>
        <button onclick="location.href='pastActivityList.jsp'">View Past Activities</button>
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