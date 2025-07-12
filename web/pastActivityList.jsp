<%-- 
    Document   : pastActivitiesList
    Created on : Jun 9, 2025, 1:46:36 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB" %>
<%
    List<ACTIVITY> pastActivities = (List<ACTIVITY>) request.getAttribute("pastActivities");
    if (pastActivities == null) {
        pastActivities = new java.util.ArrayList<ACTIVITY>();
    }
    
    String studID = (String) session.getAttribute("studID");
    // Get counts for summary cards
    List<ACTIVITY> allRegisteredActivities = ACTIVITY.getActivitiesByStudentId(studID);
    int totalActivities = allRegisteredActivities != null ? allRegisteredActivities.size() : 0;
    int clubCount = ACTIVITY.getClubCountByStudentId(studID);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Activity List</title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet">
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

    .logout-container {
      margin-top: auto;
      padding-top: 20px;
    }

    .logout-container .LOGOUT-btn {
      display: block;
      width: 100%;
      padding: 10px;
      background-color: #d82215d2;
      color: white;
      border: none;
      border-radius: 5px;
      text-align: center;
      font-size: 16px;
      font-weight: bold;
      transition: background-color 0.2s;
      cursor: pointer;
    }

    .logout-container .LOGOUT-btn:hover {
      background-color: #b71c1c;
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
  overflow: hidden; /* ✅ Prevents scrolling */
  transition: margin-left 0.3s ease;
}


    .sidebar.closed ~ .content {
      margin-left: 0;
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

    .status-attended {
      color: #4CAF50;
      font-weight: bold;
    }

    /* Back Button */
    .back-btn {
      background-color: #008b8b;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      margin-bottom: 20px;
      font-size: 16px;
    }

    .back-btn:hover {
      background-color: #006d6d;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .content {
        margin-left: 0;
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

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <img src="StudentImageServlet?studID=${studID}" alt="Profile" class="profile-pic" />
    <h2>
      <%= session.getAttribute("studName") %><br>
      <%= session.getAttribute("studID") %>
    </h2>
    <div class="menu">
      <a href="studentDashboardPage.jsp">DASHBOARD</a>
      <a href="activities.jsp">ACTIVITIES</a>
      <a href="studentClub.jsp">CLUBS</a>
      <a href="SettingsServlet">SETTINGS</a>
    </div>

    <!-- Logout button fixed at the bottom -->
    <div class="logout-container">
      <form action="index.jsp">
        <button type="submit" class="LOGOUT-btn">Logout</button>
      </form>
    </div>
  </div>

  <!-- Toggle Button -->
  <button class="toggle-btn" id="toggleBtn">☰</button>

  <!-- Topbar -->
  <div class="topbar">
    <div class="dashboard-title">ACTIVITIES</div>
    <div class="top-icons">
      <img src="image/umpsa.png" class="umpsa-icon" alt="UMPSA">
      <button class="notification-btn" id="notificationBtn">
        <img src="image/bell.png" alt="Notification">
      </button>
      <div class="notification-dropdown" id="notificationDropdown">
        <p>No new notifications</p>
      </div>
      <img src="StudentImageServlet?studID=${studID}" alt="Profile" class="profile-icon" id="profileBtn">
      <div class="profile-dropdown" id="profileDropdown">
        <a href="profile.jsp">My Profile</a>
        <a href="logout.jsp">Logout</a>
      </div>
    </div>
  </div>

  <!-- Content -->
  <div class="content" id="content">
    
    <div class="activity-section">
      <!-- Summary Cards -->
      <div class="summary-container">
        <div class="summary-card">
          <div class="summary-icon">
            <img src="image/activity_icon.png" alt="Activities Icon">
          </div>
          <div class="summary-text">
            <h3>TOTAL ACTIVITIES JOINED</h3>
            <p><%= totalActivities %></p>
          </div>
        </div>
        <div class="summary-card">
          <div class="summary-icon">
            <img src="image/club_icon.png" alt="Clubs Icon">
          </div>
          <div class="summary-text">
            <h3>CLUBS PARTICIPATED</h3>
            <p><%= clubCount %></p>
          </div>
        </div>
      </div>

      <!-- Table -->
      <div class="table-wrapper">
        <div class="title-bar">My Past Activities</div>
        <table>
          <thead>
            <tr style="background-color: #f0f0f0;">
              <th>ACTIVITY</th>
              <th>DATE</th>
              <th>VENUE</th>
              <th>STATUS</th>
              <th>ADAB POINTS</th>
              <th>ACTIONS</th>
            </tr>
          </thead>
          <tbody>
            <% if (pastActivities.isEmpty()) { %>
              <tr>
                <td colspan="6" style="text-align: center; padding: 20px; color: #666;">
                  No past activities found. <a href="AvailableServlet" style="color: #008b8b;">Browse available activities</a>
                </td>
              </tr>
            <% } else { %>
              <% for (ACTIVITY activity : pastActivities) { 
                   CLUB club = CLUB.getClubById(activity.getClubID());
                   String clubName = (club != null) ? club.getClubName() : "N/A";
              %>
              <tr>
                <td>
                  <strong><%= activity.getActivityName() %></strong><br>
                  <small style="color: #666;">Organized by: <%= clubName %></small>
                </td>
                <td><%= activity.getActivityDate() %></td>
                <td><%= activity.getActivityVenue() %></td>
                <td class="status-attended">Attended</td>
                <td><%= activity.getAdabPoint() %></td>
                <td>
                  <button onclick="location.href='feedback.jsp?activityID=<%= activity.getActivityID() %>'">Feedback →</button>
                  <button style="margin-left:8px;background:#4CAF50;color:white;" onclick="location.href='CertificateServlet?activityID=<%= activity.getActivityID() %>&studID=<%= studID %>'">Download e-Certificate</button>
                </td>
              </tr>
              <% } %>
            <% } %>
          </tbody>
        </table>
      </div>
      <button class="back-btn" onclick="location.href='activities.jsp'">← Back</button>
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
