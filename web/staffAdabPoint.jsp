<%-- 
    Document   : staffAdabPoint
    Created on : Jun 17, 2025, 7:26:15 PM
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

        .content {
            flex-grow: 1;
            padding: 100px 40px 40px 40px;
            margin-left: 250px;
            transition: margin-left 0.3s;
        }

        body.sidebar-collapsed .content {
            margin-left: 60px;
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
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
            margin-top: 18px;
            display: block;
            margin-left: auto;
            margin-right: auto;
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
            <img src="StaffImageServlet?staffID=<%= session.getAttribute("staffID") %>" alt="Profile Picture" class="profile-icon">
            <h2 style="margin-top:8px;">
                <%= session.getAttribute("staffName") %><br>
                <%= session.getAttribute("staffID") %>
            </h2>
        </div>
        <div class="menu">
            <a href="<%= request.getContextPath() %>/staffDashboardPage.jsp">HOME</a>
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
        <div class="dashboard-title">ADAB POINT EVALUATION</div>
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
 
 <style>
     
.content {
    flex-grow: 1;
    padding: 60px 0 10px 0;
    margin-left: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 100vh;
    box-sizing: border-box;
}

.adab-table-title {
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 24px;
    letter-spacing: 1px;
    color: #222;
}

table.adab-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 1em;
    background: #fff;
}

table.adab-table thead th {
    background: #eaf6f4;
    color: #222;
    font-weight: 700;
    padding: 14px 8px;
    border-bottom: 2px solid #008b8b;
    text-align: center;
}

table.adab-table tbody td {
    padding: 12px 8px;
    border-bottom: 1px solid #e0e0e0;
    text-align: center;
}

table.adab-table td:first-child,
table.adab-table th:first-child {
    text-align: left;
}

.badge {
    display: inline-block;
    padding: 4px 18px;
    border-radius: 16px;
    font-weight: 600;
    font-size: 1em;
    color: #fff;
}

.badge.yes {
    background: #008b8b;
}

.badge.no {
    background: #e74c3c;
}

.more-btn {
    margin-top: 5px;
    background: #008b8b;
    color: #fff;
    border: none;
    border-radius: 22px;
    padding: 10px 32px;
    font-size: 1.1em;
    font-weight: 600;
    cursor: pointer;
    float: left;
    transition: background 0.2s;
}

.more-btn:hover {
    background: #0a6d6d;
}
</style>

    <!-- Main Content -->
    <div class="content">
        <div class="adab-table-container">
            <div class="adab-table-title">ADAB POINT EVALUTION</div>
            <table class="adab-table">
                <thead>
                    <tr>
                        <th>STUDENT NAME</th>
                        <th>MATRIC NUMBER</th>
                        <th>TOTAL ACTIVITIES JOINED</th>
                        <th>UNIFORM BODY</th>
                        <th>ADAB POINT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Muhammad Aniq Faris Bin Samsudin</td>
                        <td>2023436188</td>
                        <td>10</td>
                        <td><span class="badge yes">Yes</span></td>
                        <td>6</td>
                    </tr>
                    <tr>
                        <td>Muhammad Aminuddin Bin Hasan</td>
                        <td>2023896726</td>
                        <td>7</td>
                        <td><span class="badge yes">Yes</span></td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td>Muhammad Aidil Imran Bin Norizan</td>
                        <td>2023463732</td>
                        <td>10</td>
                        <td><span class="badge yes">Yes</span></td>
                        <td>6</td>
                    </tr>
                    <tr>
                        <td>NurIn Danisa Binti Suhaimi Arif</td>
                        <td>2023985574</td>
                        <td>9</td>
                        <td><span class="badge yes">Yes</span></td>
                        <td>5.5</td>
                    </tr>
                    <tr>
                        <td>Nor Iztatul Fitrah Binti Roslan</td>
                        <td>2023678402</td>
                        <td>5</td>
                        <td><span class="badge no">No</span></td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td>Nur Hajiratul Asma Binti Shaari</td>
                        <td>2023121904</td>
                        <td>7</td>
                        <td><span class="badge no">No</span></td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td>Siti Farhana Binti Abd Malik</td>
                        <td>2023441820</td>
                        <td>5</td>
                        <td><span class="badge no">No</span></td>
                        <td>2</td>
                    </tr>
                    <tr>
                        <td>Wan Adelin Sabrina Binti Wan Zaidi</td>
                        <td>2023778001</td>
                        <td>3</td>
                        <td><span class="badge yes">Yes</span></td>
                        <td>1.2</td>
                    </tr>
                    <tr>
                        <td>Zahwa Faqihah Binti Harizuan</td>
                        <td>2023288954</td>
                        <td>4</td>
                        <td><span class="badge no">No</span></td>
                        <td>3.5</td>
                    </tr>
                    <tr>
                        <td>Zuhairi Ikhwan Bin Zubir</td>
                        <td>2023448964</td>
                        <td>4</td>
                        <td><span class="badge no">No</span></td>
                        <td>1.2</td>
                    </tr>
                </tbody>
            </table>
            <button class="more-btn">More Student &rarr;</button>
        </div>
    </div>
    </html>
<script>
    const sidebar = document.getElementById('sidebar');
    const toggleBtn = document.getElementById('sidebarToggle');
    toggleBtn.addEventListener('click', function() {
        sidebar.classList.toggle('collapsed');
        document.body.classList.toggle('sidebar-collapsed');
    });
</script>