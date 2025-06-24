<%-- 
    Document   : addStaff
    Created on : Jun 17, 2025, 6:02:34 PM
    Author     : semaaa
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Staff</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            background-color: #f0f0f0;
            overflow: hidden;
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
            padding: 80px 40px 20px 40px;
            margin-left: 250px;
        }

        .form-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            padding: 25px 40px;
            max-width: 600px;
            margin: 0 auto;
        }

        .form-container h1 {
            color: #008b8b;
            margin-top: 0;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 12px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 8px 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #008b8b;
        }

        .submit-btn {
            background: #008b8b;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background: #0a6d6d;
        }

        .message {
            padding: 12px;
            margin: 20px 0;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
        }

        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
            <a href="<%= request.getContextPath() %>/staffDashboardPage.jsp">HOME</a>
            <a href="<%= request.getContextPath() %>/staffBooking.jsp">BOOKING</a>
            <a href="<%= request.getContextPath() %>/staffAdabPoint.jsp">ADAB POINT</a>
            <a href="<%= request.getContextPath() %>/addClub.jsp">CLUB REGISTRATION</a>
            <a href="<%= request.getContextPath() %>/addStaff.jsp">ADD STAFF</a>
        </div>
    </div>
        
    <!-- Top Navigation Bar -->
    <div class="topbar">
        <div class="dashboard-title">ADD STAFF</div>
        <div class="top-icons">
            <img src="image/umpsa.png" alt="UMPSA" class="umpsa-icon">
            <img src="image/staff.jpg" alt="Profile" class="profile-icon">
        </div>
    </div>
 
    <div class="content">
        <div class="form-container">
            <h1>Add New Staff</h1>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="message success">
                    New Staff Added Successfully!
                </div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="message error">
                    Error: <%= request.getParameter("error") %>
                </div>
            <% } %>
            
            <form action="<%= request.getContextPath() %>/AddStaffServlet" method="post">
                <div class="form-group">
                    <label for="staffID">Staff ID:</label>
                    <input type="number" id="staffID" name="staffID" required>
                </div>
                
                <div class="form-group">
                    <label for="staffName">Staff Name:</label>
                    <input type="text" id="staffName" name="staffName" required>
                </div>
                
                <div class="form-group">
                    <label for="staffEmail">Staff Email:</label>
                    <input type="email" id="staffEmail" name="staffEmail" required>
                </div>
                
                <div class="form-group">
                    <label for="staffPhone">Staff Phone:</label>
                    <input type="tel" id="staffPhone" name="staffPhone" required>
                </div>
                
                <div class="form-group">
                    <label for="staffDep">Staff Department:</label>
                    <select id="staffDep" name="staffDep" required>
                        <option value="">Select Department</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Engineering">Engineering</option>
                        <option value="Business">Business</option>
                        <option value="Arts">Arts</option>
                        <option value="Science">Science</option>
                        <option value="Medicine">Medicine</option>
                        <option value="Law">Law</option>
                        <option value="Education">Education</option>
                        <option value="Administration">Administration</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="staffPassword">Staff Password:</label>
                    <input type="password" id="staffPassword" name="staffPassword" required>
                </div>
                
                <button type="submit" class="submit-btn">Add Staff</button>
            </form>
        </div>
    </div>

</body>
</html> 