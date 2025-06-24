<%@ page import="java.util.List" %>
<%@ page import="model.BOOKING" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Venue Booking Requests</title>
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

        .top-icons img.umpsa-icon {
            width: 36px;
            height: 36px;
        }

        .profile-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .content {
            flex-grow: 1;
            padding: 100px 40px 40px 40px;
            margin-left: 250px;
        }

        .booking-table-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 24px;
            color: #222;
        }

        table.booking-table {
            width: 100%;
            border-collapse: collapse;
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

        .btn.approve { background: #1a8a7c; color: #fff; }
        .btn.reject { background: #e74c3c; color: #fff; }
        .btn.approve:hover { background: #15796b; }
        .btn.reject:hover { background: #c0392b; }
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
            <a href="<%= request.getContextPath() %>/StaffDashboardServlet">HOME</a>
            <a href="<%= request.getContextPath() %>/staffBooking.jsp">BOOKING</a>
            <a href="<%= request.getContextPath() %>/staffAdabPoint.jsp">ADAB POINT</a>
            <a href="<%= request.getContextPath() %>/addClub.jsp">CLUB REGISTRATION</a>
            <a href="<%= request.getContextPath() %>/addStaff.jsp">ADD STAFF</a>
        </div>
    </div>
        
    <!-- Top Navigation Bar -->
    <div class="topbar">
        <div class="dashboard-title">VENUE BOOKING REQUEST</div>
        <div class="top-icons">
            <img src="image/umpsa.png" alt="UMPSA" class="umpsa-icon">
            <img src="image/staff.jpg" alt="Profile" class="profile-icon">
        </div>
    </div>
 
    <!-- Main Content -->
    <div class="content">
        <div class="booking-table-container">
            <div class="booking-table-title">VENUE BOOKING REQUESTS</div>
            <table class="booking-table">
                <thead>
                    <tr>
                        <th>VENUE NAME</th>
                        <th>CLUB</th>
                        <th>DATE</th>
                        <th>TIME</th>
                        <th>DURATION</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<BOOKING> bookings = (List<BOOKING>) request.getAttribute("bookings");
                        if (bookings != null && !bookings.isEmpty()) {
                            for (BOOKING booking : bookings) {
                    %>
                    <tr>
                        <td><%= booking.getItemName() %></td>
                        <td><%= booking.getClubName() %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <%
                            String itemDetails = booking.getItemDetails();
                            String time = "N/A";
                            String duration = "N/A";

                            if (itemDetails != null) {
                                String[] parts = itemDetails.split(",");
                                for (String part : parts) {
                                    part = part.trim();
                                    if (part.startsWith("Time:")) {
                                        time = part.substring(part.indexOf(":") + 1).trim();
                                    } else if (part.startsWith("Duration:")) {
                                        duration = part.substring(part.indexOf(":") + 1).trim();
                                    }
                                }
                            }
                        %>
                        <td><%= time %></td>
                        <td><%= duration %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet" method="post" style="display:inline;">
                                <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                <input type="hidden" name="status" value="Approved">
                                <input type="hidden" name="redirectPage" value="<%= request.getContextPath() %>/BookingListServlet?type=venue">
                                <button type="submit" class="btn approve">Approve</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet" method="post" style="display:inline;">
                                <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                <input type="hidden" name="status" value="Rejected">
                                <input type="hidden" name="redirectPage" value="<%= request.getContextPath() %>/BookingListServlet?type=venue">
                                <button type="submit" class="btn reject">Reject</button>
                            </form>
                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6">No pending venue booking requests found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>