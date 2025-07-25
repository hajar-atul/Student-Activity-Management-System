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

        .booking-actions {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
        }

        .action-btn {
            background: #007b7b;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            text-decoration: none;
            text-align: center;
        }
        .action-btn:hover {
            background: #005f5f;
        }

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
        .btn.approve {
            background: #1a8a7c;
            color: #fff;
        }
        .btn.reject {
            background: #e74c3c;
            color: #fff;
        }
        .btn.approve:hover {
            background: #15796b;
        }
        .btn.reject:hover {
            background: #c0392b;
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
    <div class="dashboard-title">STAFF BOOKING</div>
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

    <!-- Main Content -->
    <div class="content">
        <div class="booking-table-container">
            <div class="booking-table-title">OVERALL BOOKING REQUEST</div>
            
            <div class="booking-actions">
                <a href="staffBooking.jsp" class="action-btn">ALL BOOKING</a>
                <a href="staffBooking.jsp?type=venue" class="action-btn">VENUE BOOKING</a>
                <a href="staffBooking.jsp?type=resource" class="action-btn">RESOURCE BOOKING</a>
                <a href="staffBooking.jsp?type=approved" class="action-btn" style="background:#388e3c; color:white;">APPROVED BOOKING</a>
                <a href="staffBooking.jsp?type=rejected" class="action-btn" style="background:#c62828; color:white;">REJECTED BOOKING</a>
            </div>

            <table class="booking-table">
                <thead>
                    <tr>
                        <th>BOOKING TYPE</th>
                        <th>ITEM/VENUE</th>
                        <th>DETAILS</th>
                        <th>CLUB</th>
                        <th>DATE</th>
                        <th>STATUS</th>
                        <th>ACTIVITY NAME</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Dynamic booking rows --%>
                    <%
                        java.util.List<model.BOOKING> bookings = model.BOOKING.getAllBookings();
                        String filterType = request.getParameter("type");
                        for (model.BOOKING booking : bookings) {
                            if (filterType != null && !filterType.isEmpty() && !filterType.equalsIgnoreCase("all")) {
                                if (filterType.equalsIgnoreCase("approved")) {
                                    if (!"Approved".equalsIgnoreCase(booking.getStatus())) {
                                        continue;
                                    }
                                } else if (filterType.equalsIgnoreCase("rejected")) {
                                    if (!"Rejected".equalsIgnoreCase(booking.getStatus())) {
                                        continue;
                                    }
                                } else if (!filterType.equalsIgnoreCase(booking.getBookingType())) {
                                    continue;
                                }
                            }
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
                        <td><span class="badge type-<%= booking.getBookingType().toLowerCase() %>"><%= booking.getBookingType() %></span></td>
                        <td><%= booking.getItemName() %></td>
                        <td><%= booking.getItemDetails() %></td>
                        <td><%= clubName %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td>
                          <% if ("Approved".equalsIgnoreCase(booking.getStatus())) { %>
                            <span style="background:#c8f7c5; color:#218838; padding:4px 12px; border-radius:12px; font-weight:500;">Approved</span>
                          <% } else if ("Rejected".equalsIgnoreCase(booking.getStatus())) { %>
                            <span style="background:#f8d7da; color:#721c24; padding:4px 12px; border-radius:12px; font-weight:500;">Rejected</span>
                          <% } else { %>
                            <span style="background:#fff3cd; color:#856404; padding:4px 12px; border-radius:12px; font-weight:500;">Pending</span>
                          <% } %>
                        </td>
                        <td><%= activityName %></td>
                        <td>
                            <% if ("Pending".equalsIgnoreCase(booking.getStatus())) { %>
                                <div class="action-buttons">
                                    <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                        <input type="hidden" name="status" value="Approved">
                                        <input type="hidden" name="redirectPage" value="staffBooking.jsp">
                                        <button type="submit" class="btn approve">Approve</button>
                                    </form>
                                    <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                        <input type="hidden" name="status" value="Rejected">
                                        <input type="hidden" name="redirectPage" value="staffBooking.jsp">
                                        <button type="submit" class="btn reject">Reject</button>
                                    </form>
                                </div>
                            <% } else { %>
                                <div class="edit-link-container" id="edit-link-<%= booking.getBookingID() %>">
                                    <a href="#" class="edit-link" style="color:#1976d2; text-decoration:underline; font-weight:600;" onclick="showEditButtons('<%= booking.getBookingID() %>'); return false;">Edit</a>
                                </div>
                                <div class="action-buttons" id="action-buttons-<%= booking.getBookingID() %>" style="display:none;">
                                    <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                        <input type="hidden" name="status" value="Approved">
                                        <input type="hidden" name="redirectPage" value="staffBooking.jsp">
                                        <button type="submit" class="btn approve">Approve</button>
                                    </form>
                                    <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                        <input type="hidden" name="status" value="Rejected">
                                        <input type="hidden" name="redirectPage" value="staffBooking.jsp">
                                        <button type="submit" class="btn reject">Reject</button>
                                    </form>
                                </div>
                            <% } %>
                        </td>
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

    function showEditButtons(bookingId) {
        document.getElementById('edit-link-' + bookingId).style.display = 'none';
        document.getElementById('action-buttons-' + bookingId).style.display = 'inline-block';
    }
</script>
</body>
</html>
