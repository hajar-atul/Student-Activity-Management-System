<%-- 
    Document   : Activities
    Created on : Jun 6, 2025, 3:49:37 PM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Activities</title>
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
    .header-title {
      font-size: 28px;
      font-weight: bold;
      background-color: #0a8079;
      color: white;
      padding: 20px 40px;
      border-radius: 0;
      width: 100%;
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
    }
  </style>
</head>
<body>

  <!-- Toggle Sidebar Button -->
  <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <img src="profile.jpg" alt="Profile Picture" class="profile-pic">
    <h4>MUHAMMAD AMINUDDIN BIN HASNAN</h4>
    <p>2023217854</p>

    <ul>
      <li><a href="dashboard.jsp">Dashboard</a></li>
      <li><a href="activities.jsp" class="active">Activities</a></li>
      <li><a href="clubs.jsp">Clubs</a></li>
      <li><a href="achievements.jsp">Achievements</a></li>
      <li><a href="settings.jsp">Settings</a></li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">
    <!-- Full width header -->
    <div class="header-title">Activities</div>

    <!-- Activities Section -->
    <div class="activity-section">
      <!-- 3 top + 2 bottom = 5 images -->
      <div class="activity-images">
        <img src="palap1.jfif" alt="Activity 1">
        <img src="palap6.jfif" alt="Activity 2">
        <img src="palap5.jfif" alt="Activity 3">
        <img src="palap4.jfif" alt="Activity 4">
        <img src="hiking.jfif" alt="Activity 5">
      </div>

      <!-- Action Buttons beside bottom row -->
      <div class="action-buttons">
        <button onclick="location.href='CurrentActivities.jsp'">Current Activity List</button>
        <button onclick="location.href='JoinActivity.jsp'">Join Activity</button>
        <button onclick="location.href='PastActivities.jsp'">View Past Activities</button>
      </div>
    </div>
  </div>

  <script>
    function toggleSidebar() {
      const sidebar = document.getElementById('sidebar');
      const main = document.getElementById('mainContent');
      sidebar.classList.toggle('closed');
      main.classList.toggle('full-width');
    }
  </script>

</body>
</html>