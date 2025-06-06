<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            background-color: #f0f0f0;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #008b8b;
            color: white;
            padding: 20px;
            height: 100vh;
        }

        .sidebar img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            display: block;
            margin: 0 auto;
        }

        .sidebar h3 {
            text-align: center;
            font-size: 14px;
            margin: 10px 0 0;
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

        /* Topbar */
        .topbar {
            position: fixed;
            top: 0;
            left: 250px;
            right: 0;
            height: 60px;
            background-color: #008b8b;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            z-index: 1000;
        }

        .search-container {
            display: flex;
            align-items: center;
            margin-left: 30px;
        }

        .search-container input {
            padding: 6px 10px;
            border-radius: 20px;
            border: none;
            outline: none;
            width: 180px;
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
            font-size: 22px;
            font-weight: bold;
            flex-grow: 1;
            text-align: center;
            margin-left: 50px;
        }

        .top-icons {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .top-icons img {
            width: 24px;
            height: 24px;
        }

        .profile-icon {
            width: 32px;
            height: 32px;
            border-radius: 50%;
        }

        /* Notification Dropdown */
        .notification-dropdown {
            display: none;
            position: absolute;
            top: 50px;
            right: 50px;
            background: white;
            min-width: 250px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            z-index: 2000;
            padding: 10px 0;
            border-radius: 8px;
            color: #333;
        }
        .notification-dropdown.show {
            display: block;
        }
        .notification-dropdown p {
            margin: 0;
            padding: 10px 20px;
            border-bottom: 1px solid #eee;
        }
        .notification-dropdown p:last-child {
            border-bottom: none;
        }
        .notification-btn {
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
            position: relative;
        }

        /* Content */
        .content {
            flex-grow: 1;
            padding: 100px 40px 40px 40px; /* top padding to avoid topbar overlap */
            margin-left: 250px;
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
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <img src="user.png" alt="Profile Picture">
        <h3><%= request.getAttribute("name") %><br><%= request.getAttribute("studentId") %></h3>
        <div class="menu">
            <a href="#">DASHBOARD</a>
            <a href="#">ACTIVITIES</a>
            <a href="#">CLUBS</a>
            <a href="#">ACHIEVEMENTS</a>
            <a href="#">SETTINGS</a>
        </div>
    </div>

    <!-- Top Navigation Bar -->
    <div class="topbar">
        <div class="search-container">
            <input type="text" placeholder="Search..." />
            <button class="search-btn">X</button>
        </div>
        <div class="dashboard-title">DASHBOARD</div>
        <div class="top-icons">
            <img src="shield.png" alt="Shield">
            <button class="notification-btn" id="notificationBtn">
                <img src="bell.png" alt="Notification">
            </button>
            <div class="notification-dropdown" id="notificationDropdown">
                <p>No new notifications</p>
                <!-- Example notification: <p>New event: Coding Competition!</p> -->
            </div>
            <img src="user.png" alt="Profile" class="profile-icon">
        </div>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h1>Welcome, <%= request.getAttribute("name") %></h1>
        <div class="profile-box">
            <h2>STUDENT PROFILE</h2>
            <table>
                <tr><td>STUDENTID</td><td><%= request.getAttribute("studentId") %></td></tr>
                <tr><td>NAME</td><td><%= request.getAttribute("name") %></td></tr>
                <tr><td>DATE OF BIRTH</td><td><%= request.getAttribute("dob") %></td></tr>
                <tr><td>PROGRAMME</td><td><%= request.getAttribute("programme") %></td></tr>
                <tr><td>MOBILE NUMBER</td><td><%= request.getAttribute("mobileNumber") %></td></tr>
                <tr><td>CURRENT EMAIL</td><td><%= request.getAttribute("email") %></td></tr>
                <tr><td>MUET STATUS</td><td><%= request.getAttribute("muetStatus") %></td></tr>
                <tr><td>ADVISOR</td><td><%= request.getAttribute("advisor") %></td></tr>
            </table>
        </div>
    </div>

    <script>
        const notificationBtn = document.getElementById('notificationBtn');
        const notificationDropdown = document.getElementById('notificationDropdown');

        notificationBtn.addEventListener('click', function(event) {
            event.stopPropagation();
            notificationDropdown.classList.toggle('show');
        });

        // Hide dropdown when clicking outside
        window.addEventListener('click', function(event) {
            if (!notificationDropdown.contains(event.target) && !notificationBtn.contains(event.target)) {
                notificationDropdown.classList.remove('show');
            }
        });
    </script>
</body>
</html>
