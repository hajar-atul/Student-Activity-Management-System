<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register New Club</title>
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
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin-left: 250px;
            transition: margin-left 0.3s;
        }
        body.sidebar-collapsed .main-content {
            margin-left: 60px;
        }
        @media (max-width: 768px) {
            .main-content {
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
            width: 100%;
            max-width: 600px;
            background: #fff;
            padding: 30px 40px 40px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        }
        h2 {
            text-align: center;
            color: white;
            margin-bottom: 30px;
        }
        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 18px;
        }
        .form-row label {
            font-weight: bold;
            width: 180px;
            margin: 0;
            text-align: right;
            margin-right: 18px;
        }
        .form-row input[type="text"],
        .form-row input[type="email"],
        .form-row input[type="password"],
        .form-row textarea {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: #e0ffff;
            font-size: 1em;
        }
        .form-row textarea {
            resize: vertical;
            min-height: 70px;
        }
        .form-row input[readonly] {
            background: #f0f0f0;
        }
        .button {
            width: 100%;
            padding: 12px;
            background-color: #007b7b;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            margin-top: 25px;
            cursor: pointer;
            font-size: 1em;
        }
        .button:hover {
            background-color: #005f5f;
        }
        .error {
            color: red;
            margin-bottom: 15px;
            text-align: center;
        }
        .success {
            color: green;
            margin-bottom: 15px;
            text-align: center;
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
    <div class="dashboard-title">REGISTER NEW CLUB</div>
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

    <div class="main-content">
        <div class="container">
            <h2>Register New Club</h2>
            <% if (request.getParameter("error") != null) { %>
                <div class="error"><%= request.getParameter("error") %></div>
            <% } %>
            <% if (request.getParameter("success") != null) { %>
                <div class="success">
                    <%= request.getParameter("success") %><br/>
                    <% if (request.getParameter("clubID") != null && request.getParameter("clubPassword") != null) { %>
                        <strong>Club ID:</strong> <%= request.getParameter("clubID") %><br/>
                        <strong>Club Password:</strong> <%= request.getParameter("clubPassword") %>
                    <% } %>
                </div>
            <% } %>
            <form action="AddClubServlet" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <label for="clubName">Club Name<span style="color:red">*</span>:</label>
                    <input type="text" id="clubName" name="clubName" required>
                </div>
                <div class="form-row">
                    <label for="clubDesc">Club Description<span style="color:red">*</span>:</label>
                    <textarea id="clubDesc" name="clubDesc" required></textarea>
                </div>
                <div class="form-row">
                    <label for="clubEstablishedDate">Established Date<span style="color:red">*</span>:</label>
                    <input type="text" id="clubEstablishedDate" name="clubEstablishedDate" value="<%= LocalDate.now() %>" readonly required>
                </div>
                <div class="form-row">
                    <label for="clubContact">Club Contact (Email)<span style="color:red">*</span>:</label>
                    <input type="email" id="clubContact" name="clubContact" required>
                </div>
                <div class="form-row">
                    <label for="clubPassword">Club Password<span style="color:red">*</span>:</label>
                    <input type="password" id="clubPassword" name="clubPassword" required>
                </div>
                <div class="form-row">
                    <label>Profile Picture <span style='color:red'>*</span></label>
                    <input type="file" name="profilePic" accept="image/png, image/jpeg" required>
                </div>
                <button type="submit" class="button">Register Club</button>
            </form>
        </div>
    </div>

<script>
    const sidebar = document.getElementById('sidebar');
    const toggleBtn = document.getElementById('toggleBtn');
    toggleBtn.addEventListener('click', function() {
        sidebar.classList.toggle('closed');
        document.body.classList.toggle('sidebar-collapsed');
    });
</script>
</body>
</html> 