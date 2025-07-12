<%-- 
    Document   : Feedback
    Created on : Jun 9, 2025, 2:24:52 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.ACTIVITY, model.CLUB" %>
<%
    String activityID = request.getParameter("activityID");
    ACTIVITY activity = null;
    CLUB club = null;
    if (activityID != null && !activityID.isEmpty()) {
        activity = ACTIVITY.getActivityById(activityID);
        if (activity != null) {
            club = CLUB.getClubById(activity.getClubID());
        }
    }
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Activity List</title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      font-family: 'Poppins', Arial, sans-serif;
      background: linear-gradient(135deg, #e0f7fa 0%, #f0f0f0 100%);
      overflow: hidden;
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
      min-height: 100vh;
      display: flex;
      align-items: flex-start;      /* Aligns content to the top */
      justify-content: center;      /* Centers horizontally */
      margin-left: 0;
      padding-top: 100px;           /* Pushes content below the header */
      background: none;
    }

    .sidebar.closed ~ .content {
      margin-left: 0;
    }

    /* Feedback Section */
    .feedback-form-wrapper {
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      background: none;
    }
    .feedback-card {
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 8px 32px rgba(0,121,107,0.10);
      padding: 48px 60px;
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: stretch;
      gap: 40px;
      margin-top: 0;
    }
    .form-horizontal {
      display: flex;
      flex-direction: row;
      gap: 32px;
      width: 100%;
      align-items: flex-start;
      justify-content: center;
    }
    
    .activity-box {
      background: #f8fdfc;
      border: 1.5px solid #e0e0e0;
      border-radius: 8px;
      padding: 14px 16px;
      font-size: 1em;
      color: #333;
      text-align: left;
      margin-bottom: 0;
      font-weight: 500;
      outline: none;
      transition: border 0.2s;
    }
    
    .activity-box:focus {
      border-color: #008b8b;
    }
    .form-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
      min-width: 180px;
      flex: 1 1 0;
      margin-bottom: 0;
    }
    
    .form-field-box {
      background: #f8fdfc;
      border: 1.5px solid #e0e0e0;
      border-radius: 8px;
      padding: 14px 16px;
      margin-bottom: 0;
      font-size: 1em;
      color: #222;
      font-family: inherit;
      width: 100%;
      box-sizing: border-box;
      outline: none;
      transition: border 0.2s;
    }
    
    .form-field-box:focus {
      border-color: #008b8b;
    }
    

    .feedback-card label {
      font-weight: 500;
      color: #00796B;
      font-size: 15px;
      margin-bottom: 2px;
      letter-spacing: 0.2px;
    }
    .star-rating {
      display: flex;
      flex-direction: row;
      font-size: 2.5em;
      margin-bottom: 0;
      margin-top: 2px;
      cursor: pointer;
      user-select: none;
      justify-content: center;
      align-items: center;
      gap: 6px;
    }
    .star {
      color: #b2dfdb;
      transition: color 0.2s;
      font-size: 1.1em;
    }
    .star.selected, .star.hovered {
      color: #ffb400;
    }
    .feedback-card button[type="submit"] {
      background: linear-gradient(90deg, #009688 0%, #00796B 100%);
      color: #fff;
      border: none;
      border-radius: 12px;
      font-size: 1.35em;
      font-weight: 700;
      padding: 22px 0;
      width: 320px;
      max-width: 100%;
      cursor: pointer;
      transition: background 0.2s, box-shadow 0.2s, transform 0.15s;
      margin: 36px auto 0 auto;
      display: block;
      box-shadow: 0 6px 24px rgba(0,150,136,0.13);
      letter-spacing: 1px;
      text-align: center;
    }
    .feedback-card button[type="submit"]:hover {
      background: linear-gradient(90deg, #00796B 0%, #009688 100%);
      box-shadow: 0 12px 32px rgba(0,150,136,0.18);
      transform: translateY(-2px) scale(1.04);
    }
    
    .star-rating {
      display: flex;
      flex-direction: row;
      font-size: 2.5em;
      margin-bottom: 0;
      margin-top: 2px;
      cursor: pointer;
      user-select: none;
      justify-content: center;
      align-items: center;
      gap: 6px;
    }
    .star {
      color: #b2dfdb;
      transition: color 0.2s;
      font-size: 1.1em;
    }
    .star.selected, .star.hovered {
      color: #ffb400;
    }
    .feedback-card textarea.form-field-box {
      min-height: 110px;
      resize: vertical;
    }
    @media (max-width: 900px) {
      .feedback-form-wrapper { max-width: 98vw; }
      .feedback-card { 
        padding: 28px 8vw 24px 8vw; 
      }
      .form-horizontal {
        flex-direction: column;
        gap: 20px;
      }
    }
    @media (max-width: 600px) {
      .feedback-card { 
        padding: 16px 2vw 12px 2vw; 
      }
      .form-horizontal {
        flex-direction: column;
        gap: 15px;
      }
      .activity-box { padding: 12px 6px; font-size: 1em; }
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

    <!-- Logout button fixed at the bottom -->
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
    <div class="dashboard-title">ACTIVITIES</div>
    <div class="top-icons">
      <img src="image/umpsa.png" class="umpsa-icon" alt="UMPSA">
      <button class="notification-btn" id="notificationBtn" aria-label="Toggle Notifications">
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
    <div class="feedback-form-wrapper">
      <% if (message != null) { %>
        <div style="background:#e0ffe0; color:#00796b; border:1.5px solid #009b9d; border-radius:8px; padding:10px 16px; margin-bottom:24px; text-align:center; font-weight:bold; max-width:600px; width:100%; margin-left:auto; margin-right:auto;">
          Feedback submitted.
        </div>
      <% } %>
      <form class="feedback-card" action="FeedbackServlet" method="post">
        <h2 style="text-align: center; color: #00796B; margin-bottom: 8px; font-size: 1.5em; font-weight: 600; letter-spacing: 0.5px;">Activity Feedback</h2>
        
        <% if (activity != null && club != null) { %>
          <div class="form-horizontal">
            <div class="form-group">
              <label>Activity Name</label>
              <input type="text" value="<%= activity.getActivityName() %>" readonly class="activity-box" />
              <input type="hidden" name="activityID" value="<%= activityID %>" />
            </div>
            
            <div class="form-group">
              <label>Organizer</label>
              <input type="text" value="<%= club.getClubName() %>" readonly class="form-field-box" />
              <input type="hidden" name="clubID" value="<%= club.getClubId() %>" />
            </div>
          </div>
          
          <div class="form-horizontal">
            <div class="form-group">
              <label>Rate Activity</label>
              <div class="form-field-box" style="background:#fffbe7; display:flex; align-items:center; justify-content:center; gap:10px;">
                <div class="star-rating" id="starRating">
                  <span class="star" data-value="1">&#9733;</span>
                  <span class="star" data-value="2">&#9733;</span>
                  <span class="star" data-value="3">&#9733;</span>
                  <span class="star" data-value="4">&#9733;</span>
                  <span class="star" data-value="5">&#9733;</span>
                </div>
              </div>
              <input type="hidden" name="rating" id="ratingInput" value="0">
            </div>
            
            <div class="form-group">
              <label for="comments">Comments</label>
              <textarea id="comments" name="comments" placeholder="Share your experience and suggestions..." required class="form-field-box"></textarea>
            </div>
          </div>
          
          <button type="submit">Submit Feedback</button>
        <% } else { %>
          <div style="color:#b71c1c; font-weight:bold; text-align: center; width: 100%;">Invalid activity. Please return to your activity list.</div>
        <% } %>
      </form>
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

    // Interactive star rating
    const stars = document.querySelectorAll('.star-rating .star');
    const ratingInput = document.getElementById('ratingInput');
    let selectedRating = 0;
    stars.forEach((star, idx) => {
      star.addEventListener('mouseover', () => {
        stars.forEach((s, i) => {
          s.classList.toggle('hovered', i <= idx);
        });
      });
      star.addEventListener('mouseout', () => {
        stars.forEach((s, i) => {
          s.classList.toggle('hovered', false);
        });
      });
      star.addEventListener('click', () => {
        selectedRating = idx + 1;
        ratingInput.value = selectedRating;
        stars.forEach((s, i) => {
          s.classList.toggle('selected', i < selectedRating);
        });
      });
    });
  </script>

</body>
</html>

