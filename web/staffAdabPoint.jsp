<%-- 
    Document   : staffAdabPoint
    Created on : Jun 17, 2025, 7:26:15 PM
    Author     : semaaa
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Controller.StaffAdabPointServlet.StudentAdabInfo" %>
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
            padding: 60px 0 10px 0;
            margin-left: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            box-sizing: border-box;
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

        .adab-table-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .adab-table-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 24px;
            letter-spacing: 1px;
            color: #222;
            text-align: center;
        }

        .filter-buttons {
            margin-bottom: 20px;
            text-align: center;
        }

        .filter-btn {
            background: #008b8b;
            color: #fff;
            border: none;
            border-radius: 22px;
            padding: 10px 20px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            margin: 0 10px;
            transition: background 0.2s;
        }

        .filter-btn:hover {
            background: #0a6d6d;
        }

        .filter-btn.active {
            background: #0a6d6d;
        }

        table.adab-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1em;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
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

        table.adab-table tbody tr:hover {
            background-color: #f9f9f9;
        }

        table.adab-table td:first-child,
        table.adab-table th:first-child {
            text-align: left;
        }

        .no-data {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 20px;
        }

        .debug-info {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 20px;
            font-family: monospace;
            font-size: 0.9em;
            display: none; /* Hide in production */
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
            <a href="<%= request.getContextPath() %>/StaffDashboardServlet">HOME</a>
            <a href="<%= request.getContextPath() %>/staffBooking.jsp">BOOKING</a>
            <a href="<%= request.getContextPath() %>/StaffAdabPointServlet">ADAB POINT</a>
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

    <!-- Main Content -->
    <div class="content">
        <div class="adab-table-container">
            <div class="adab-table-title">ADAB POINT EVALUATION</div>
            
            <!-- Debug Info (remove in production) -->
            <div class="debug-info">
                <%
                    List<StudentAdabInfo> studentInfos = (List<StudentAdabInfo>) request.getAttribute("studentInfos");
                    out.println("DEBUG: studentInfos is null: " + (studentInfos == null));
                    if (studentInfos != null) {
                        out.println("<br>DEBUG: studentInfos size: " + studentInfos.size());
                    }
                %>
            </div>

            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <button class="filter-btn active" id="btnShowAll">Show All</button>
                <button class="filter-btn" id="btnMostActivities">Most Activities</button>
                <button class="filter-btn" id="btnNoActivities">No Activities</button>
            </div>

            <!-- Table -->
            <table class="adab-table">
                <thead>
                    <tr>
                        <th>STUDENT NAME</th>
                        <th>MATRIC NUMBER</th>
                        <th>TOTAL ACTIVITIES JOINED</th>
                        <th>ADAB POINT</th>
                    </tr>
                </thead>
                <tbody id="studentTableBody">
                <%
                    if (studentInfos == null || studentInfos.isEmpty()) {
                %>
                    <tr><td colspan="4" class="no-data">No students found.</td></tr>
                <%
                    } else {
                        for (StudentAdabInfo s : studentInfos) {
                %>
                    <tr data-activities="<%= s.getTotalActivities() %>" data-points="<%= s.getAdabPoint() %>">
                        <td><%= s.getStudName() %></td>
                        <td><%= s.getStudID() %></td>
                        <td><%= s.getTotalActivities() %></td>
                        <td><%= s.getAdabPoint() %></td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Sidebar toggle functionality
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('sidebarToggle');
        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            document.body.classList.toggle('sidebar-collapsed');
        });

        // Notification dropdown functionality
        const notificationBtn = document.getElementById('notificationBtn');
        const notificationDropdown = document.getElementById('notificationDropdown');
        
        notificationBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            notificationDropdown.classList.toggle('show');
        });

        document.addEventListener('click', function() {
            notificationDropdown.classList.remove('show');
        });

        // Filter functionality
        const allRows = Array.from(document.querySelectorAll('#studentTableBody tr'));
        const filterButtons = document.querySelectorAll('.filter-btn');

        function showRows(rows) {
            const tbody = document.getElementById('studentTableBody');
            tbody.innerHTML = '';
            
            if (rows.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" class="no-data">No students found matching the filter.</td></tr>';
            } else {
                rows.forEach(row => tbody.appendChild(row.cloneNode(true)));
            }
        }

        function setActiveButton(activeBtn) {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            activeBtn.classList.add('active');
        }

        document.getElementById('btnShowAll').addEventListener('click', function() {
            showRows(allRows);
            setActiveButton(this);
        });

        document.getElementById('btnMostActivities').addEventListener('click', function() {
            if (allRows.length === 0) return;
            
            const maxActivities = Math.max(...allRows.map(row => 
                parseInt(row.getAttribute('data-activities') || '0')
            ));
            
            const mostActiveRows = allRows.filter(row => 
                parseInt(row.getAttribute('data-activities') || '0') === maxActivities && maxActivities > 0
            );
            
            showRows(mostActiveRows);
            setActiveButton(this);
        });

        document.getElementById('btnNoActivities').addEventListener('click', function() {
            const noActivityRows = allRows.filter(row => 
                parseInt(row.getAttribute('data-activities') || '0') === 0
            );
            
            showRows(noActivityRows);
            setActiveButton(this);
        });

        // Debug: Log table data on page load
        console.log('Page loaded. Total rows:', allRows.length);
        allRows.forEach((row, index) => {
            console.log(`Row ${index}:`, {
                name: row.cells[0]?.textContent,
                matric: row.cells[1]?.textContent,
                activities: row.getAttribute('data-activities'),
                points: row.getAttribute('data-points')
            });
        });
    </script>
</body>
</html>
