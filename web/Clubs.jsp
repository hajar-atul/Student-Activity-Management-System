<%-- 
    Document   : Clubs
    Created on : Jun 6, 2025, 3:51:43 PM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Clubs</title>
    <style>
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #00796B;
            color: white;
            position: fixed;
            padding: 20px;
        }

        .sidebar ul {
            list-style: none;
            padding-left: 0;
            margin-top: 30px;
        }

        .sidebar ul li {
            margin-bottom: 15px;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
        }

        .main-content {
            margin-left: 270px;
            padding: 20px;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h3>MUHAMMAD AMINUDDIN BIN HASNAN</h3>
        <p>2023217854</p>

        <ul>
            <li><a href="dashboard.jsp">Dashboard</a></li>
            <li><a href="activities.jsp">Activities</a></li>
            <li><a href="clubs.jsp">Clubs</a></li>
            <li><a href="achievements.jsp">Achievements</a></li>
            <li><a href="settings.jsp">Settings</a></li>
        </ul>
    </div>

    <div class="main-content">
        <h2>Clubs Page</h2>
        <p>This is the section where student clubs will be listed.</p>
    </div>

</body>
</html>
