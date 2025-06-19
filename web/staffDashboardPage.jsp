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
            padding: 20px;
            height: 100vh;
        }

        .sidebar img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            display: block;
            margin: 0 auto;
        }

        .sidebar h2 {
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
        <img src="image/staff.jpg" alt="Profile Picture">
        <h2>
            <%= session.getAttribute("studName") %><br>
            <%= session.getAttribute("studID") %>
        </h2>
        <div class="menu">
            <a href="staffDashboardPage.jsp">HOME</a>
            <a href="staffBooking.jsp">BOOKING</a>
            <a href="staffAdabPoint.jsp">ADAB POINT</a>
        </div>
    </div>
        
 <!-- Top Navigation Bar -->
    <div class="topbar">
        <div class="search-container">
            <input type="text" placeholder="Search..." />
            <button class="search-btn">X</button>
        </div>
        <div class="dashboard-title">STAFF DASHBOARD</div>
        <div class="top-icons">
            <img src="image/umpsa.png" alt="UMPSA" class="umpsa-icon">
            <button class="notification-btn" id="notificationBtn">
                <img src="image/bell.png" alt="Notification">
            </button>
            <div class="notification-dropdown" id="notificationDropdown">
                <p>No new notifications</p>
            </div>
            <img src="image/staff.jpg" alt="Profile" class="profile-icon">
        </div>
    </div>
 
    
    <div class="content">
        <!-- Welcome Card -->
        <div style="background:#fff; border-radius:16px; box-shadow:0 2px 12px rgba(0,0,0,0.07); padding:24px 40px; display:flex; align-items:center; gap:24px; max-width:900px; margin:0 auto 24px auto;">
            <img src="image/staff.jpg" alt="Staff" style="width:80px; height:80px; border-radius:50%; object-fit:cover; border:3px solid #008b8b;">
            <div style="flex:1;">
                <h2 style="margin:0 0 6px 0; font-size:1.5em; color:#008b8b;">Welcome, <%= session.getAttribute("studName") != null ? session.getAttribute("studName") : "Staff" %>!</h2>
                <p style="margin:0; color:#444;">You can review, approve, or reject club proposals and booking requests here.</p>
                 <p style="margin:0; color:#444;">You can assign ADAB evaluation to student.</p>
            </div>
        </div>
        
        <div style="display:flex; gap:24px; max-width:900px; margin:0 auto 24px auto;">
            <div style="flex:1; background:#eaf6f4; border-radius:12px; padding:24px 0; text-align:center; box-shadow:0 2px 8px rgba(0,0,0,0.04);">
                <h3 style="margin:0 0 8px 0; font-size:2em; color:#008b8b;">3</h3>
                <p style="margin:0; color:#444; font-weight:bold;">Pending Proposals</p>
            </div>
            <div style="flex:1; background:#eaf6f4; border-radius:12px; padding:24px 0; text-align:center; box-shadow:0 2px 8px rgba(0,0,0,0.04);">
                <h3 style="margin:0 0 8px 0; font-size:2em; color:#008b8b;">5</h3>
                <p style="margin:0; color:#444; font-weight:bold;">Booking Requests</p>
            </div>
            <div style="flex:1; background:#eaf6f4; border-radius:12px; padding:24px 0; text-align:center; box-shadow:0 2px 8px rgba(0,0,0,0.04);">
                <h3 style="margin:0 0 8px 0; font-size:2em; color:#008b8b;">12</h3>
                <p style="margin:0; color:#444; font-weight:bold;">Approved Bookings</p>
            </div>
        </div>
       <div style="margin-top:18px; text-align:right;">
    <a href="staffAnnouncement.jsp" style="display:inline-block; text-decoration:none; border:none; border-radius:16px; padding:8px 28px; font-weight:600; font-size:1em; background:#008b8b; color:#fff; cursor:pointer; transition:background 0.2s;">
        Create New Announcement
    </a>
</div>
    </html>