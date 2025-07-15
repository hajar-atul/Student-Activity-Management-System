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
  <title>Venue Booking Form</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', Arial, sans-serif;
      background: linear-gradient(135deg, #e0f2f1 0%, #b2dfdb 100%);
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

    .venue-form-container {
      background: #fff;
      max-width: 800px;
      margin: 40px auto;
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      position: relative;
    }

    .venue-form-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 6px;
      background: linear-gradient(90deg, #009688, #00796b, #004d40);
    }
    
    .venue-form-title {
      text-align: center;
      color: #fff;
      font-size: 1.8em;
      font-weight: 600;
      padding: 30px 0;
      background: linear-gradient(135deg, #009688 0%, #00796b 100%);
      margin: 0;
      letter-spacing: 0.5px;
    }

    .form-content {
      padding: 40px;
    }
    
    form {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 24px;
      background: #fff;
    }
    
    .form-group {
      display: flex;
      flex-direction: column;
    }

    .form-group.full-width {
      grid-column: 1 / -1;
    }
    
    .form-group label {
      font-weight: 600;
      margin-bottom: 8px;
      color: #263238;
      font-size: 0.95em;
      letter-spacing: 0.3px;
    }
    
    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="time"],
    .form-group select {
      padding: 14px 16px;
      border: 2px solid #e0e0e0;
      border-radius: 12px;
      font-size: 1em;
      background: #fafafa;
      font-family: 'Poppins', Arial, sans-serif;
      transition: all 0.3s ease;
      color: #333;
    }
    
    .form-group input[type="text"]:focus,
    .form-group input[type="date"]:focus,
    .form-group input[type="time"]:focus,
    .form-group select:focus {
      outline: none;
      border-color: #009688;
      background: #fff;
      box-shadow: 0 0 0 3px rgba(0, 150, 136, 0.1);
      transform: translateY(-1px);
    }

    .form-group select {
      cursor: pointer;
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
      background-position: right 12px center;
      background-repeat: no-repeat;
      background-size: 16px;
      padding-right: 40px;
    }

    .help-text {
      color: #666;
      font-size: 0.8em;
      margin-top: 4px;
      opacity: 0.8;
    }
    
    .submit-section {
      grid-column: 1 / -1;
      text-align: center;
      margin-top: 20px;
      padding-top: 20px;
      border-top: 1px solid #e0e0e0;
    }
    
    .submit-btn {
      background: linear-gradient(135deg, #009688 0%, #00796b 100%);
      color: #fff;
      border: none;
      border-radius: 12px;
      font-size: 1.1em;
      font-weight: 600;
      padding: 16px 48px;
      cursor: pointer;
      transition: all 0.3s ease;
      box-shadow: 0 8px 25px rgba(0, 150, 136, 0.3);
      letter-spacing: 0.5px;
      min-width: 200px;
      position: relative;
      overflow: hidden;
    }

    .submit-btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s;
    }
    
    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 12px 35px rgba(0, 150, 136, 0.4);
    }

    .submit-btn:hover::before {
      left: 100%;
    }
    
    .submit-btn:active {
      transform: translateY(0);
    }

    .message {
      text-align: center;
      padding: 16px 20px;
      margin-bottom: 20px;
      border-radius: 12px;
      font-weight: 500;
      font-size: 0.95em;
    }

    .message.success {
      background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
      color: #2e7d32;
      border-left: 4px solid #4caf50;
    }

    .message.error {
      background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
      color: #c62828;
      border-left: 4px solid #f44336;
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

      .venue-form-container {
        margin: 20px;
        border-radius: 16px;
      }

      .venue-form-title {
        font-size: 1.5em;
        padding: 24px 0;
      }

      .form-content {
        padding: 24px 20px;
      }

      form {
        grid-template-columns: 1fr;
        gap: 20px;
      }

      .submit-btn {
        width: 100%;
        padding: 16px 24px;
      }
    }

    @media (max-width: 480px) {
      .venue-form-container {
        margin: 16px 12px;
      }

      .form-content {
        padding: 20px 16px;
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
      <li><a href="venueBooking.jsp" class="active">VENUE BOOKING</a></li>
      <li><a href="resourceReq.jsp">RESOURCE BOOKING</a></li>
      <li><a href="clubFeedback.jsp">FEEDBACK</a></li>
      <li><a href="clubReport.jsp">REPORT</a></li>
      <li><a href="clubSettings.jsp">SETTINGS</a></li>
    </ul>
  </div>

  <div class="main-content" id="mainContent">
    <div class="header">
      <div class="header-title">VENUE BOOKING</div>
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

  <div class="venue-form-container">
      <div class="venue-form-title">Venue Booking Request</div>
      
      <div class="form-content">
    <% if (request.getParameter("message") != null) { %>
          <div class="message success">
          <%= request.getParameter("message") %>
      </div>
    <% } %>
        
    <form action="VenueBookingServlet" method="post">
      <div class="form-group">
            <label for="date">Booking Date</label>
        <input type="date" id="date" name="date" required />
            <div class="help-text">Select the date for your venue booking</div>
      </div>
          
      <div class="form-group">
            <label for="time">Start Time</label>
            <input type="time" id="time" name="time" required />
            <div class="help-text">Choose the start time for your event</div>
      </div>
          
      <div class="form-group">
            <label for="duration">Duration (Hours)</label>
            <input type="number" id="duration" name="duration" min="1" max="24" placeholder="e.g., 2" required style="font-size: 18px; padding: 18px 20px; height: 60px;" />
            <div class="help-text">Enter the duration in hours (1-24)</div>
      </div>
          
      <div class="form-group">
            <label for="venue">Select Venue</label>
        <select id="venue" name="venue" required>
              <option value="">Choose a venue...</option>
          <option value="Dewan Serbaguna">Dewan Serbaguna</option>
          <option value="Dewan Aspirasi">Dewan Aspirasi</option>
          <option value="Dewan Tengku Hassanal">Dewan Tengku Hassanal</option>
          <option value="Dewan Chanselor">Dewan Chanselor</option>
          <option value="Dewan Ibnu Battuta">Dewan Ibnu Battuta</option>
        </select>
            <div class="help-text">Select the venue for your activity</div>
          </div>
          
          <div class="submit-section">
            <button type="submit" class="submit-btn">Submit Booking Request</button>
          </div>
        </form>
      </div>
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

    // Add smooth animations for form elements
    document.addEventListener('DOMContentLoaded', function() {
      const formGroups = document.querySelectorAll('.form-group');
      formGroups.forEach((group, index) => {
        group.style.opacity = '0';
        group.style.transform = 'translateY(20px)';
        setTimeout(() => {
          group.style.transition = 'all 0.5s ease';
          group.style.opacity = '1';
          group.style.transform = 'translateY(0)';
        }, index * 100);
      });
    });
  </script>
</body>
</html> 