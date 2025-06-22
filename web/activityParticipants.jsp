<%-- 
    Document   : ActivityParticipants
    Created on : Jun 9, 2025, 10:46:41 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CLUB"%>
<%@page import="model.ACTIVITY"%>
<%@page import="model.STUDENT"%>
<%@page import="java.util.List"%>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    if (club == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    ACTIVITY activity = (ACTIVITY) request.getAttribute("activity");
    List<STUDENT> participants = (List<STUDENT>) request.getAttribute("participants");
    Integer participantCount = (Integer) request.getAttribute("participantCount");
    
    if (activity == null) {
        response.sendRedirect("clubActivitiesPage.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Activity Participants</title>
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
        width: 270px;
        height: 100vh;
        background-color: #00796B;
        color: white;
        position: fixed;
        padding: 70px 20px 20px 20px;
        overflow: hidden;
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

    /* Activity Info Section */
    .activity-info {
      background: white;
      margin: 20px;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }

    .activity-info h2 {
      color: #00796B;
      margin-bottom: 15px;
    }

    .activity-details {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;
      margin-bottom: 20px;
    }

    .detail-item {
      padding: 10px;
      background: #f5f5f5;
      border-radius: 5px;
    }

    .detail-label {
      font-weight: bold;
      color: #666;
      font-size: 0.9em;
    }

    .detail-value {
      color: #333;
      margin-top: 5px;
    }

    /* Participants Section */
    .participants-section {
      background: white;
      margin: 20px;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }

    .participants-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .participants-title {
      font-size: 24px;
      color: #00796B;
      font-weight: bold;
    }

    .participant-count {
      background: #00796B;
      color: white;
      padding: 8px 16px;
      border-radius: 20px;
      font-weight: bold;
    }

    .back-btn {
      background: #00796B;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      margin-bottom: 20px;
      transition: background-color 0.3s ease;
    }

    .back-btn:hover {
      background: #004d40;
    }

    /* Participants Table */
    .participants-table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }

    .participants-table th {
      background: #e0f7fa;
      padding: 12px;
      text-align: left;
      font-weight: bold;
      color: #00796B;
    }

    .participants-table td {
      padding: 12px;
      border-bottom: 1px solid #eee;
    }

    .participants-table tr:hover {
      background: #f9f9f9;
    }

    .no-participants {
      text-align: center;
      padding: 40px;
      color: #888;
      font-style: italic;
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

      .activity-details {
        grid-template-columns: 1fr;
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
    <h3><%= session.getAttribute("clubName") %></h3>
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
      <div class="header-title">ACTIVITY PARTICIPANTS</div>
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

    <!-- Back Button -->
    <div style="padding: 20px;">
      <a href="clubActivitiesPage.jsp" class="back-btn">← Back to Activities</a>
    </div>

    <!-- Activity Information -->
    <div class="activity-info">
      <h2><%= activity.getActivityName() %></h2>
      <div class="activity-details">
        <div class="detail-item">
          <div class="detail-label">Activity ID</div>
          <div class="detail-value"><%= activity.getActivityID() %></div>
        </div>
        <div class="detail-item">
          <div class="detail-label">Date</div>
          <div class="detail-value"><%= activity.getActivityDate() %></div>
        </div>
        <div class="detail-item">
          <div class="detail-label">Venue</div>
          <div class="detail-value"><%= activity.getActivityVenue() != null ? activity.getActivityVenue() : "Not specified" %></div>
        </div>
        <div class="detail-item">
          <div class="detail-label">Status</div>
          <div class="detail-value">
            <% if ("Approved".equalsIgnoreCase(activity.getActivityStatus())) { %>
              <span style="background:#c8f7c5; color:#218838; padding:4px 12px; border-radius:12px; font-weight:500;">Approved</span>
            <% } else if ("Pending".equalsIgnoreCase(activity.getActivityStatus())) { %>
              <span style="background:#fff3cd; color:#856404; padding:4px 12px; border-radius:12px; font-weight:500;">Pending</span>
            <% } else if ("Reject".equalsIgnoreCase(activity.getActivityStatus())) { %>
              <span style="background:#f8d7da; color:#721c24; padding:4px 12px; border-radius:12px; font-weight:500;">Reject</span>
            <% } else { %>
              <span style="background:#e2e3e5; color:#383d41; padding:4px 12px; border-radius:12px; font-weight:500;"><%= activity.getActivityStatus() %></span>
            <% } %>
          </div>
        </div>
      </div>
    </div>

    <!-- Participants List -->
    <div class="participants-section">
      <div class="participants-header">
        <div class="participants-title">Registered Participants</div>
        <div class="participant-count"><%= participantCount %> Participants</div>
      </div>

      <% if (participants != null && !participants.isEmpty()) { %>
        <table class="participants-table">
          <thead>
            <tr>
              <th>Student ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Course</th>
              <th>Semester</th>
              <th>Phone</th>
            </tr>
          </thead>
          <tbody>
            <% for (STUDENT student : participants) { %>
              <tr>
                <td><%= student.getStudID() %></td>
                <td><%= student.getStudName() %></td>
                <td><%= student.getStudEmail() %></td>
                <td><%= student.getStudCourse() %></td>
                <td><%= student.getStudSemester() %></td>
                <td><%= student.getStudNoPhone() != null ? student.getStudNoPhone() : "Not provided" %></td>
              </tr>
            <% } %>
          </tbody>
        </table>
      <% } else { %>
        <div class="no-participants">
          <h3>No participants registered yet</h3>
          <p>Students can register for this activity through the student portal.</p>
        </div>
      <% } %>
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