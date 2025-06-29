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
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden; /* Prevent page scroll */
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #e0f7fa 0%, #f0f0f0 100%);
            min-height: 100vh;
            display: flex;
        }
        .content {
            flex-grow: 1;
            padding: 100px 0 0 0;
            margin-left: 250px;
            height: 100vh;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            max-width: 500px;
            width: 100%;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            padding: 24px 24px 24px 24px;
            /* Make sure the form fits in the viewport */
            max-height: calc(100vh - 120px);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .form-header {
            text-align: center;
            margin-bottom: 18px;
        }
        .form-header img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            margin-bottom: 8px;
        }
        .form-header h1 {
            margin: 0;
            font-size: 1.3em;
            color: #008b8b;
        }
        .form-group {
            margin-bottom: 12px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 4px;
            font-size: 1em;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 1em;
            background: #e0ffff;
        }
        .form-group input[type="file"] {
            background: none;
            border: none;
        }
        .submit-btn {
            width: 100%;
            background: #008b8b;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-size: 1em;
            cursor: pointer;
            margin-top: 8px;
            transition: background 0.2s;
        }
        .submit-btn:hover {
            background: #005f5f;
        }
        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            padding: 8px;
            border-radius: 6px;
            margin-bottom: 12px;
            text-align: center;
            font-size: 0.95em;
        }
        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 8px;
            border-radius: 6px;
            margin-bottom: 12px;
            text-align: center;
            font-size: 0.95em;
        }
        @media (max-width: 900px) {
            .container {
                max-width: 95vw;
                padding: 10px;
            }
            .content {
                padding: 80px 0 0 0;
            }
        }
        @media (max-width: 600px) {
            .container {
                max-width: 100vw;
                padding: 4px;
            }
            .form-header h1 {
                font-size: 1em;
            }
            .form-group label {
                font-size: 0.95em;
            }
            .form-group input,
            .form-group select {
                font-size: 0.95em;
                padding: 6px;
            }
        }
        /* --- Sidebar/Topbar CSS from staffDashboardPage.jsp (copy as needed, but do not override .container or .form-group) --- */
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
        body.sidebar-collapsed .content {
            margin-left: 60px;
        }
        /* --- End Sidebar/Topbar CSS --- */
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
            <img src="StaffImageServlet?staffID=<%= session.getAttribute("staffID") %>" alt="Profile Picture" class="profile-icon">
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
        <div class="dashboard-title">ADD STAFF</div>
        <div class="top-icons">
            <img src="image/umpsa.png" alt="UMPSA" class="umpsa-icon">
            <button class="notification-btn" id="notificationBtn">
                <img src="image/bell.png" alt="Notification">
            </button>
            <div class="notification-dropdown" id="notificationDropdown">
                <p>No new notifications</p>
            </div>
            <img src="StaffImageServlet?staffID=<%= session.getAttribute("staffID") %>" class="profile-icon" id="profileBtn">
        </div>
    </div>
    <div class="content">
        <!-- FORM SECTION STARTS HERE (do not change this part) -->
        <div class="container">
            <div class="form-header">
                <img src="image/userIcon.png" alt="User Icon">
                <h1>Add New Staff</h1>
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
            <form action="<%= request.getContextPath() %>/AddStaffServlet" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="staffID">Staff ID:</label>
                    <input type="number" id="staffID" name="staffID" required placeholder="Enter staff ID">
                </div>
                <div class="form-group">
                    <label for="staffName">Staff Name:</label>
                    <input type="text" id="staffName" name="staffName" required placeholder="Enter full name">
                </div>
                <div class="form-group">
                    <label for="staffEmail">Staff Email:</label>
                    <input type="email" id="staffEmail" name="staffEmail" required placeholder="e.g. staff@university.edu">
                </div>
                <div class="form-group">
                    <label for="staffPhone">Staff Phone:</label>
                    <input type="tel" id="staffPhone" name="staffPhone" required placeholder="e.g. 012-3456789">
                </div>
                <div class="form-group">
                    <label for="staffDep">Staff Department:</label>
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
                <div class="form-group">
                    <label for="staffPassword">Staff Password:</label>
                    <input type="password" id="staffPassword" name="staffPassword" required placeholder="Create a password">
                </div>
                <div class="form-group">
                    <label>Profile Picture <span style='color:red'>*</span></label>
                    <input type="file" name="profilePic" accept="image/png, image/jpeg" required>
                </div>
                <button type="submit" class="submit-btn">Add Staff</button>
            </form>
        </div>
        <!-- FORM SECTION ENDS HERE -->
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