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
    <style> 
        body {
    font-family: Arial, sans-serif;
    background-color: #F0F0F0; /* Light background for the dashboard */
    color: #333; /* Dark text color for readability */
    margin: 0;
    padding: 0;
}

/* Header Styles */
header {
    background-color: #007A7D; /* Teal background */
    color: white; /* White text */
    padding: 20px;
    text-align: center;
}

/* Sidebar Styles */
.sidebar {
    background-color: #009B9D; /* Dark teal for sidebar */
    color: white; /* White text */
    width: 250px;
    height: 100vh; /* Full height */
    position: fixed;
    padding: 20px 0;
    overflow-y: auto;
}

.sidebar a {
    color: white; /* White text for links */
    padding: 10px 15px;
    text-decoration: none; /* Remove underline */
    display: block; /* Make links block level */
}

.sidebar a:hover {
    background-color: #007A7D; /* Darker teal on hover */
}

/* Main Content Styles */
.main-content {
    margin-left: 260px; /* To avoid overlap with sidebar */
    padding: 20px;
}

/* Profile Header Styles */
.profile-header {
    background-color: #A1D2D3; /* Light teal for profile header */
    padding: 15px;
    border-radius: 5px;
    text-align: left;
}

/* Student Profile Styles */
.student-profile {
    background-color: #E5E5E5; /* Light grey background for profile section */
    padding: 20px;
    border-radius: 5px;
    margin-top: 20px;
}

.student-profile h2 {
    margin-top: 0; /* Remove default margin */
}

/* Table Styles */
table {
    width: 100%; /* Full width */
    border-collapse: collapse; /* Merge table borders */
}

th, td {
    padding: 10px;
    border-bottom: 1px solid #ddd; /* Light border for rows */
}

th {
    background-color: #009B9D; /* Header background color */
    color: white; /* White text for header */
}

/* Button Styles */
.button {
    background-color: #007A7D; /* Button background */
    color: white; /* White text */
    border: none; /* Remove default border */
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer; /* Pointer cursor on hover */
}

.button:hover {
    background-color: #005F60; /* Darker teal on button hover */
}

/* Footer Styles */
footer {
    background-color: #007A7D; /* Footer background */
    color: white; /* White text */
    text-align: center; /* Center the text */
    padding: 10px 0;
    position: relative;
    bottom: 0;
    width: 100%;
}
</style>
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
                <th>PROGRAM</th>
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