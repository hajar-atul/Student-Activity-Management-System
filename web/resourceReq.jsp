<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB" %>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    List<ACTIVITY> clubActivities = new java.util.ArrayList<ACTIVITY>();
    if (club != null) {
        clubActivities = ACTIVITY.getActivitiesByClubId(club.getClubId());
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
      background: white;
      max-width: 800px;
      margin: 40px auto;
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.12);
      padding: 40px;
      border: 1px solid #e0e0e0;
      position: relative;
      overflow: hidden;
    }
    
    .resource-form-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, #00796B, #0a8079);
    }
    
    .resource-form-title {
      text-align: center;
      color: #00796B;
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 30px;
      letter-spacing: 0.5px;
      position: relative;
    }
    
    .resource-form-title::after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 3px;
      background: linear-gradient(90deg, #00796B, #0a8079);
      border-radius: 2px;
    }
    
    form {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 24px;
      margin-top: 30px;
    }
    
    .form-group {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }
    
    .form-group label {
      font-weight: 600;
      color: #333;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: 4px;
    }
    
    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="time"] {
      padding: 14px 16px;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      font-size: 15px;
      background: #fafafa;
      font-family: 'Poppins', Arial, sans-serif;
      outline: none;
      transition: all 0.3s ease;
      color: #333;
    }
    
    .form-group input[type="text"]:focus,
    .form-group input[type="date"]:focus,
    .form-group input[type="time"]:focus {
      border-color: #00796B;
      background: white;
      box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.1);
      transform: translateY(-1px);
    }
    
    .form-group input[type="text"]::placeholder,
    .form-group input[type="date"]::placeholder,
    .form-group input[type="time"]::placeholder {
      color: #999;
      font-style: italic;
    }
    
    .submit-btn {
      background: #00796B;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 15px;
      font-weight: 500;
      padding: 12px 24px;
      margin-top: 20px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      grid-column: 1 / -1;
      max-width: 150px;
      margin-left: auto;
      margin-right: auto;
    }
    
    .submit-btn:hover {
      background: #004d40;
    }

    .message {
      text-align: center;
      padding: 16px;
      margin-bottom: 24px;
      border-radius: 8px;
      background: linear-gradient(135deg, #d4edda, #c3e6cb);
      color: #155724;
      border: 1px solid #c3e6cb;
      font-weight: 500;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .form-help-text {
      font-size: 12px;
      color: #666;
      margin-top: 4px;
      font-style: italic;
    }

    .activity-btn {
      width: 215px;
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
      margin-bottom: 8%;
    }
    .activity-btn:hover {
      background-color: #d32f2f;
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

      .header {
        padding: 15px 20px;
      }

      .header-title {
        font-size: 20px;
      }

      .resource-form-container {
        margin: 20px;
        max-width: 95vw;
        padding: 30px 20px;
      }
      
      form {
        grid-template-columns: 1fr;
        gap: 20px;
      }
      
      .submit-btn {
        max-width: 100px;
      }
    }

    @media (max-width: 600px) {
      .resource-form-container {
        margin: 15px 10px;
        max-width: 98vw;
        padding: 25px 15px;
      }
      
      .resource-form-title {
        font-size: 24px;
      }
      
      form {
        gap: 18px;
      }
      
      .form-group input[type="text"],
      .form-group input[type="date"],
      .form-group input[type="time"] {
        padding: 12px 14px;
        font-size: 14px;
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
    <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
      <form action="index.jsp">
        <button type="submit" class="activity-btn">Logout</button>
      </form>
    </div>
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
          <label for="activityID">Select Activity</label>
          <select id="activityID" name="activityID" required style="padding: 18px 20px; border-radius: 12px; font-size: 1.1em; background: #fafafa; border: 2px solid #e0e0e0; color: #333; width: 100%; box-sizing: border-box; margin-bottom: 8px;">
            <option value="">-- Select Activity --</option>
            <% for (ACTIVITY act : clubActivities) { 
                 if ("Approved".equalsIgnoreCase(act.getActivityStatus())) { %>
              <option value="<%= act.getActivityID() %>"><%= act.getActivityName() %></option>
            <% } } %>
          </select>
          <div class="form-help-text">Choose the activity for which you are booking the resource</div>
        </div>
        <div class="form-group">
          <label for="date">Booking Date</label>
          <input type="date" id="date" name="date" required placeholder="Select booking date" />
          <div class="form-help-text">Choose the date you need the resources</div>
        </div>
        <div class="form-group">
          <label for="time">Start Time</label>
          <input type="time" id="time" name="time" required placeholder="Select start time" />
          <div class="form-help-text">When you'll start using the resources</div>
        </div>
        <div class="form-group">
          <label for="duration">Duration (Hours)</label>
          <input type="text" id="duration" name="duration" required placeholder="e.g., 2" />
          <div class="form-help-text">How long you'll need the resources (in hours)</div>
        </div>
        <div class="form-group">
          <label for="resourceName">Resource Name</label>
          <input type="text" id="resourceName" name="resourceName" required placeholder="e.g., Projector, Sound System" />
          <div class="form-help-text">Name of the resource you want to book</div>
        </div>
        <div class="form-group">
          <label for="resourceQty">Quantity</label>
          <input type="text" id="resourceQty" name="resourceQty" required placeholder="e.g., 1, 2, 5" />
          <div class="form-help-text">Number of units needed</div>
        </div>
        <button type="submit" class="submit-btn"> Submit Booking </button>
      </form>
    </div>
  </div>

<script>
  var activityData = {};
  <% for (ACTIVITY act : clubActivities) { 
       if ("Approved".equalsIgnoreCase(act.getActivityStatus())) { %>
    activityData["<%= act.getActivityID() %>"] = {
      date: "<%= act.getActivityDate() != null ? act.getActivityDate().replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ") : "" %>"
    };
  <% } } %>

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

    document.getElementById('activityID').addEventListener('change', function() {
      var selectedId = this.value;
      var dateInput = document.getElementById('date');
      if (activityData[selectedId]) {
        dateInput.value = activityData[selectedId].date;
      } else {
        dateInput.value = '';
      }
    });
  </script>
</body>
</html> 