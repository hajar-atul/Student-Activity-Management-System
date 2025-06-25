<%-- 
    Document   : availableActivityList
    Created on : Jun 9, 2025, 3:20:56 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB" %>
<%
    List<ACTIVITY> availableActivities = (List<ACTIVITY>) request.getAttribute("availableActivities");
    out.println("<div style='color:red;'>DEBUG: availableActivities = " + availableActivities + "</div>");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Available Activities</title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background: #f0f0f0;
      margin: 0;
      padding: 0;
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
    .dashboard-title {
      font-size: 26px;
      font-weight: bold;
      text-align: center;
      flex-grow: 1;
      margin-left: 60px;
    }
    .content {
      padding: 100px 30px 20px 30px;
      margin-left: 250px;
      min-height: 100vh;
      background: #f0f0f0;
    }
    .activity-header h1 {
      text-align: center;
      padding: 40px 0 20px 0;
      font-size: 2.2em;
      font-weight: bold;
      color: #008b8b;
    }
    .activity-list {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
      gap: 30px;
      justify-content: center;
      margin-top: 20px;
    }
    .activity-card {
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      padding: 28px 24px 20px 24px;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      position: relative;
      border: 2px solid #008b8b;
      transition: box-shadow 0.2s;
    }
    .activity-card:hover {
      box-shadow: 0 6px 18px rgba(0,0,0,0.13);
    }
    .activity-card h3 {
      font-size: 1.3em;
      color: #008b8b;
      margin-bottom: 8px;
      font-weight: bold;
    }
    .activity-card .meta {
      font-size: 0.98em;
      color: #444;
      margin-bottom: 6px;
    }
    .activity-card .club {
      font-size: 1em;
      color: #00796B;
      margin-bottom: 10px;
      font-weight: 500;
    }
    .activity-card .type {
      font-size: 0.95em;
      color: #fff;
      background: #009688;
      border-radius: 8px;
      padding: 2px 12px;
      margin-bottom: 10px;
      display: inline-block;
    }
    .activity-card .desc {
      font-size: 1em;
      color: #333;
      margin-bottom: 12px;
      min-height: 40px;
    }
    .activity-card .adab-point {
      font-size: 1em;
      color: #fff;
      background: #ff9800;
      border-radius: 8px;
      padding: 2px 12px;
      margin-bottom: 10px;
      display: inline-block;
      font-weight: bold;
    }
    .activity-card .register-btn {
      background: #008b8b;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 1.1em;
      font-weight: bold;
      padding: 10px 0;
      width: 100%;
      cursor: pointer;
      transition: background 0.2s, transform 0.2s;
      margin-top: 10px;
      text-align: center;
    }
    .activity-card .register-btn:hover {
      background: #00796B;
      transform: translateY(-2px) scale(1.03);
    }
    .no-activities {
      text-align: center;
      color: #888;
      font-size: 1.3em;
      margin-top: 60px;
    }
    @media (max-width: 900px) {
      .content { margin-left: 0; padding: 100px 5px 20px 5px; }
      .activity-list { gap: 16px; }
      .activity-card { width: 98vw; max-width: 350px; }
    }
  </style>
</head>
<body>
  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <img src="image/amin.jpg" alt="Profile" class="profile-pic" />
    <h2>
      <%= session.getAttribute("studName") %><br>
      <%= session.getAttribute("studID") %>
    </h2>
    <div class="menu">
      <a href="studentDashboardPage.jsp">DASHBOARD</a>
      <a href="activities.jsp">ACTIVITIES</a>
      <a href="studentClub.jsp">CLUBS</a>
      <a href="settings.jsp">SETTINGS</a>
    </div>
    <div class="logout-container">
      <form action="index.jsp">
        <button type="submit" class="LOGOUT-btn">Logout</button>
      </form>
    </div>
  </div>
  <!-- Topbar -->
  <div class="topbar">
    <div class="dashboard-title">ACTIVITIES</div>
  </div>
  <!-- Content -->
  <div class="content">
    <div class="activity-header">
      <h1>AVAILABLE ACTIVITIES</h1>
    </div>
    <% if (availableActivities == null || availableActivities.isEmpty()) { %>
      <div class="no-activities">No available activities at the moment. Please check back later!</div>
    <% } else { %>
      <div class="activity-list">
        <% for (int i = 0; i < availableActivities.size(); i++) {
             ACTIVITY activity = (ACTIVITY) availableActivities.get(i);
             CLUB club = CLUB.getClubById(activity.getClubID());
             String clubName = (club != null) ? club.getClubName() : "N/A";
        %>
        <div class="activity-card">
          <div class="type"><%= activity.getActivityType() %></div>
          <h3><%= activity.getActivityName() %></h3>
          <div class="meta">Date: <%= activity.getActivityDate() %></div>
          <div class="meta">Venue: <%= activity.getActivityVenue() %></div>
          <div class="club">Organized by: <%= clubName %></div>
          <div class="desc"><%= activity.getActivityDesc() %></div>
          <div class="adab-point">Adab Point: <%= activity.getAdabPoint() %></div>
          <a class="register-btn" href="RegisterActivityStudentServlet?activityID=<%= activity.getActivityID() %>">Register</a>
        </div>
        <% } %>
      </div>
    <% } %>
  </div>
</body>
</html>
