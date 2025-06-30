<%-- 
    Document   : Feedback
    Created on : Jun 9, 2025, 2:24:52 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
      align-items: center;
      justify-content: center;
      margin-left: 0;
      padding: 0;
    }

    .sidebar.closed ~ .content {
      margin-left: 0;
    }

    /* Feedback Section */
    .feedback-card {
      background: #fff;
      border-radius: 24px;
      box-shadow: 0 2px 16px rgba(0,0,0,0.08);
      padding: 36px 32px 32px 32px;
      max-width: 400px;
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 18px;
    }

    .feedback-card h1 {
      color: #009b9d;
      font-size: 2em;
      font-weight: bold;
      margin-bottom: 10px;
      text-align: center;
    }

    .feedback-card label {
      font-weight: bold;
      color: #009b9d;
      margin-bottom: 6px;
      align-self: flex-start;
      font-size: 1.1em;
    }

    .feedback-card select, .feedback-card textarea {
      width: 100%;
      padding: 10px;
      border-radius: 8px;
      border: 1px solid #b2dfdb;
      background: #e0ffff;
      font-size: 1em;
      margin-bottom: 10px;
      font-family: inherit;
    }

    .feedback-card textarea {
      min-height: 70px;
      resize: none;
    }

    .star-rating {
      display: flex;
      flex-direction: row;
      font-size: 2.2em;
      margin-bottom: 10px;
      cursor: pointer;
      user-select: none;
    }

    .star {
      color: #ccc;
      transition: color 0.2s;
    }

    .star.selected, .star.hovered {
      color: #ffb400;
    }

    .feedback-card button[type="submit"] {
      width: 100%;
      background: #009b9d;
      color: #fff;
      font-weight: bold;
      border: none;
      border-radius: 10px;
      padding: 14px 0;
      font-size: 1.2em;
      margin-top: 10px;
      cursor: pointer;
      transition: background 0.2s;
    }

    .feedback-card button[type="submit"]:hover {
      background: #00796b;
    }

    @media (max-width: 600px) {
      .feedback-card {
        padding: 18px 6px 18px 6px;
        max-width: 98vw;
      }
      .feedback-card h1 {
        font-size: 1.3em;
      }
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
    <div class="search-container">
      <input type="text" placeholder="Search..." />
      <button class="search-btn">X</button>
    </div>
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
    <form class="feedback-card" action="FeedbackServlet" method="post">
      <h1>Activity Feedback</h1>
      <label for="club">Select Club</label>
      <select id="club" name="club" required>
        <option value="">-- Select Club --</option>
        <!-- TODO: Populate with club options from backend -->
      </select>
      <label for="activity">Select Activity</label>
      <select id="activity" name="activity" required>
        <option value="">-- Select Activity --</option>
        <!-- TODO: Populate with activity options from backend -->
      </select>
      <label>Rate Activity</label>
      <div class="star-rating" id="starRating">
        <span class="star" data-value="1">&#9733;</span>
        <span class="star" data-value="2">&#9733;</span>
        <span class="star" data-value="3">&#9733;</span>
        <span class="star" data-value="4">&#9733;</span>
        <span class="star" data-value="5">&#9733;</span>
      </div>
      <input type="hidden" name="rating" id="ratingInput" value="0">
      <label for="comments">Comments</label>
      <textarea id="comments" name="comments" placeholder="Your feedback..." required></textarea>
      <button type="submit">Submit Feedback</button>
    </form>
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

