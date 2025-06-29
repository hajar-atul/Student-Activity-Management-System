<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB" %>
<%
    List<ACTIVITY> availableActivities = ACTIVITY.getAvailableUpcomingActivities();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Available Activities</title>
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

    .LOGOUT-btn {
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

    .LOGOUT-btn:hover {
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
        overflow-y: auto;
        transition: margin-left 0.3s ease;
    }

    .sidebar.closed ~ .content {
        margin-left: 0;
    }

    .activity-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .activity-header h1 {
        font-size: 24px;
        color: #0a6d6d;
    }

    .activity-list {
        display: flex;
        flex-direction: column;
        gap: 20px;
        max-width: 850px;
        margin: 0 auto;
    }

    .activity-card {
        background-color: #ffffff;
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        font-size: 14px;
    }

    .activity-card h3 {
        color: #008b8b;
        margin-bottom: 10px;
    }

    .activity-card .type {
        font-weight: bold;
        color: white;
        background-color: #008b8b;
        display: inline-block;
        padding: 5px 10px;
        border-radius: 6px;
        margin-bottom: 10px;
    }

    .activity-card .meta,
    .activity-card .club,
    .activity-card .desc,
    .activity-card .adab-point {
        margin-bottom: 8px;
    }

    .activity-card .register-btn {
        display: inline-block;
        margin-top: 10px;
        padding: 8px 14px;
        text-decoration: none;
        background-color: #0a6d6d;
        color: white;
        border-radius: 6px;
        font-weight: bold;
        transition: background-color 0.2s ease;
    }

    .activity-card .register-btn:hover {
        background-color: #065a5a;
    }

    .activity-card img.poster-image {
        max-width: 100%;
        margin: 10px 0;
        border-radius: 8px;
    }

    @media (max-width: 768px) {
        .content {
            margin-left: 0;
        }
    }
  </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <img src="StudentImageServlet?studID=${studID}" alt="Profile" class="profile-pic" />
    <h2><%= session.getAttribute("studName") %><br><%= session.getAttribute("studID") %></h2>
    <div class="menu">
        <a href="studentDashboardPage.jsp">DASHBOARD</a>
        <a href="activities.jsp">ACTIVITIES</a>
        <a href="studentClub.jsp">CLUBS</a>
        <a href="SettingsServlet">SETTINGS</a>
    </div>
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
    <div class="search-container">
        <input type="text" placeholder="Search..." />
        <button class="search-btn">X</button>
    </div>
    <div class="dashboard-title">DASHBOARD</div>
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
<div class="content">
    <div class="activity-header">
        <h1>AVAILABLE ACTIVITIES</h1>
    </div>

    <% 
      String successMsg = request.getParameter("success");
      String errorMsg = request.getParameter("error");
      if (successMsg != null) {
    %>
      <div style="background: #c8f7c5; color: #218838; padding: 12px; margin: 0 auto 20px auto; border-radius: 6px; text-align: center; font-weight: 500; max-width: 850px;">
        <%= successMsg.replace("+", " ") %>
      </div>
    <% } %>
    <% if (errorMsg != null) { %>
      <div style="background: #f8d7da; color: #721c24; padding: 12px; margin: 0 auto 20px auto; border-radius: 6px; text-align: center; font-weight: 500; max-width: 850px;">
        <%= errorMsg.replace("+", " ") %>
      </div>
    <% } %>

    <% if (availableActivities == null || availableActivities.isEmpty()) { %>
      <div class="activity-list">
        <div class="activity-card">
          <h3 style="text-align: center; color: #666;">No Available Activities</h3>
          <p style="text-align: center; color: #666;">
            You have either registered for all available activities or there are no upcoming activities at the moment. 
            Please check back later for new activities!
          </p>
          <div style="text-align: center; margin-top: 15px;">
            <a href="CurrentServlet" style="color: #008b8b; text-decoration: none; font-weight: bold;">
              View My Registered Activities →
            </a>
          </div>
        </div>
      </div>
    <% } else { %>
    <div class="activity-list">
      <% for (int i = 0; i < availableActivities.size(); i++) {
           ACTIVITY activity = availableActivities.get(i);
           CLUB club = CLUB.getClubById(activity.getClubID());
           String clubName = (club != null) ? club.getClubName() : "N/A";
      %>
      <div class="activity-card">
        <div class="type"><%= activity.getActivityType() %></div>
        <h3><%= activity.getActivityName() %></h3>
        <% if (activity.getPosterImage() != null && activity.getPosterImage().length > 0) { %>
        <img src="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=poster" class="poster-image" alt="Poster">
        <% } %>
        <div class="meta">Date: <%= activity.getActivityDate() %></div>
        <div class="meta">Venue: <%= activity.getActivityVenue() %></div>
        <div class="club">Organized by: <%= clubName %></div>
        <div class="desc"><%= activity.getActivityDesc() %></div>
        <div class="adab-point">Adab Point: <%= activity.getAdabPoint() %></div>
        <% if ("Paid".equals(activity.getActivityType())) { %>
        <a class="register-btn" href="qrPaymentTypePage.jsp?activityID=<%= activity.getActivityID() %>">Register (Paid)</a>
        <% } else { %>
        <a class="register-btn" href="RegisterActivityStudentServlet?activityID=<%= activity.getActivityID() %>">Register (Free)</a>
        <% } %>
      </div>
      <% } %>
    </div>
    <% } %>
</div>

<script>
  document.getElementById('toggleBtn').addEventListener('click', function () {
    document.getElementById('sidebar').classList.toggle('closed');
  });
</script>

</body>
</html>
