<%-- 
    Document   : staffDashboardPage
    Created on : Jun 17, 2025, 6:02:34 PM
    Author     : semaaa
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            background-color: #f0f0f0;
        }

        .sidebar {
            width: 250px;
            background-color: #008b8b;
            color: white;
            padding: 20px 0 0 0;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            transition: width 0.3s;
            z-index: 2001;
        }

        .sidebar.collapsed {
            width: 60px;
            padding-left: 0;
            padding-right: 0;
        }

        .sidebar.collapsed .sidebar-header h2,
        .sidebar.collapsed .sidebar-header img,
        .sidebar.collapsed .menu,
        .sidebar.collapsed form {
            display: none;
        }

        .sidebar-header {
            position: relative;
            margin-bottom: 18px;
        }

        #sidebarToggle {
            margin-top: 4px;
            margin-bottom: 4px;
            z-index: 2002;
            width: 28px;
            height: 28px;
            left: 8px;
            top: 8px;
            padding: 0;
        }

        #sidebarToggle span {
            display: block;
            width: 20px;
            height: 3px;
            background: #fff;
            margin: 4px 0;
            border-radius: 2px;
        }

        .sidebar-header img.profile-icon {
            width: 110px;
            height: 110px;
            margin-top: 18px;
            border-radius: 50%;
            object-fit: cover;
        }

        .sidebar-header h2 {
            margin-top: 8px;
            font-size: 1.1em;
        }

        .menu {
            margin-top: 10px;
        }

        .menu a {
            display: block;
            padding: 6px 0;
            background-color: #0a6d6d;
            margin: 8px 24px 0 24px;
            text-decoration: none;
            color: white;
            border-radius: 6px;
            text-align: center;
            font-size: 1em;
            height: 38px;
            line-height: 24px;
            transition: background 0.2s;
        }

        .menu a:hover {
            background-color: #007b7b;
        }

        .sidebar form {
            position: absolute;
            bottom: 60px;
            left: 0;
            width: 100%;
            padding: 0;
            display: flex;
            justify-content: center;
        }

        .sidebar form button {
            width: 90%;
            background: #c0392b;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            padding: 0;
            height: 44px;
            font-size: 1.1em;
            cursor: pointer;
            margin-bottom: 0;
            transition: background 0.2s;
            display: block;
        }

        .sidebar form button:hover {
            background: #a93226;
        }

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
            transition: left 0.3s;
        }

        body.sidebar-collapsed .topbar {
            left: 60px;
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

        .top-icons img.umpsa-icon {
            width: 36px;
            height: 36px;
        }

        .notification-btn img {
            width: 32px;
            height: 32px;
        }

        .profile-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

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

        .content {
            flex-grow: 1;
            padding: 100px 40px 40px 40px;
            margin-left: 250px;
            transition: margin-left 0.3s;
        }

        body.sidebar-collapsed .content {
            margin-left: 60px;
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
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header" style="text-align:center; position:relative;">
            <button id="sidebarToggle" style="background:none; border:none; position:absolute; left:8px; top:8px; cursor:pointer; outline:none; width:28px; height:28px; padding:0;">
                <span></span>
                <span></span>
                <span></span>
            </button>
            <img src="StaffImageServlet?staffID=${staffID}" alt="Profile Picture" class="profile-icon" id="profileBtn">
            <h2 style="margin-top:8px;">
                <%= session.getAttribute("staffName") %><br>
                <%= session.getAttribute("staffID") %>
            </h2>
        </div>
        <div class="menu">
            <a href="<%= request.getContextPath() %>/StaffDashboardServlet">HOME</a>
            <a href="<%= request.getContextPath() %>/staffBooking.jsp">BOOKING</a>
            <a href="<%= request.getContextPath() %>/staffAdabPoint.jsp">ADAB POINT</a>
            <a href="<%= request.getContextPath() %>/addClub.jsp">CLUB REGISTRATION</a>
            <a href="<%= request.getContextPath() %>/addStaff.jsp">ADD STAFF</a>
        </div>
        <form action="index.jsp" method="get">
            <button type="submit">Logout</button>
        </form>
    </div>
        
 <!-- Top Navigation Bar -->
    <div class="topbar">
        <div class="dashboard-title">STAFF DASHBOARD</div>
        <div class="top-icons">
            <img src="image/umpsa.png" alt="UMPSA" class="umpsa-icon">
            <button class="notification-btn" id="notificationBtn">
                <img src="image/bell.png" alt="Notification">
            </button>
            <div class="notification-dropdown" id="notificationDropdown">
                <p>No new notifications</p>
            </div>
            <img src="StaffImageServlet?staffID=${staffID}" class="profile-icon" id="profileBtn">
        </div>
    </div>
 
    
    <div class="content">
        <!-- Error Message Display -->
        <% if (request.getAttribute("dashboardError") != null) { %>
            <div style="background:#ffdddd; border:1px solid #ff0000; color:#d8000c; padding:15px; margin:0 auto 24px auto; max-width:900px; border-radius:8px;">
                <strong>Error:</strong> <%= request.getAttribute("dashboardError") %>
            </div>
        <% } %>
    
        <!-- Welcome Card -->
        <div style="background:#fff; border-radius:16px; box-shadow:0 2px 12px rgba(0,0,0,0.07); padding:24px 40px; display:flex; align-items:center; gap:24px; max-width:900px; margin:0 auto 24px auto;">
            <img src="StudentImageServlet?studID=${studID}" alt="Staff" class="profile-icon" id="profileBtn" style="width:80px; height:80px; border-radius:50%; object-fit:cover; border:3px solid #008b8b;">
            <div style="flex:1;">
                <h2 style="margin:0 0 6px 0; font-size:1.5em; color:#008b8b;">Welcome, <%= session.getAttribute("staffName") != null ? session.getAttribute("staffName") : "Staff" %>!</h2>
                <p style="margin:0; color:#444;">You can review, approve, or reject club proposals and booking requests here.</p>
                 <p style="margin:0; color:#444;">You can assign ADAB evaluation to student.</p>
            </div>
        </div>
        
        <div style="display:flex; gap:24px; max-width:900px; margin:0 auto 24px auto;">
            <div style="flex:1; background:#eaf6f4; border-radius:12px; padding:24px 0; text-align:center; box-shadow:0 2px 8px rgba(0,0,0,0.04);">
                <h3 style="margin:0 0 8px 0; font-size:2em; color:#008b8b;"><%= request.getAttribute("bookingRequests") != null ? request.getAttribute("bookingRequests") : "0" %></h3>
                <p style="margin:0; color:#444; font-weight:bold;">Booking Requests</p>
            </div>
            <div style="flex:1; background:#eaf6f4; border-radius:12px; padding:24px 0; text-align:center; box-shadow:0 2px 8px rgba(0,0,0,0.04);">
                <h3 style="margin:0 0 8px 0; font-size:2em; color:#008b8b;"><%= request.getAttribute("approvedBookings") != null ? request.getAttribute("approvedBookings") : "0" %></h3>
                <p style="margin:0; color:#444; font-weight:bold;">Approved Bookings</p>
            </div>
        </div>
    </div>

    <script>
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('sidebarToggle');
        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            document.body.classList.toggle('sidebar-collapsed');
        });
    </script>
</body>
</html>