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
            padding: 100px 40px 40px 40px;
            margin-left: 250px;
            transition: margin-left 0.3s;
        }
        body.sidebar-collapsed .content {
            margin-left: 60px;
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
        <a href="<%= request.getContextPath() %>/staffSettings.jsp">SETTINGS</a>
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
    <div class="dashboard-title">STAFF DASHBOARD</div>
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
        <!-- Remove Error Message Display -->
        <!-- Remove profile image from Welcome Card -->
        <div style="background:#fff; border-radius:16px; box-shadow:0 2px 12px rgba(0,0,0,0.07); padding:24px 40px; display:flex; align-items:center; gap:24px; max-width:900px; margin:0 auto 24px auto;">
            <div style="flex:1;">
                <h2 style="margin:0 0 6px 0; font-size:1.5em; color:#008b8b;">Welcome, <%= session.getAttribute("staffName") != null ? session.getAttribute("staffName") : "Staff" %>!</h2>
                <p style="margin:0; color:#444;">You can review, approve, or reject club proposals and booking requests here.</p>
                <p style="margin:0; color:#444;">You can assign ADAB evaluation to student.</p>
            </div>
        </div>
        
        <div style="display:flex; gap:24px; max-width:900px; margin:0 auto 24px auto;">
            <div class="dashboard-card-clickable" style="flex:1; background:#eaf6f4; border-radius:12px; padding:24px 0; text-align:center; box-shadow:0 2px 8px rgba(0,0,0,0.04);" onclick="window.location.href='staffBooking.jsp'">
                <h3 style="margin:0 0 8px 0; font-size:2em; color:#008b8b;"><%= request.getAttribute("bookingRequests") != null ? request.getAttribute("bookingRequests") : "0" %></h3>
                <p style="margin:0; color:#444; font-weight:bold;">Booking Requests</p>
            </div>
            <div class="dashboard-card-clickable" style="flex:1; background:#eaf6f4; border-radius:12px; padding:24px 0; text-align:center; box-shadow:0 2px 8px rgba(0,0,0,0.04);" onclick="window.location.href='staffBooking.jsp?type=approved'">
                <h3 style="margin:0 0 8px 0; font-size:2em; color:#008b8b;"><%= request.getAttribute("approvedBookings") != null ? request.getAttribute("approvedBookings") : "0" %></h3>
                <p style="margin:0; color:#444; font-weight:bold;">Approved Bookings</p>
            </div>
        </div>

        <div style="max-width:900px; margin:0 auto 32px auto; background:#fff; border-radius:12px; box-shadow:0 2px 8px rgba(0,0,0,0.04); padding:24px;">
            <h3 style="color:#222; margin-bottom:16px;">Rejected Bookings List</h3>
            <table style="width:100%; border-collapse:collapse; background:#fff;">
                <thead>
                    <tr style="background:#f5f5f5; color:#222;">
                        <th style="padding:10px;">Booking Type</th>
                        <th style="padding:10px;">Item/Venue</th>
                        <th style="padding:10px;">Details</th>
                        <th style="padding:10px;">Club</th>
                        <th style="padding:10px;">Date</th>
                        <th style="padding:10px;">Activity Name</th>
                        <th style="padding:10px;">Status</th>
                    </tr>
                </thead>
                <tbody>
                <% java.util.List<model.BOOKING> bookings = model.BOOKING.getAllBookings();
                   for (model.BOOKING booking : bookings) {
                       if (!"Rejected".equalsIgnoreCase(booking.getStatus())) continue;
                       String activityName = "-";
                       if (booking.getActivityID() != null) {
                           model.ACTIVITY activity = model.ACTIVITY.getActivityById(booking.getActivityID());
                           if (activity != null) {
                               activityName = activity.getActivityName();
                           }
                       }
                       String clubName = "-";
                       if (booking.getClubID() > 0) {
                           model.CLUB clubObj = model.CLUB.getClubById(booking.getClubID());
                           if (clubObj != null) {
                               clubName = clubObj.getClubName();
                           }
                       }
                %>
                    <tr>
                        <td style="padding:8px; text-align:center;"><%= booking.getBookingType() %></td>
                        <td style="padding:8px; text-align:center;"><%= booking.getItemName() %></td>
                        <td style="padding:8px; text-align:center;"><%= booking.getItemDetails() %></td>
                        <td style="padding:8px; text-align:center;"><%= clubName %></td>
                        <td style="padding:8px; text-align:center;"><%= booking.getBookingDate() %></td>
                        <td style="padding:8px; text-align:center;"><%= activityName %></td>
                        <td style="padding:8px; text-align:center;"><span style="background:#f8d7da; color:#c62828; padding:4px 12px; border-radius:12px; font-weight:500;">Rejected</span></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
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
