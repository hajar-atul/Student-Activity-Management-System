<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB" %>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    List<ACTIVITY> rejectedActivities = new java.util.ArrayList<ACTIVITY>();
    if (club != null) {
        for (ACTIVITY act : ACTIVITY.getActivitiesByClubId(club.getClubId())) {
            if ("Rejected".equalsIgnoreCase(act.getActivityStatus())) {
                rejectedActivities.add(act);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Resource Booking Form</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', Arial, sans-serif;
      background: #e6f2ff;
      height: 100vh;
      overflow: hidden;
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
      min-height: 100vh;
      overflow: hidden;
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

    .resource-form-container {
      background: #f4f4f4;
      max-width: 700px;
      margin: 40px auto;
      border-radius: 18px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.10);
      padding: 0 0 32px 0;
      border: 2px solid #ccc;
      height: 480px;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    
    .resource-form-title {
      text-align: center;
      color: #111;
      font-size: 2em;
      font-weight: bold;
      padding: 24px 0 10px 0;
      letter-spacing: 1px;
    }
    
    form {
      background: #f4f4f4;
      border-radius: 12px;
      margin: 0 24px;
      padding: 18px 0 0 0;
      display: flex;
      flex-wrap: wrap;
      gap: 22px 32px;
      box-sizing: border-box;
      justify-content: space-between;
      align-items: flex-start;
      height: 320px;
    }
    
    .form-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
      flex: 1 1 45%;
      min-width: 220px;
      max-width: 320px;
    }
    
    .form-group label {
      font-weight: 600;
      color: #222;
      margin-bottom: 2px;
    }
    
    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="time"] {
      padding: 10px 16px;
      border: 1.5px solid #bbb;
      border-radius: 18px;
      font-size: 1em;
      background: #fff;
      font-family: 'Poppins', Arial, sans-serif;
      outline: none;
      transition: border 0.2s;
    }
    
    .form-group input[type="text"]:focus,
    .form-group input[type="date"]:focus,
    .form-group input[type="time"]:focus {
      border: 1.5px solid #009688;
    }
    
    .submit-btn {
      background: #002aff;
      color: #fff;
      border: none;
      border-radius: 10px;
      font-size: 1.2em;
      font-weight: bold;
      padding: 16px 0;
      margin-top: 18px;
      width: 100%;
      cursor: pointer;
      transition: background 0.2s, transform 0.2s;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      letter-spacing: 1px;
      align-self: flex-end;
      max-width: 320px;
    }
    
    .submit-btn:hover {
      background: #001a99;
      transform: translateY(-2px) scale(1.03);
    }

    .message {
      text-align: center;
      padding: 10px;
      margin: 0 24px 15px 24px;
      border-radius: 8px;
      background: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    @media (max-width: 768px) {
      .sidebar {
        position: static;
      }

      .toggle-btn {
        position: absolute;
        left: 10px;
        top: 10px;
      }

      .main-content {
        margin-left: 20px;
      }

      .header {
        padding: 15px 20px;
      }

      .header-title {
        font-size: 20px;
      }

      .resource-form-container {
        margin: 20px;
        max-width: 95vw;
      }
    }

    @media (max-width: 600px) {
      .resource-form-container {
        margin: 18px 6px;
        max-width: 98vw;
      }
      
      form {
        margin: 0 6px;
        padding: 12px 0 0 0;
      }
    }
  </style>
</head>
<body>
  <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

  <div class="sidebar" id="sidebar">
    <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Profile Picture" class="profile-pic">
    <h3><%= session.getAttribute("clubName") %></h3>
    <ul>
      <li><a href="clubDashboardPage.jsp">DASHBOARD</a></li>
      <li><a href="clubActivitiesPage.jsp">ACTIVITIES</a></li>
      <li><a href="venueBooking.jsp">VENUE BOOKING</a></li>
      <li><a href="resourceReq.jsp" class="active">RESOURCE BOOKING</a></li>
      <li><a href="clubFeedback.jsp">FEEDBACK</a></li>
      <li><a href="clubReport.jsp">REPORT</a></li>
      <li><a href="clubSettings.jsp">SETTINGS</a></li>
    </ul>
  </div>

  <div class="main-content" id="mainContent">
    <div class="header">
      <div class="header-title">RESOURCE BOOKING</div>
      <div class="top-icons">
        <img src="image/umpsa.png" alt="UMPSA Logo" class="umpsa-icon" />
        <button class="notification-btn" id="notificationBtn">
          <img src="image/bell.png" alt="Notifications" />
        </button>
        <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Avatar" class="profile-icon" />
      </div>
    </div>

    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>

    <div class="resource-form-container">
      <div class="resource-form-title">RESOURCE BOOKING FORM</div>
      
      <% if (request.getParameter("message") != null) { %>
        <div class="message">
            <%= request.getParameter("message") %>
        </div>
      <% } %>

      <form action="ResourceBookingServlet" method="post">
        <div class="form-group">
          <label for="date">Date</label>
          <input type="date" id="date" name="date" required />
        </div>
        <div class="form-group">
          <label for="duration">Duration</label>
          <input type="text" id="duration" name="duration" required />
        </div>
        <div class="form-group">
          <label for="time">Time</label>
          <input type="text" id="time" name="time" required />
        </div>
        <div class="form-group">
          <label for="resourceName">Resources Name</label>
          <input type="text" id="resourceName" name="resourceName" required />
        </div>
        <div class="form-group">
          <label for="resourceQty">Resources Quantity</label>
          <input type="text" id="resourceQty" name="resourceQty" required />
        </div>
        <button type="submit" class="submit-btn">Submit</button>
      </form>
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
  </script>
</body>
</html> 