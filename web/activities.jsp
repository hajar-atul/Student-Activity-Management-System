<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.ACTIVITY, model.CLUB" %>
<%
    // Get approved activities from database
    List<ACTIVITY> allApprovedActivities = ACTIVITY.getAvailableUpcomingActivities();
    
    // Filter activities that have poster images
    List<ACTIVITY> approvedActivities = new java.util.ArrayList<ACTIVITY>();
    if (allApprovedActivities != null) {
        for (ACTIVITY activity : allApprovedActivities) {
            if (activity.getPosterImage() != null && activity.getPosterImage().length > 0) {
                approvedActivities.add(activity);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Activity Page</title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet" />
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
      overflow: hidden;
      transition: margin-left 0.3s ease;
    }

    .sidebar.closed ~ .content {
      margin-left: 0;
    }

    .activity-container {
      max-width: 1500px;
      margin: 0 auto;
      min-height: 400px;
      max-height: 800px;
      height: auto;
      overflow: visible;
    }

    .activity-buttons {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
    }

    .activity-btn {
      flex: 1;
      padding: 15px;
      background-color: #008b8b;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    .activity-btn:hover {
      background-color: #006d6d;
    }

    .activity-images-container {
      width: 100%;
      max-width: 100%;
      height: calc(100% - 80px);
      overflow-x: auto;
      overflow-y: hidden;
      scroll-behavior: smooth;
      -webkit-overflow-scrolling: touch;
      padding-bottom: 12px;
      box-sizing: border-box;
      margin-top: 20px;
    }

    .activity-images-container::-webkit-scrollbar {
      height: 8px;
    }

    .activity-images-container::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 4px;
    }

    .activity-images-container::-webkit-scrollbar-thumb {
      background: #008b8b;
      border-radius: 4px;
    }

    .activity-images-container::-webkit-scrollbar-thumb:hover {
      background: #006d6d;
    }

    .activity-images {
      display: flex;
      gap: 30px;
      padding: 10px 0;
      width: 100%;
      max-width: 100%;
    }
    .activity-card {
      min-width: 370px;
      max-width: 370px;
      display: flex;
      flex-direction: column;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
      padding: 20px;
      text-align: center;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      min-height: 450px;
      max-height: 480px;
      margin-bottom: 8px;
      position: relative;
      flex-shrink: 0;
      box-sizing: border-box;
    }

    .activity-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0,0,0,0.2);
    }

    .activity-card img {
      width: auto;
      max-width: 100%;
      height: 250px;
      object-fit: contain;
      border-radius: 10px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      margin-bottom: 15px;
      background-color: #f5f5f5;
    }

    .activity-card img:hover {
      transform: scale(1.05);
      box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
    }

    .activity-card h4 {
      margin: 10px 0 5px;
      font-size: 16px;
      color: #008b8b;
      font-weight: 600;
    }
    
    .activity-card p {
      margin: 5px 0;
      line-height: 1.4;
    }

    .toggle-desc {
      background-color: #008b8b;
      color: white;
      border: none;
      padding: 6px 18px;
      cursor: pointer;
      border-radius: 4px;
      margin-top: 10px;
      margin-bottom: 0;
      position: static;
      transform: none;
      left: auto;
      bottom: auto;
      z-index: auto;
    }

    .activity-desc {
      display: none;
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 80px;
      background: rgba(255, 255, 255, 0.95);
      color: #333;
      font-size: 14px;
      line-height: 1.5;
      text-align: left;
      padding: 20px;
      border-radius: 12px 12px 0 0;
      overflow-y: auto;
      z-index: 10;
    }
    
    .activity-desc p {
      margin: 8px 0;
    }
    
    .activity-desc strong {
      color: #008b8b;
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
      .activity-images {
        gap: 20px;
      }
      
      .activity-card img {
        height: 200px;
      }
      
      .activity-card {
        padding: 15px;
      }
      
      .content {
        padding: 100px 15px 20px 15px;
        margin-left: 0;
      }
      
      .sidebar {
        position: static;
        width: 100%;
        height: auto;
      }
      
      .toggle-btn {
        display: block;
      }
    }
    
    @media (max-width: 480px) {
      .activity-card img {
        height: 180px;
      }
      
      .activity-buttons {
        flex-direction: column;
        gap: 10px;
      }
      
      .activity-btn {
        padding: 12px;
        font-size: 14px;
      }
    }
    .activities-outer-container {
      position: relative;
      overflow-x: auto;
      overflow-y: hidden;
      white-space: nowrap;
      padding-bottom: 24px;
      width: 100%;
      max-width: 100vw;
      box-sizing: border-box;
      background: #fff;
      border-radius: 22px;
      box-shadow: 0 8px 32px rgba(0,121,107,0.10);
      padding: 36px 32px 28px 32px;
      margin: 20px auto 0 auto;
      min-width: 400px;
      min-height: 300px;
      height: auto;
    }
    .activities-outer-container::after {
      content: "";
      display: block;
      position: absolute;
      left: 16px;
      right: 16px;
      bottom: 0;
      height: 4px;
      background: #008b8b;
      border-radius: 2px;
      pointer-events: none;
      z-index: 2;
    }
    .activities-grid {
      display: flex;
      flex-direction: row;
      gap: 15px;
      min-width: max-content;
      width: fit-content;
      padding: 10px 0;
    }
    .activities-grid::-webkit-scrollbar {
      height: 8px;
    }
    .activities-grid::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 4px;
    }
    .activities-grid::-webkit-scrollbar-thumb {
      background: #008b8b;
      border-radius: 4px;
    }
    .activities-grid::-webkit-scrollbar-thumb:hover {
      background: #006d6d;
    }
    .activity-card {
      min-width: 280px;
      max-width: 280px;
      background: #fff;
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      padding: 12px;
      display: flex;
      flex-direction: column;
      flex-shrink: 0;
      box-sizing: border-box;
      margin-bottom: 0;
    }
    .scroll-indicator {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      background: rgba(0, 139, 139, 0.8);
      color: white;
      padding: 8px 12px;
      border-radius: 20px;
      font-size: 12px;
      pointer-events: none;
      opacity: 0;
      transition: opacity 0.3s;
      z-index: 10;
    }
    .activities-outer-container:hover .scroll-indicator {
      opacity: 1;
    }
    .activity-btnn {
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
             .activity-btnn:hover {
                background-color: #d32f2f;
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

  <!-- ✅ Logout button fixed at the bottom -->
  <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
    <form action="index.jsp">
        <button type="submit" class="activity-btnn">Logout</button>
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
    </div>
  </div>
</div>

<!-- Content -->
<div class="content" id="content">
  <div class="activity-container">
    <div class="activity-buttons">
      <button class="activity-btn" onclick="location.href='CurrentServlet'">Current Activity List</button>
      <button class="activity-btn" onclick="location.href='PastServlet'">View Past Activities</button>
    </div>

    <div class="activities-outer-container">
      <div class="activity-images-container">
        <div class="activity-images">
          <% if (approvedActivities != null && !approvedActivities.isEmpty()) { %>
            <% for (ACTIVITY activity : approvedActivities) { 
                CLUB club = CLUB.getClubById(activity.getClubID());
                String clubName = (club != null) ? club.getClubName() : "Unknown Club";
            %>
              <div class="activity-card">
                <img src="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=poster" alt="<%= activity.getActivityName() %>">
                <h4><%= activity.getActivityName() %></h4>
                <p style="color: #666; font-size: 12px; margin: 5px 0;">by <%= clubName %></p>
                <p style="color: #008b8b; font-size: 12px; margin: 5px 0;">📅 <%= activity.getActivityDate() %></p>
                <p style="color: #008b8b; font-size: 12px; margin: 5px 0;">📍 <%= activity.getActivityVenue() != null ? activity.getActivityVenue() : "TBA" %></p>
                <button class="toggle-desc" onclick="toggleDesc(this)">See more</button>
                <div class="activity-desc">
                  <p><strong>Description:</strong> <%= activity.getActivityDesc() != null ? activity.getActivityDesc() : "No description available." %></p>
                  <p><strong>Type:</strong> <%= activity.getActivityType() != null ? activity.getActivityType() : "General" %></p>
                  <p><strong>Adab Points:</strong> <%= activity.getAdabPoint() %> points</p>
                  <a href="registerActivity.jsp?activityID=<%= activity.getActivityID() %>" style="background: #008b8b; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin-top: 10px;">Join Activity</a>
                </div>
              </div>
            <% } %>
          <% } else { %>
            <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666;">
              <h3>No Approved Activities Available</h3>
              <p>Check back later for new activities or contact your club administrators.</p>
            </div>
          <% } %>
        </div>
      </div>
      <div class="scroll-indicator">Scroll for more activities →</div>
    </div>
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

  function toggleDesc(button) {
    const desc = button.nextElementSibling;
    const isVisible = desc.style.display === 'block';
    desc.style.display = isVisible ? 'none' : 'block';
    button.textContent = isVisible ? 'See more' : 'See less';
  }
</script>

</body>
</html>
