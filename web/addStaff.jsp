<%-- 
    Document   : addStaff
    Created on : Jun 24, 2025, 10:01:35 PM
    Author     : sema
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Staff</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body {
            height: 100%;
            overflow: hidden;
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #e6f2ff;
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
        .activity-btn {
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
        .activity-btn:hover {
            background-color: #d32f2f;
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
        .notification-dropdown {
            display: none;
            position: absolute;
            top: 80px;
            right: 40px;
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
            padding: 0;
            margin-left: 250px;
            height: 100vh;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        @media (max-width: 768px) {
            .content {
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
        .container {
            max-width: 600px;
            width: 100%;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            padding: 32px 40px 32px 40px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .form-header {
            text-align: center;
            margin-bottom: 24px;
        }
        .form-header img {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            margin-bottom: 8px;
        }
        .form-header h1 {
            margin: 0;
            font-size: 1.3em;
            color: #008b8b;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .horizontal-form {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .form-row {
            display: flex;
            align-items: center;
            gap: 18px;
        }
        .form-row label {
            flex: 0 0 160px;
            font-weight: 500;
            color: #008b8b;
            font-size: 1em;
            text-align: right;
            margin-right: 0;
        }
        .form-row input,
        .form-row select {
            flex: 1;
            padding: 12px 14px;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            background: #f8fefe;
            color: #222;
            transition: border 0.2s;
        }
        .form-row input:focus,
        .form-row select:focus {
            border: 1.5px solid #008b8b;
            outline: none;
        }
        .form-row input[type="file"] {
            background: none;
            border: none;
            padding: 0;
        }
        .submit-btn {
            width: 100%;
            background: #008b8b;
            color: #fff;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            padding: 14px 0;
            font-size: 1.08em;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.2s;
            letter-spacing: 1px;
        }
        .submit-btn:hover {
            background: #005f5f;
        }
        .message.success {
            background: #e6f9f7;
            color: #008b8b;
            border: 1px solid #b2dfdb;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 12px;
            text-align: center;
            font-size: 1em;
        }
        .message.error {
            background: #f8d7da;
            color: #c62828;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 12px;
            text-align: center;
            font-size: 1em;
        }
        @media (max-width: 700px) {
            .container {
                padding: 12px 4vw;
            }
            .form-row label {
                flex: 0 0 100px;
                font-size: 0.98em;
            }
            .form-row input, .form-row select {
                font-size: 0.98em;
            }
        }
        @media (max-width: 500px) {
            .container {
                padding: 4px 2vw;
            }
            .form-row {
                flex-direction: column;
                align-items: stretch;
                gap: 4px;
            }
            .form-row label {
                text-align: left;
                margin-bottom: 2px;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <img src="StaffImageServlet?staffID=${staffID}" alt="Profile" class="profile-pic" />
    <h2>
        <%= session.getAttribute("staffName") %><br>
        <%= session.getAttribute("staffID") %>
    </h2>
    <div class="menu">
        <a href="<%= request.getContextPath() %>/StaffDashboardServlet">DASHBOARD</a>
        <a href="<%= request.getContextPath() %>/staffBooking.jsp">BOOKING</a>
        <a href="<%= request.getContextPath() %>/StaffAdabPointServlet">ADAB POINT</a>
        <a href="<%= request.getContextPath() %>/addClub.jsp">CLUB REGISTRATION</a>
        <a href="<%= request.getContextPath() %>/addStaff.jsp">ADD STAFF</a>
    </div>
    <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
        <form action="index.jsp" method="get">
            <button type="submit" class="activity-btn">Logout</button>
        </form>
    </div>
</div>

<!-- Toggle Button -->
<button class="toggle-btn" id="toggleBtn">☰</button>

<!-- Topbar -->
<div class="topbar">
    <div class="dashboard-title">ADD STAFF</div>
    <div class="top-icons">
        <img src="image/umpsa.png" class="umpsa-icon" alt="UMPSA">
        <button class="notification-btn" id="notificationBtn">
            <img src="image/bell.png" alt="Notification">
        </button>
        <div class="notification-dropdown" id="notificationDropdown">
            <p>No new notifications</p>
        </div>
        <img src="StaffImageServlet?staffID=${staffID}" alt="Profile" class="profile-icon" id="profileBtn">
    </div>
</div>
    <div class="content">
        <!-- FORM SECTION STARTS HERE (do not change this part) -->
        <div class="container">
            <div class="form-header">
                <img src="image/userIcon.png" alt="User Icon">
                <h1 style="color: black;">Add New Staff</h1>
            </div>
            <% if (request.getParameter("success") != null) { %>
                <div class="message success">
                    New Staff Added Successfully!
                </div>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
                <div class="message error">
                    Error: <%= request.getParameter("error") %>
                </div>
            <% } %>
            <form action="<%= request.getContextPath() %>/AddStaffServlet" method="post" enctype="multipart/form-data" class="horizontal-form">
                <div class="form-row">
                    <label for="staffID" style="color: black;">Staff ID:</label>
                    <input type="number" id="staffID" name="staffID" required placeholder="Enter staff ID">
                </div>
                <div class="form-row">
                    <label for="staffName" style="color: black;">Staff Name:</label>
                    <input type="text" id="staffName" name="staffName" required placeholder="Enter full name">
                </div>
                <div class="form-row">
                    <label for="staffEmail" style="color: black;">Staff Email:</label>
                    <input type="email" id="staffEmail" name="staffEmail" required placeholder="e.g. staff@ump.edu">
                </div>
                <div class="form-row">
                    <label for="staffPhone" style="color: black;">Staff Phone:</label>
                    <input type="tel" id="staffPhone" name="staffPhone" required placeholder="e.g. 012-3456789">
                </div>
                <div class="form-row">
                    <label for="staffDep" style="color: black;">Staff Department:</label>
                    <select id="staffDep" name="staffDep" required>
                        <option value="">Select Department</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Engineering">Engineering</option>
                        <option value="Business">Business</option>
                        <option value="Arts">Arts</option>
                        <option value="Science">Science</option>
                        <option value="Medicine">Medicine</option>
                        <option value="Law">Law</option>
                        <option value="Education">Education</option>
                        <option value="Administration">Administration</option>
                    </select>
                </div>
                <div class="form-row">
                    <label for="staffPassword" style="color: black;">Staff Password:</label>
                    <input type="password" id="staffPassword" name="staffPassword" required placeholder="Create a password">
                </div>
                <div class="form-row">
                    <label style="color: black;">Profile Picture <span style='color:red'>*</span></label>
                    <input type="file" name="profilePic" accept="image/png, image/jpeg" required>
                </div>
                <button type="submit" class="submit-btn">Add Staff</button>
            </form>
        </div>
        <!-- FORM SECTION ENDS HERE -->
    </div>
    <script>
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('toggleBtn');
        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('closed');
        });
    </script>
</body>
</html>