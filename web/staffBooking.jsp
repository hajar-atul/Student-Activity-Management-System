<%-- 
    Document   : staffBooking
    Created on : Jun 17, 2025, 7:23:23 PM
    Author     : sema
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
            <%= session.getAttribute("staffName") %><br>
            <%= session.getAttribute("staffID") %>
        </h2>
        <div class="menu">
            <a href="staffDashboardPage.jsp">HOME</a>
            <a href="staffBooking.jsp">BOOKING</a>
            <a href="staffAdabPoint.jsp">ADAB POINT</a>
            <a href="addClub.jsp">Club Registration</a>
        </div>
    </div>
        
 <!-- Top Navigation Bar -->
    <div class="topbar">
        <div class="search-container">
            <input type="text" placeholder="Search..." />
            <button class="search-btn">X</button>
        </div>
        <div class="dashboard-title">BOOKING REQUEST</div>
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
 
 <style>
   

.booking-table-title {
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 24px;
    letter-spacing: 1px;
    color: #222;
}

table.booking-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 1em;
    background: #fff;
}

table.booking-table thead th {
    background: #eaf6f4;
    color: #222;
    font-weight: 700;
    padding: 14px 8px;
    border: 2px solid #222;
    text-align: center;
}

table.booking-table tbody td {
    padding: 12px 8px;
    border: 2px solid #222;
    text-align: center;
}

.btn {
    border: none;
    border-radius: 16px;
    padding: 6px 18px;
    font-weight: 600;
    font-size: 1em;
    margin-right: 6px;
    cursor: pointer;
    transition: background 0.2s;
}

.btn.view {
    background: #1a8a7c;
    color: #fff;
}

.btn.approve {
    background: #1a8a7c;
    color: #fff;
}

.btn.reject {
    background: #e74c3c;
    color: #fff;
}

.btn.view:hover, .btn.approve:hover {
    background: #15796b;
}

.btn.reject:hover {
    background: #c0392b;
}

.more-request-btn {
    margin-top: 30px;
    background: #1a8a7c;
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

.more-request-btn:hover {
    background: #15796b;
} 
   </style>
   
       <!-- Main Content -->
    <div class="content">
        <div class="booking-table-container">
            <div class="booking-table-title">BOOKING REQUEST</div>
            <table class="booking-table">
                <thead>
                    <tr>
                        <th>ITEMS</th>
                        <th>CAPACITY</th>
                        <th>CLUB</th>
                        <th>DATE</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>CHAIR</td>
                        <td>100</td>
                        <td>IT CLUB</td>
                        <td>26 JUNE 2025</td>
                        <td>
                            <button class="btn view">View</button>
                            <button class="btn approve">Approve</button>
                            <button class="btn reject">Reject</button>
                        </td>
                    </tr>
                    <tr>
                        <td>CURTAINS</td>
                        <td>5</td>
                        <td>EACC CLUB</td>
                        <td>12 JULY 2025</td>
                        <td>
                            <button class="btn view">View</button>
                            <button class="btn approve">Approve</button>
                            <button class="btn reject">Reject</button>
                        </td>
                    </tr>
                    <tr>
                        <td>TABLE CLOTH</td>
                        <td>4</td>
                        <td>SOCIETY</td>
                        <td>15 JULY 2025</td>
                        <td>
                            <button class="btn view">View</button>
                            <button class="btn approve">Approve</button>
                            <button class="btn reject">Reject</button>
                        </td>
                    </tr>
                    <tr>
                        <td>ROUND TABLE</td>
                        <td>4</td>
                        <td>SOCIETY</td>
                        <td>15 JULY 2025</td>
                        <td>
                            <button class="btn view">View</button>
                            <button class="btn approve">Approve</button>
                            <button class="btn reject">Reject</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button class="more-request-btn">More Request &rarr;</button>
        </div>
    </div>
</html>