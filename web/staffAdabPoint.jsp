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
    <div class="dashboard-title">ADAB POINT EVALUATION</div>
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
    const toggleBtn = document.getElementById('toggleBtn');
    const body = document.body;

    toggleBtn.addEventListener('click', function() {
        sidebar.classList.toggle('closed');
        body.classList.toggle('sidebar-collapsed');
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
