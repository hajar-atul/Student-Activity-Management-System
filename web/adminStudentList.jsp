<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB, model.REGISTERATION, model.STUDENT, java.util.Collections, java.util.Comparator" %>
<%
    List<CLUB> clubList = CLUB.getAllClubs();
    // Sort clubs alphabetically by club name
    Collections.sort(clubList, new Comparator<CLUB>() {
        @Override
        public int compare(CLUB club1, CLUB club2) {
            return club1.getClubName().compareToIgnoreCase(club2.getClubName());
        }
    });
    String selectedClubIdStr = request.getParameter("clubID");
    Integer selectedClubId = null;
    if (selectedClubIdStr != null && !selectedClubIdStr.isEmpty()) {
        selectedClubId = Integer.parseInt(selectedClubIdStr);
    }
    List<ACTIVITY.ActivityParticipantCount> activityList = ACTIVITY.getActivitiesWithParticipantCountsByClub(selectedClubId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student List</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; }
    html, body {
      overflow: hidden;
      height: 100%;
    }
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
    .dashboard-cards {
      display: flex;
      gap: 40px;
      margin: 40px 0 30px 0;
      justify-content: center;
      align-items: stretch;
      width: 100%;
      max-width: 1200px;
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
    .dashboard-card {
      background: #fff;
      border: 3px solid #222;
      border-radius: 18px;
      padding: 28px 38px;
      display: flex;
      flex-direction: column;
      align-items: center;
      min-width: 0;
      min-height: 170px;
      justify-content: center;
      max-width: 340px;
      box-sizing: border-box;
    }
    .dashboard-card.no-border {
      border: none !important;
      background: transparent;
      box-shadow: none !important;
      padding: 0;
      min-width: 0;
      max-width: 240px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .dashboard-card img {
      width: 240px;
      height: 170px;
      max-width: 100%;
      max-height: 170px;
      object-fit: cover;
      border-radius: 8px;
      margin-bottom: 10px;
      border: none;
    }
    .dashboard-card:first-child img {
      border: none !important;
      background: transparent !important;
      box-shadow: none !important;
    }
    .dashboard-card .icon {
      font-size: 54px;
      margin-bottom: 10px;
    }
    .dashboard-card .card-title {
      font-size: 20px;
      font-weight: 500;
      margin-bottom: 0;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .dashboard-card .card-desc {
      font-size: 16px;
      color: #333;
    }
    .filters {
      display: flex;
      gap: 40px;
      margin-bottom: 30px;
      margin-left: 80px;
    }
    .filters label {
      font-weight: bold;
      font-size: 16px;
      margin-bottom: 6px;
      display: block;
    }
    .filters select {
      width: 200px;
      padding: 8px 12px;
      border-radius: 5px;
      border: 2px solid #222;
      font-size: 16px;
      margin-top: 4px;
    }
    .student-table-container {
      margin: 0 10px 40px 10px;
    }
    .student-table {
      width: 85%;
      border-collapse: separate;
      border-spacing: 0;
      background: #fff;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
      border: 3px solid #222;
      margin: 0 auto;
    }
    .student-table th, .student-table td {
      padding: 12px 6px;
      border: 2px solid #222;
      text-align: center;
      font-size: 17px;
    }
    .student-table th {
      background: #ededed;
      font-weight: bold;
      font-size: 19px;
      letter-spacing: 1px;
    }
    .student-table td .view-btn {
      background: #1ec9b4;
      color: #fff;
      border: none;
      border-radius: 8px;
      padding: 10px 22px;
      font-size: 18px;
      font-weight: 500;
      cursor: pointer;
      transition: background 0.2s;
    }
    .student-table td .view-btn:hover {
      background: #159e8a;
    }
    @media (max-width: 1100px) {
      .dashboard-cards { flex-direction: column; gap: 18px; }
      .filters { flex-direction: column; gap: 18px; }
    }
    .dashboard-card.flex-row {
      flex-direction: row;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
      min-width: 700px;
      width: 100%;
      max-width: 1100px;
    }
    .dashboard-card.flex-row img {
      width: 130px;
      height: 130px;
      object-fit: contain;
      margin-bottom: 0;
      margin-right: 0;
    }
    .dashboard-card.flex-row .card-title {
      font-size: 20px;
      font-weight: 500;
      margin-bottom: 0;
      text-align: right;
      line-height: 1.2;
    }
    .dashboard-card canvas {
      width: 500px !important;
      height: 500px !important;
      max-width: 100%;
      margin: 0 10px 0 0;
      display: block;
    }
    .top-badge {
      display: inline-block;
      background: linear-gradient(90deg, #FFD700 0%, #FFA500 100%);
      color: #222;
      font-weight: bold;
      font-size: 15px;
      padding: 4px 14px;
      border-radius: 16px;
      margin-left: 8px;
      box-shadow: 0 2px 8px rgba(255,215,0,0.15);
      letter-spacing: 1px;
      vertical-align: middle;
      border: 2px solid #FFA500;
      animation: pop 1s infinite alternate;
    }
    @keyframes pop {
      0% { transform: scale(1); }
      100% { transform: scale(1.08); }
    }
  </style>
</head>
<body>

<div class="sidebar" id="sidebar">
  <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-pic">
  <ul>
    <li><a href="adminDashboardPage.jsp">MANAGE ACTIVITIES</a></li>
    <li><a href="adminStudentList.jsp" class="active">STUDENT LIST</a></li>
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
    <div class="header-title">STUDENT LIST</div>
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
  <form method="get" id="clubFilterForm" style="margin: 30px 0 20px 80px;">
    <label for="clubFilter">Filter by Club :</label>
    <select id="clubFilter" name="clubID" onchange="document.getElementById('clubFilterForm').submit()">
      <option value="">Select club</option>
      <% for (CLUB club : clubList) { %>
        <option value="<%= club.getClubId() %>" <%= (selectedClubId != null && club.getClubId() == selectedClubId) ? "selected" : "" %>>
          <%= club.getClubName() %>
        </option>
      <% } %>
    </select>
  </form>

  <div class="student-table-container">
    <table class="student-table">
      <thead>
        <tr>
          <th>RANK</th>
          <th>ACTIVITY</th>
          <th>CLUB</th>
          <th>STUDENT</th>
        </tr>
      </thead>
      <tbody>
        <% if (activityList.isEmpty()) { %>
        <tr>
            <td colspan="4">No activities found.</td>
        </tr>
        <% } else {
            int rowNum = 0;
            for (ACTIVITY.ActivityParticipantCount apc : activityList) {
                ACTIVITY activity = apc.activity;
                CLUB club = CLUB.getClubById(activity.getClubID());
                String clubName = (club != null) ? club.getClubName() : "N/A";
                int studentCount = apc.participantCount;
        %>
        <tr>
          <td style="font-weight:bold; font-size:18px; color:#238B87; text-align:center;">
            <%= (rowNum+1) %>
          </td>
          <td>
            <%= activity.getActivityName() %>
          </td>
          <td><%= clubName %></td>
          <td>
            <div style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
              <span style="font-size: 22px; font-weight: bold;"><%= studentCount %></span>
              <a href="activityParticipants?activityId=<%= activity.getActivityID() %>" class="view-btn" style="text-decoration: none; color: white;">View Students</a>
            </div>
          </td>
        </tr>
        <% rowNum++;
            }
        }
        %>
      </tbody>
    </table>
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