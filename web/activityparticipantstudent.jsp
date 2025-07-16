<%@ page import="java.util.List" %>
<%@ page import="model.STUDENT" %>
<%@ page import="model.ACTIVITY" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    ACTIVITY activity = (ACTIVITY) request.getAttribute("activity");
    List<STUDENT> students = (List<STUDENT>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Activity Participants</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; margin: 0; }
        .container {
            max-width: 1100px;
            margin: 40px auto;
            background: #fff;
            border-radius: 10px;
            padding: 30px 40px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 26px;
            font-weight: bold;
            color: #238B87;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
            background: #fff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(34,139,135,0.07);
        }
        th, td {
            padding: 15px 18px;
            text-align: left;
            font-size: 16px;
            border: none;
        }
        th {
            background: #e0f7fa;
            font-size: 17px;
            font-weight: 600;
            color: #00796B;
            border-bottom: 2px solid #b2dfdb;
        }
        tr {
            transition: background 0.18s;
        }
        tr:nth-child(even) { background: #f7fafc; }
        tr:nth-child(odd) { background: #fff; }
        tr:hover { background: #e0f7fa; }
        td {
            color: #222;
            font-weight: 400;
            border-bottom: 1px solid #f0f0f0;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 24px;
            background: #00796B;
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            padding: 10px 26px;
            border-radius: 7px;
            border: none;
            transition: background 0.18s, box-shadow 0.18s;
            box-shadow: 0 2px 8px rgba(10,128,121,0.07);
            letter-spacing: 0.2px;
            cursor: pointer;
        }
        .back-link:hover {
            background: #005f56;
            color: #fff;
            text-decoration: none;
            box-shadow: 0 4px 16px rgba(10,128,121,0.13);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #0a8079;
            color: white;
            padding: 20px 40px;
        }
        .header-title {
            font-size: 28px;
            font-weight: bold;
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
        .notification-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }
        .notification-btn img {
            width: 30px;
            height: 30px;
        }
        .profile-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }
        .notification-dropdown {
            position: absolute;
            top: 80px;
            right: 40px;
            background-color: white;
            color: black;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 10px;
            width: 200px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            display: none;
            z-index: 100;
        }
        .sidebar {
      width: 230px;
      height: 100vh;
      background-color: #00796B;
      color: white;
      position: fixed;
      padding: 70px 20px 20px 20px;
      overflow-y: auto;
      z-index: 10;
      text-align: center;
    }

    .sidebar.closed {
      transform: translateX(-100%);
    }

    .sidebar img.profile-pic {
      width: 100px;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 15px;
      border: 3px solid white;
    }

    .sidebar h3 {
      margin-bottom: 10px;
    }

    .sidebar ul {
      list-style: none;
      padding-left: 0;
      margin-top: 20px;
    }

    .sidebar ul li {
      margin-bottom: 15px;
    }

    .sidebar ul li a {
      color: white;
      text-decoration: none;
      padding: 10px;
      display: block;
      border-radius: 5px;
      transition: background-color 0.2s ease;
    }

    .sidebar ul li a:hover,
    .sidebar ul li a.active {
      background-color: rgba(0, 0, 0, 0.2);
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
        .toggle-btn {
            position: fixed;
            left: 10px;
            top: 10px;
            z-index: 1000;
            background-color: #00796B;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
        }
        .main-content {
            margin-left: 270px;
            transition: margin-left 0.3s ease;
        }
        .main-content.full-width {
            margin-left: 20px;
        }
        @media (max-width: 768px) {
            .header { flex-direction: column; align-items: flex-start; padding: 10px 10px; }
            .header-title { font-size: 22px; margin-bottom: 10px; }
            .main-content {
                margin-left: 0 !important;
            }
            .sidebar {
                width: 100%;
                height: auto;
                position: static;
            }
            .toggle-btn {
                position: absolute;
                left: 10px;
                top: 10px;
            }
        }
    </style>
</head>
<body>
    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
    <div class="sidebar" id="sidebar">
        <img src="ClubImageServlet?clubID=<%= session.getAttribute("club") != null ? ((model.CLUB)session.getAttribute("club")).getClubId() : 0 %>" alt="User Profile Picture" class="profile-pic">
        <h3><%= session.getAttribute("clubName") %></h3>
        <ul>
            <li><a href="clubDashboardPage.jsp">DASHBOARD</a></li>
            <li><a href="clubActivitiesPage.jsp" class="active">ACTIVITIES</a></li>
            <li><a href="venueBooking.jsp">VENUE BOOKING</a></li>
            <li><a href="resourceReq.jsp">RESOURCE BOOKING</a></li>
            <li><a href="clubFeedback.jsp">FEEDBACK</a></li>
            <li><a href="clubReport.jsp">REPORT</a></li>
            <li><a href="clubSettings.jsp">SETTINGS</a></li>
        </ul>
        <div style="position: absolute; bottom: 20px; width: 80%; left: 10%; margin-top: 100px; margin-bottom: 90px;">
            <form action="index.jsp">
                <button type="submit" class="activity-btn">Logout</button>
            </form>
        </div>
    </div>
    <div class="main-content" id="mainContent">
        <div class="header">
            <div class="header-title">ACTIVITY PARTICIPANTS</div>
            <div class="top-icons">
                <img src="image/umpsa.png" alt="UMPSA Logo" class="umpsa-icon" />
                <button class="notification-btn" id="notificationBtn">
                    <img src="image/bell.png" alt="Notifications" />
                </button>
                <img src="ClubImageServlet?clubID=<%= session.getAttribute("club") != null ? ((model.CLUB)session.getAttribute("club")).getClubId() : 0 %>" alt="User Avatar" class="profile-icon" />
            </div>
        </div>
        <div class="notification-dropdown" id="notificationDropdown">
            <p>No new notifications</p>
        </div>
        <div class="container">
            <a href="clubActivitiesPage.jsp" class="back-link">&larr; Back to Activities</a>
            <h2>Participants for Activity: <%= activity != null ? activity.getActivityName() : "Unknown" %></h2>
            <table>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Semester</th>
                </tr>
                <% if (students == null || students.isEmpty()) { %>
                    <tr><td colspan="5">No students registered for this activity.</td></tr>
                <% } else {
                    for (STUDENT s : students) { %>
                <tr>
                    <td><%= s.getStudID() %></td>
                    <td><%= s.getStudName() %></td>
                    <td><%= s.getStudEmail() %></td>
                    <td><%= s.getStudCourse() %></td>
                    <td><%= s.getStudSemester() %></td>
                </tr>
            <% }
            } %>
            </table>
        </div>
    </div>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const main = document.getElementById('mainContent');
            sidebar.classList.toggle('closed');
            main.classList.toggle('full-width');
        }
        document.getElementById("notificationBtn").addEventListener("click", function () {
            const dropdown = document.getElementById("notificationDropdown");
            dropdown.style.display = dropdown.style.display === "none" ? "block" : "none";
        });
    </script>
</body>
</html> 