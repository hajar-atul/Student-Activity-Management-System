<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

    .activity-container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .activity-buttons {
      display: flex;
      gap: 20px;
      margin-bottom: 30px;
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

    .activity-images {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
      margin-top: 20px;
    }

    .activity-card {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      padding: 15px;
      text-align: center;
    }

    .activity-card img {
      width: 100%;
      height: 120px;
      object-fit: cover;
      border-radius: 8px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .activity-card img:hover {
      transform: scale(1.05);
      box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
    }

    .activity-card h4 {
      margin: 10px 0 5px;
      font-size: 16px;
      color: #008b8b;
    }

    .toggle-desc {
      background-color: #008b8b;
      color: white;
      border: none;
      padding: 6px 12px;
      margin-top: 10px;
      cursor: pointer;
      border-radius: 4px;
    }

    .activity-desc {
      display: none;
      margin-top: 10px;
      color: #333;
      font-size: 14px;
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
    <a href="achievements.jsp">ACHIEVEMENTS</a>
    <a href="settings.jsp">SETTINGS</a>
  </div>
  <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
    <form action="index.jsp">
      <button type="submit" class="activity-btn" style="background-color: #f44336;">Logout</button>
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
    <button class="notification-btn" id="notificationBtn">
      <img src="image/bell.png" alt="Notification">
    </button>
    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>
    <img src="image/amin.jpg" alt="Profile" class="profile-icon" id="profileBtn">
    <div class="profile-dropdown" id="profileDropdown">
      <a href="profile.jsp">My Profile</a>
      <a href="logout.jsp">Logout</a>
    </div>
  </div>
</div>

<!-- Content -->
<div class="content" id="content">
  <div class="activity-container">
    <div class="activity-buttons">
      <button class="activity-btn" onclick="location.href='currentActivityList.jsp'">Current Activity List</button>
      <button class="activity-btn" onclick="location.href='availableActivityList.jsp'">Join Activity</button>
      <button class="activity-btn" onclick="location.href='pastActivityList.jsp'">View Past Activities</button>
    </div>

    <div class="activity-images">
      <div class="activity-card">
        <img src="image/palap1.jfif" alt="Activity 1">
        <h4>ROTU Annual Camp</h4>
        <button class="toggle-desc" onclick="toggleDesc(this)">See more</button>
        <p class="activity-desc">This camp trains leadership and discipline through military-style exercises.</p>
      </div>
      <div class="activity-card">
        <img src="image/palap6.jfif" alt="Activity 2">
        <h4>Road Relay 1.0</h4>
        <button class="toggle-desc" onclick="toggleDesc(this)">See more</button>
        <p class="activity-desc">Students expose to cadet officer's training routine.</p>
      </div>
      <div class="activity-card">
        <img src="image/palap5.jfif" alt="Activity 3">
        <h4>Compass Marching</h4>
        <button class="toggle-desc" onclick="toggleDesc(this)">See more</button>
        <p class="activity-desc">This activity is one of the Jr cadet officer's training. </p>
      </div>
      <div class="activity-card">
        <img src="image/hiking.jfif" alt="Activity 4">
        <h4>Hi-Pic</h4>
        <button class="toggle-desc" onclick="toggleDesc(this)">See more</button>
        <p class="activity-desc">Rileks club's first program that attract many student involvement.</p>
      </div>
      <div class="activity-card">
        <img src="image/palap4.jfif" alt="Activity 5">
        <h4>War-cry Competition</h4>
        <button class="toggle-desc" onclick="toggleDesc(this)">See more</button>
        <p class="activity-desc">Jr, Ir and Sr cadet officer present their war dance for the prize.</p>
      </div>
      <div class="activity-card">
        <img src="image/activity6.jpg" alt="Activity 6">
        <h4>Innovation Challenge</h4>
        <button class="toggle-desc" onclick="toggleDesc(this)">See more</button>
        <p class="activity-desc">Pitch creative ideas to solve real-world problems.</p>
      </div>
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
