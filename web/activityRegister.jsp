<%@ page import="model.ACTIVITY, model.CLUB, model.STUDENT" %>
<%
  String activityID = request.getParameter("activityID");
  ACTIVITY activity = ACTIVITY.getActivityById(activityID);
  CLUB club = CLUB.getClubById(activity.getClubID());
  String clubName = (club != null) ? club.getClubName() : "N/A";
  String studName = (String) session.getAttribute("studName");
  String studID = (String) session.getAttribute("studID");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register for Activity</title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background: #f0f0f0;
      margin: 0;
      padding: 0;
    }
    .container {
      max-width: 500px;
      margin: 60px auto;
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.10);
      padding: 36px 32px 28px 32px;
    }
    h2 {
      text-align: center;
      color: #008b8b;
      margin-bottom: 24px;
    }
    .info-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 14px;
    }
    .info-label {
      font-weight: bold;
      color: #00796B;
    }
    .info-value {
      color: #222;
    }
    .adab-point {
      color: #fff;
      background: #ff9800;
      border-radius: 8px;
      padding: 2px 12px;
      font-weight: bold;
      display: inline-block;
      margin-bottom: 10px;
    }
    .register-btn {
      background: #008b8b;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 1.1em;
      font-weight: bold;
      padding: 12px 0;
      width: 100%;
      cursor: pointer;
      transition: background 0.2s, transform 0.2s;
      margin-top: 18px;
    }
    .register-btn:hover {
      background: #00796B;
      transform: translateY(-2px) scale(1.03);
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Register for Activity</h2>
    <form method="post" action="RegisterActivityStudentServlet">
      <input type="hidden" name="activityID" value="<%= activity.getActivityID() %>" />
      <div class="info-row"><span class="info-label">Activity Name:</span><span class="info-value"><%= activity.getActivityName() %></span></div>
      <div class="info-row"><span class="info-label">Description:</span><span class="info-value"><%= activity.getActivityDesc() %></span></div>
      <div class="info-row"><span class="info-label">Date:</span><span class="info-value"><%= activity.getActivityDate() %></span></div>
      <div class="info-row"><span class="info-label">Venue:</span><span class="info-value"><%= activity.getActivityVenue() %></span></div>
      <div class="info-row"><span class="info-label">Type:</span><span class="info-value"><%= activity.getActivityType() %></span></div>
      <div class="info-row"><span class="info-label">Organized by:</span><span class="info-value"><%= clubName %></span></div>
      <div class="info-row"><span class="info-label">Adab Point:</span><span class="adab-point"><%= activity.getAdabPoint() %></span></div>
      <div class="info-row"><span class="info-label">Student Name:</span><span class="info-value"><%= studName %></span></div>
      <div class="info-row"><span class="info-label">Student ID:</span><span class="info-value"><%= studID %></span></div>
      <button type="submit" class="register-btn">Confirm Register</button>
    </form>
  </div>
</body>
</html> 