<%-- 
    Document   : Clubs
    Created on : Jun 6, 2025, 3:51:43 PM
    Author     : wafa
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Club Dashboard</title>
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

    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #00796B;
      color: white;
      position: fixed;
      padding: 70px 20px 20px 20px;
      overflow-y: auto;
      z-index: 10;
      text-align: center;
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
    }

    .sidebar h3 {
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

    .main-content {
      margin-left: 270px;
      transition: margin-left 0.3s ease;
    }

    .main-content.full-width {
      margin-left: 20px;
    }

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

    .activity-section {
      padding: 40px;
    }
    
    .activity-section:hover {
      padding: none;
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
      width: 30%;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .summary-card:nth-child(2) {
      background: #E8E6F1;
    }

    .summary-icon img {
      height: 60px;
      width: 60px;
    }

    .summary-text h3 {
      margin: 0;
      font-size: 20px;
    }

    .summary-text p {
      font-size: 26px;
      font-weight: bold;
      margin: 5px 0 0;
    }

    .rejected-activities-box {
      background-color: #f9f9f9;
      border-radius: 12px;
      padding: 30px;
      margin: 60px 40px 40px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .rejected-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .rejected-header h2 {
      font-size: 24px;
      font-weight: bold;
      margin: 0;
    }

    .view-all-btn {
      background-color: #00796B;
      color: white;
      padding: 8px 14px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
    }

    .view-all-btn:hover {
      background-color: #005f56;
    }

    .rejected-cards-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    .activity-card {
      width: 220px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }

    .activity-card img {
      width: 100%;
      height: 120px;
      object-fit: cover;
    }

    .activity-info {
      padding: 15px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: 130px;
    }

    .activity-info h4 {
      font-size: 16px;
      margin-bottom: 5px;
    }

    .activity-info p {
      font-size: 12px;
      margin: 2px 0;
    }

    .card-actions {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 8px;
    }

    .rejected-label {
      background-color: #ff9295;
      color: red;
      font-weight: bold;
      font-size: 11px;
      padding: 4px 7px;
      border-radius: 4px;
    }

    .appeal-btn {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 5px 10px;
      font-size: 12px;
      border-radius: 4px;
      cursor: pointer;
    }

    .appeal-btn:hover {
      background-color: #0056b3;
    }

    /* Modal */
    .modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.4);
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }

    .modal-content {
      background: white;
      padding: 30px;
      border-radius: 10px;
      width: 90%;
      max-width: 400px;
    }

    .modal-content h3 {
      margin-bottom: 20px;
    }

    .modal-content textarea {
      width: 100%;
      height: 100px;
      margin-bottom: 15px;
      padding: 10px;
      resize: none;
    }

    .modal-buttons {
      text-align: right;
    }

    .modal-buttons button {
      padding: 8px 14px;
      margin-left: 10px;
      border-radius: 6px;
      border: none;
      cursor: pointer;
    }

    .btn-cancel {
      background-color: #ccc;
    }

    .btn-submit {
      background-color: #00796B;
      color: white;
    }

    @media (max-width: 768px) {
      .main-content {
        margin-left: 0 !important;
      }

      .sidebar {
        width: 100%;
        height: auto;
        position: static;
      }

      .toggle-btn {
        position: absolute;
        left: 10px;
        top: 10px;
      }

      .summary-card {
        width: 100%;
      }

      .rejected-cards-container {
        justify-content: center;
      }
    }
  </style>
</head>
<body>

<button class="toggle-btn" onclick="toggleSidebar()">☰</button>

<div class="sidebar" id="sidebar">
  <img src="image/Raccoon.gif" alt="User Profile Picture" class="profile-pic">
  <h3>Basketball Club</h3>
  <ul>
    <li><a href="clubDashboardPage.jsp" class="active">Dashboard</a></li>
    <li><a href="clubActivitiesPage.jsp">Activities</a></li>
    
    <li><a href="clubAchievements.jsp">Achievements</a></li>
    <li><a href="clubSettings.jsp">Settings</a></li>
  </ul>
</div>

<div class="main-content" id="mainContent">
  <div class="header">
    <div class="header-title">DASHBOARD</div>
    <div class="top-icons">
      <img src="image/umpsa.png" alt="UMPSA Logo" class="umpsa-icon" />
      <button class="notification-btn" id="notificationBtn">
        <img src="image/bell.png" alt="Notifications" />
      </button>
      <img src="image/Raccoon.gif" alt="User Avatar" class="profile-icon" />
    </div>
  </div>

  <div class="notification-dropdown" id="notificationDropdown">
    <p>No new notifications</p>
  </div>

  <div class="activity-section">
    <div class="summary-container">
      <div class="summary-card">
        <div class="summary-icon"><img src="image/venue_icon.png" alt="Venue"></div>
        <div class="summary-text"><h3>Venue Booking</h3><p>2</p></div>
      </div>
      <div class="summary-card">
        <div class="summary-icon"><img src="image/resource_icon.png" alt="Resource"></div>
        <div class="summary-text"><h3>Resource Request</h3><p>5</p></div>
      </div>
    </div>

    <!-- Rejected Activities -->
    <div class="rejected-activities-box">
      <div class="rejected-header">
        <h2>Rejected Activities</h2>
        <button class="view-all-btn">View All</button>
      </div>
      <div class="rejected-cards-container">
        <div class="activity-card">
          <img src="image/basketballPlayer_icon.png" alt="Activity Image">
          <div class="activity-info">
            <h4>3v3 Basketball Match</h4>
            <p>Date: June 5, 2025</p>
            <p>Venue: UMPSA Indoor Court</p>
            <div class="card-actions">
              <span class="rejected-label">Rejected</span>
              <button class="appeal-btn" onclick="openModal()">Appeal</button>
            </div>
          </div>
        </div>

        <div class="activity-card">
          <img src="image/streetballPlayer_icon.png" alt="Activity Image">
          <div class="activity-info">
            <h4>Streetball Tournament</h4>
            <p>Date: May 30, 2025</p>
            <p>Venue: Main Hall</p>
            <div class="card-actions">
              <span class="rejected-label">Rejected</span>
              <button class="appeal-btn" onclick="openModal()">Appeal</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Appeal Modal -->
<div class="modal" id="appealModal">
  <div class="modal-content">
    <h3>Submit Appeal</h3>
    <textarea placeholder="Write your appeal reason here..."></textarea>
    <div class="modal-buttons">
      <button class="btn-cancel" onclick="closeModal()">Cancel</button>
      <button class="btn-submit" onclick="submitAppeal()">Submit</button>
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

  document.getElementById("notificationBtn").addEventListener("click", function () {
    const dropdown = document.getElementById("notificationDropdown");
    dropdown.style.display = dropdown.style.display === "none" ? "block" : "none";
  });

  function openModal() {
    document.getElementById("appealModal").style.display = "flex";
  }

  function closeModal() {
    document.getElementById("appealModal").style.display = "none";
  }

  function submitAppeal() {
    alert("Appeal submitted successfully!");
    closeModal();
  }
</script>

</body>
</html>