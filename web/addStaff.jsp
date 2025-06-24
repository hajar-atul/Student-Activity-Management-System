<%-- 
    Document   : addStaff
    Created on : Jun 24, 2025, 10:01:35 PM
    Author     : sema
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Staff</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            display: flex;
            background: linear-gradient(135deg, #e0f7fa 0%, #f0f0f0 100%);
            min-height: 100vh;
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            padding-left: 6vw;
            padding-right: 2vw;
            margin-left: 250px;
        }

        .form-container {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0,139,139,0.10), 0 1.5px 6px rgba(0,0,0,0.04);
            padding: 40px 48px 32px 48px;
            max-width: 480px;
            width: 100%;
            margin: 40px 0;
            position: relative;
            transition: box-shadow 0.3s;
        }
        .form-container:hover {
            box-shadow: 0 12px 40px rgba(0,139,139,0.18), 0 2px 8px rgba(0,0,0,0.06);
        }
        .form-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            margin-bottom: 18px;
        }
        .form-header img {
            width: 38px;
            height: 38px;
        }
        .form-container h1 {
            color: #008b8b;
            margin: 0;
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            color: #008b8b;
            letter-spacing: 0.5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #b2dfdb;
            border-radius: 10px;
            font-size: 16px;
            background: #f8fdfd;
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #008b8b;
            box-shadow: 0 0 0 2px #b2dfdb55;
        }
        .submit-btn {
            background: linear-gradient(90deg, #008b8b 60%, #00bfae 100%);
            color: white;
            border: none;
            padding: 12px 0;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
            box-shadow: 0 2px 8px rgba(0,139,139,0.08);
            letter-spacing: 0.5px;
            transition: background 0.3s, box-shadow 0.3s;
        }
        .submit-btn:hover {
            background: linear-gradient(90deg, #0a6d6d 60%, #00bfae 100%);
            box-shadow: 0 4px 16px rgba(0,139,139,0.13);
        }
        .message {
            padding: 12px;
            margin: 20px 0 10px 0;
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

    <!-- Decorative Background Elements -->
    <div style="position: fixed; z-index: 0; left: 0; top: 0; width: 100vw; height: 100vh; pointer-events: none; overflow: hidden;">
        <!-- Blurred Circles -->
        <div style="position: absolute; left: 10vw; top: 10vh; width: 220px; height: 220px; background: #00bfae44; border-radius: 50%; filter: blur(60px);"></div>
        <div style="position: absolute; right: 8vw; top: 30vh; width: 180px; height: 180px; background: #008b8b33; border-radius: 50%; filter: blur(50px);"></div>
        <div style="position: absolute; left: 20vw; bottom: 8vh; width: 160px; height: 160px; background: #ffd70033; border-radius: 50%; filter: blur(60px);"></div>
        <!-- Additional Decorative Circles -->
        <div style="position: absolute; left: 2vw; top: 2vh; width: 120px; height: 120px; background: #008b8b22; border-radius: 50%; filter: blur(40px);"></div>
        <div style="position: absolute; right: 2vw; top: 6vh; width: 90px; height: 90px; background: #00bfae22; border-radius: 50%; filter: blur(30px);"></div>
        <div style="position: absolute; left: 4vw; bottom: 4vh; width: 100px; height: 100px; background: #ffd70022; border-radius: 50%; filter: blur(30px);"></div>
        <!-- Faint Logo Watermark -->
        <img src="image/logoUMP.jpg" alt="UMPSA Logo" style="position: absolute; right: 5vw; bottom: 5vh; width: 320px; opacity: 0.07; z-index: 1; pointer-events: none;">
        <!-- Faint Tagline -->
        <div style="position: absolute; left: 0; top: 50%; width: 100vw; text-align: center; transform: rotate(-8deg) translateY(-50%); font-size: 2.8vw; color: #008b8b11; font-weight: bold; letter-spacing: 2px; user-select: none; pointer-events: none;">Empowering Staff, Enriching Campus Life</div>
    </div>

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
            <div class="form-header">
                <img src="image/userIcon.png" alt="User Icon">
                <h1>Add New Staff</h1>
            </div>
            
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
                    <input type="number" id="staffID" name="staffID" required placeholder="Enter staff ID">
                </div>
                
                <div class="form-group">
                    <label for="staffName">Staff Name:</label>
                    <input type="text" id="staffName" name="staffName" required placeholder="Enter full name">
                </div>
                
                <div class="form-group">
                    <label for="staffEmail">Staff Email:</label>
                    <input type="email" id="staffEmail" name="staffEmail" required placeholder="e.g. staff@university.edu">
                </div>
                
                <div class="form-group">
                    <label for="staffPhone">Staff Phone:</label>
                    <input type="tel" id="staffPhone" name="staffPhone" required placeholder="e.g. 012-3456789">
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
                    <input type="password" id="staffPassword" name="staffPassword" required placeholder="Create a password">
                </div>
                
                <button type="submit" class="submit-btn">Add Staff</button>
            </form>
        </div>
    </div>

</body>
</html>