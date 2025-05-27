<%-- 
    Document   : StudentDashboardPage
    Created on : May 25, 2025, 12:37:54 AM
    Author     : USER
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile</title>
    <link rel="stylesheet" href="StudentDashboardPage.css"> <!-- Link to your CSS file -->
</head>
<body>
    <div class="dashboard">
        <h1>Welcome, <%= request.getAttribute("name") %></h1>
        <h2>STUDENT PROFILE</h2>
        <table>
            <tr>
                <th>STUDENT ID</th>
                <td><%= request.getAttribute("studentId") %></td>
            </tr>
            <tr>
                <th>NAME</th>
                <td><%= request.getAttribute("name") %></td>
            </tr>
            <tr>
                <th>DATE OF BIRTH</th>
                <td><%= request.getAttribute("dob") %></td>
            </tr>
            <tr>
                <th>PROGRAMME</th>
                <td><%= request.getAttribute("programme") %></td>
            </tr>
            <tr>
                <th>MOBILE NUMBER</th>
                <td><%= request.getAttribute("mobileNumber") %></td>
            </tr>
            <tr>
                <th>CURRENT EMAIL</th>
                <td><%= request.getAttribute("email") %></td>
            </tr>
            <tr>
                <th>MUET STATUS</th>
                <td><%= request.getAttribute("muetStatus") %></td>
            </tr>
            <tr>
                <th>ADVISOR</th>
                <td><%= request.getAttribute("advisor") %></td>
            </tr>
        </table>
    </div>
</body>
</html>