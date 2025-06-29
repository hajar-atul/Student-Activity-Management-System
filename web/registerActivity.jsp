<%@ page import="model.ACTIVITY, model.CLUB, model.STUDENT" %>
<%
  ACTIVITY activity = (ACTIVITY) request.getAttribute("activity");
  STUDENT student = (STUDENT) request.getAttribute("student");
  CLUB club = (CLUB) request.getAttribute("club");
  
  if (activity == null || student == null) {
    response.sendRedirect("availableActivityList.jsp?error=Invalid+activity+or+student+data");
    return;
  }
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
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    .container {
      max-width: 500px;
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.10);
      padding: 36px 32px 28px 32px;
      width: 100%;
      margin: 20px;
    }
    h2 {
      text-align: center;
      color: #008b8b;
      margin-bottom: 24px;
      font-size: 1.8em;
    }
    .info-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 14px;
      padding: 8px 0;
      border-bottom: 1px solid #eee;
    }
    .info-label {
      font-weight: bold;
      color: #00796B;
      min-width: 120px;
    }
    .info-value {
      color: #222;
      text-align: right;
      flex: 1;
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
    .back-btn {
      background: #666;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 1em;
      font-weight: bold;
      padding: 10px 20px;
      cursor: pointer;
      transition: background 0.2s;
      margin-top: 10px;
      width: 100%;
    }
    .back-btn:hover {
      background: #555;
    }
    .activity-type {
      background: #4caf50;
      color: white;
      padding: 4px 12px;
      border-radius: 6px;
      font-size: 0.9em;
      font-weight: bold;
      display: inline-block;
      margin-bottom: 10px;
    }
    .poster-image {
      width: 100%;
      max-height: 200px;
      object-fit: cover;
      border-radius: 8px;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Register for Activity</h2>
    <form method="post" action="RegisterActivityStudentServlet" onsubmit="return confirmRegistration()">
      <input type="hidden" name="activityID" value="<%= activity.getActivityID() %>" />
      
      <div class="activity-type">FREE ACTIVITY</div>
      
      <% if (activity.getPosterImage() != null && activity.getPosterImage().length > 0) { %>
        <img src="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=poster" 
             alt="Activity Poster" class="poster-image" />
      <% } %>
      
      <div class="info-row">
        <span class="info-label">Activity Name:</span>
        <span class="info-value"><%= activity.getActivityName() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Description:</span>
        <span class="info-value"><%= activity.getActivityDesc() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Date:</span>
        <span class="info-value"><%= activity.getActivityDate() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Venue:</span>
        <span class="info-value"><%= activity.getActivityVenue() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Organized by:</span>
        <span class="info-value"><%= club != null ? club.getClubName() : "N/A" %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Adab Point:</span>
        <span class="adab-point"><%= activity.getAdabPoint() %></span>
      </div>
      
      <hr style="margin: 20px 0; border: none; border-top: 1px solid #eee;">
      
      <div class="info-row">
        <span class="info-label">Student Name:</span>
        <span class="info-value"><%= student.getStudName() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Student ID:</span>
        <span class="info-value"><%= student.getStudID() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Email:</span>
        <span class="info-value"><%= student.getStudEmail() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Course:</span>
        <span class="info-value"><%= student.getStudCourse() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Semester:</span>
        <span class="info-value"><%= student.getStudSemester() %></span>
      </div>
      <div class="info-row">
        <span class="info-label">Phone:</span>
        <span class="info-value"><%= student.getStudNoPhone() %></span>
      </div>
      
      <button type="submit" class="register-btn">Confirm Registration</button>
      <button type="button" class="back-btn" onclick="location.href='AvailableServlet'">← Back to Activities</button>
    </form>
  </div>
  
  <script>
    function confirmRegistration() {
      if (confirm("Are you sure you want to register for this activity? You will receive <%= activity.getAdabPoint() %> Adab Points upon successful registration.")) {
        return true;
      }
      return false;
    }
    
    // Show success message if redirected with success parameter
    window.onload = function() {
      const urlParams = new URLSearchParams(window.location.search);
      const success = urlParams.get('success');
      if (success) {
        alert(success.replace(/\+/g, ' '));
      }
    };
  </script>
</body>
</html> 