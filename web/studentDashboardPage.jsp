<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet">
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
            overflow-y: auto;
            transition: margin-left 0.3s ease;
        }

        .sidebar.closed ~ .content {
            margin-left: 0;
        }

        .content h1 {
            font-size: 24px;
            color: #0a6d6d;
        }

        .profile-box {
            background-color: #b3e0e0;
            padding: 20px;
            border-radius: 10px;
            width: 650px;
        }

        .profile-box h2 {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .profile-box table {
            width: 100%;
            border-collapse: collapse;
        }

        .profile-box td {
            padding: 10px;
        }

        .profile-box td:first-child {
            font-weight: bold;
            width: 200px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .content {
                margin-left: 0;
            }
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
        <div class="dashboard-title">DASHBOARD</div>
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
        <h1>Welcome, <%= session.getAttribute("studName") %></h1>
        <div class="profile-box">
            <h2>STUDENT PROFILE</h2>
            <table>
                <tr><td>STUDENT ID</td><td><%= session.getAttribute("studID") %></td></tr>
                <tr><td>NAME</td><td><%= session.getAttribute("studName") %></td></tr>
                <tr><td>DATE OF BIRTH</td><td><%= session.getAttribute("dob") %></td></tr>
                <tr><td>PROGRAM</td><td><%= session.getAttribute("studCourse") %></td></tr>
                <tr><td>MOBILE NUMBER</td><td><%= session.getAttribute("studNoPhone") %></td></tr>
                <tr><td>CURRENT EMAIL</td><td><%= session.getAttribute("studEmail") %></td></tr>
                <tr><td>MUET STATUS</td><td><%= session.getAttribute("muetStatus") %></td></tr>
                <tr><td>ADVISOR</td><td><%= session.getAttribute("advisor") %></td></tr>
            </table>
        </div>
    </div>

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
    </script>
</body>
</html>
