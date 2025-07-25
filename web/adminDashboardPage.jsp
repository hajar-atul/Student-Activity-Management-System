<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB, model.STUDENT" %>
<%
    List<ACTIVITY> pendingProposals = ACTIVITY.getActivitiesByStatus("Pending");
    List<ACTIVITY> appealActivities = ACTIVITY.getActivitiesByStatus("Appeal Pending");
    int totalStudents = STUDENT.getTotalStudents();
    int totalClubs = CLUB.getTotalClubs();
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; }
    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #238B87;
      color: white;
      position: fixed;
      padding: 40px 20px 20px 20px;
      overflow-y: auto;
      z-index: 10;
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .sidebar img.profile-pic {
      width: 170px;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 30px;
      border: 3px solid white;
      background: #fff;
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
      text-align: center;
    }
    .sidebar ul li a.active, .sidebar ul li a:hover {
      background-color: #1a7e7c;
      font-weight: bold;
    }
    .main-content {
      margin-left: 270px;
      min-height: 100vh;
      background: #f6f6f6;
    }
    .header {
      display: flex;
      align-items: center;
      background-color: #238B87;
      color: #fff;
      padding: 18px 40px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
      position: sticky;
      top: 0;
      z-index: 5;
      gap: 20px;
      justify-content: space-between;
    }
    .header-title {
      font-size: 32px;
      font-weight: bold;
      letter-spacing: 1px;
    }
    .header .top-icons {
      display: flex;
      align-items: center;
      gap: 18px;
      position: relative;
    }
    .header .top-icons img {
      width: 45px;
      height: 45px;
      object-fit: contain;
      background: transparent;
    }
    .header .top-icons .profile-icon {
      width: 45px;
      height: 45px;
      border-radius: 50%;
      border: none;
      background: transparent;
    }
    .notification-dropdown {
      display: none;
      position: absolute;
      top: 60px;
      right: 60px;
      background-color: #fff;
      color: #222;
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 14px 18px;
      width: 240px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      z-index: 100;
      font-size: 16px;
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
    .activity-section {
      padding: 40px 40px 0 40px;
    }
    .activity-section h2 {
      font-size: 26px;
      font-weight: bold;
      margin-bottom: 18px;
      text-align: left;
    }
    .proposal-table {
      width: 96%;
      font-size: 18px;
      margin-bottom: 50px;
      margin-left: auto;
      margin-right: auto;
      background: #fff;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }
    .proposal-table th, .proposal-table td {
      padding: 20px 16px;
      border: 1px solid #e0e0e0;
      text-align: center;
      font-size: 18px;
    }
    .proposal-table th {
      background: #f7f7f7;
      font-weight: bold;
    }
    .proposal-table td .action-btn {
      margin: 0 2px;
      padding: 6px 16px;
      border: none;
      border-radius: 5px;
      color: #fff;
      font-size: 15px;
      cursor: pointer;
      font-weight: 500;
      transition: background 0.2s;
    }
    .proposal-table td .view-btn { background: #00bfa6; }
    .proposal-table td .approve-btn { background: #4caf50; }
    .proposal-table td .reject-btn { background: #f44336; }
    .proposal-table td .view-btn:hover { background: #009e88; }
    .proposal-table td .approve-btn:hover { background: #388e3c; }
    .proposal-table td .reject-btn:hover { background: #c62828; }
    .overview-section {
      margin-top: 40px;
    }
    .overview-title {
      font-size: 26px;
      font-weight: bold;
      margin-bottom: 24px;
    }
    .overview-cards {
      display: flex;
      gap: 40px;
      justify-content: flex-start;
      flex-wrap: wrap;
    }
    .overview-card {
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
      padding: 38px 56px;
      display: flex;
      align-items: center;
      gap: 24px;
      min-width: 270px;
      min-height: 120px;
      font-size: 22px;
    }
    .overview-card .icon {
      font-size: 70px;
      color: #219a98;
      width: 70px;
      text-align: center;
    }
    .overview-card .icon img {
      width: 70px;
      height: 70px;
      object-fit: contain;
    }
    .overview-card .info {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
    }
    .overview-card .info .number {
      font-size: 36px;
      font-weight: bold;
      color: #222;
    }
    .overview-card .info .label {
      font-size: 20px;
      color: #555;
      margin-top: 2px;
    }
    @media (max-width: 900px) {
      .main-content { margin-left: 0; }
      .sidebar { position: static; width: 100%; height: auto; }
      .toggle-btn { display: block; }
      .overview-cards { flex-direction: column; gap: 18px; }
      .activity-section { padding: 20px 10px 0 10px; }
    }
  </style>
</head>
<body>

<div class="sidebar" id="sidebar">
  <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-pic">
  <ul>
    <li><a href="adminDashboardPage.jsp" class="active">MANAGE ACTIVITIES</a></li>
    <li><a href="adminStudentList.jsp">STUDENT LIST</a></li>
    <li><a href="adminFeedback.jsp">FEEDBACK</a></li>
    <li><a href="addAdmin.jsp">ADD ADMIN</a></li>
    <li><a href="adminReport.jsp">REPORT</a></li>
  </ul>
  <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
    <form action="index.jsp">
        <button type="submit" class="activity-btn">Logout</button>
    </form>
  </div>
</div>

<div class="main-content" id="mainContent">
  <div class="header">
    <div class="header-title">MANAGE ACTIVITIES</div>
    <div class="top-icons">
      <img src="image/umpsa.png" alt="UMPSA Logo">
      <img src="image/bell.png" alt="Notifications" id="notificationBtn" style="cursor:pointer;">
      <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-icon">
      <div class="notification-dropdown" id="notificationDropdown">
        <strong>Notifications</strong>
        <ul style="margin:10px 0 0 0; padding:0 0 0 18px;">
          <li>No new notifications</li>
        </ul>
      </div>
    </div>
  </div>
  <div class="notification-dropdown" id="notificationDropdown" style="display:none; position:absolute; top:80px; right:60px; background-color:white; color:black; border:1px solid #ccc; border-radius:8px; padding:10px; width:200px; box-shadow:0 2px 8px rgba(0,0,0,0.15); z-index:100;">
    <p>No new notifications</p>
  </div>

  <div class="activity-section">
    <h2>Proposal Requests</h2>
    <% if (message != null) { %>
      <div style="background: #c8f7c5; color: #218838; padding: 12px; margin-bottom: 20px; border-radius: 6px; text-align: center; font-weight: 500;">
        <%= message.replace("+", " ") %>
      </div>
    <% } %>
    <table class="proposal-table">
      <thead>
        <tr>
          <th>ACTIVITY</th>
          <th>CLUB</th>
          <th>DATE</th>
          <th>ACTION</th>
        </tr>
      </thead>
      <tbody>
      <% if (pendingProposals != null && !pendingProposals.isEmpty()) {
          for (ACTIVITY proposal : pendingProposals) {
              CLUB club = CLUB.getClubById(proposal.getClubID());
              String clubName = (club != null) ? club.getClubName() : "N/A";
      %>
      <tr>
          <td><%= proposal.getActivityName() %></td>
          <td><%= clubName %></td>
          <td><%= proposal.getActivityDate() %></td>
          <td>
              <a href="viewProposal.jsp?activityID=<%= proposal.getActivityID() %>" class="action-btn view-btn">View</a>
              <a href="handleProposal?action=approve&activityID=<%= proposal.getActivityID() %>" class="action-btn approve-btn">Approve</a>
              <a href="handleProposal?action=reject&activityID=<%= proposal.getActivityID() %>" class="action-btn reject-btn">Reject</a>
          </td>
      </tr>
      <% } } else { %>
      <tr>
          <td colspan="4">No pending proposals at the moment.</td>
      </tr>
      <% } %>
      </tbody>
    </table>

    <!-- Appeal Pending Activities Section -->
    <h2 style="margin-top:40px;">Appeal Activities</h2>
    <table class="proposal-table">
      <thead>
        <tr>
          <th>ACTIVITY</th>
          <th>CLUB</th>
          <th>DATE</th>
          <th>APPEAL REASON</th>
          <th>ACTION</th>
        </tr>
      </thead>
      <tbody>
      <% if (appealActivities != null && !appealActivities.isEmpty()) {
          for (ACTIVITY appeal : appealActivities) {
              CLUB club = CLUB.getClubById(appeal.getClubID());
              String clubName = (club != null) ? club.getClubName() : "N/A";
      %>
      <tr>
          <td><%= appeal.getActivityName() %></td>
          <td><%= clubName %></td>
          <td><%= appeal.getActivityDate() %></td>
          <td><%= appeal.getAppealReason() != null ? appeal.getAppealReason() : "-" %></td>
          <td>
              <a href="handleProposal?action=approve&activityID=<%= appeal.getActivityID() %>" class="action-btn approve-btn">Approve</a>
              <a href="handleProposal?action=reject&activityID=<%= appeal.getActivityID() %>" class="action-btn reject-btn">Reject</a>
          </td>
      </tr>
      <% } } else { %>
      <tr>
          <td colspan="5">No appeal activities at the moment.</td>
      </tr>
      <% } %>
      </tbody>
    </table>

    <div class="overview-section">
      <div class="overview-title">Overview</div>
      <div class="overview-cards">
        <div class="overview-card">
          <div class="icon"><img src="image/userIcon.png" alt="Student Icon"></div>
          <div class="info">
            <div class="number"><%= totalStudents %></div>
            <div class="label">Student</div>
          </div>
        </div>
        <div class="overview-card">
          <div class="icon"><img src="image/clubIcon.jpg" alt="Club Icon"></div>
          <div class="info">
            <div class="number"><%= totalClubs %></div>
            <div class="label">Club</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    var bell = document.getElementById('notificationBtn');
    var dropdown = document.getElementById('notificationDropdown');
    bell.addEventListener('click', function(e) {
      e.stopPropagation();
      dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
    });
    document.addEventListener('click', function(e) {
      if (dropdown.style.display === 'block') {
        dropdown.style.display = 'none';
      }
    });
  });
</script>

</body>
</html>
