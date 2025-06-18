<%-- 
    Document   : studentClub
    Created on : Jun 11, 2025, 2:04:14 AM
    Author     : aniqf
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CLUB"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Clubs</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                background-color: #f0f0f0;
                height: 100vh;
                overflow: hidden;
            }

            .sidebar {
                width: 250px;
                background-color: #008b8b;
                color: white;
                padding: 20px;
                height: 100vh;
                overflow-y: auto;
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

            .search-container {
                display: flex;
                align-items: center;
                margin-left: 30px;
            }

            .search-container input {
                padding: 6px 10px;
                border-radius: 20px;
                border: none;
                outline: none;
                width: 180px;
            }

            .search-btn {
                background: white;
                border: none;
                margin-left: -30px;
                cursor: pointer;
                font-weight: bold;
                border-radius: 50%;
                padding: 4px 8px;
                color: #009B9D;
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
                width: 40px;
                height: 40px;
                border-radius: 50%;
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

            .content {
                flex-grow: 1;
                padding: 80px 20px 20px 20px;
                margin-left: 250px;
                height: calc(100vh - 100px);
                overflow-y: auto;
            }

            .club-container {
                max-width: 1200px;
                margin: 0 auto;
                height: 100%;
                display: flex;
                gap: 20px;
            }

            .current-membership, .available-clubs {
                flex: 1;
                background: white;
                border-radius: 10px;
                padding: 15px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                overflow-y: auto;
                max-height: calc(100vh - 140px);
            }

            .section-title {
                color: #008b8b;
                font-size: 18px;
                margin: 0 0 15px 0;
                padding-bottom: 8px;
                border-bottom: 2px solid #008b8b;
            }

            .club-card {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 12px;
                margin-bottom: 12px;
                background-color: #f9f9f9;
                transition: transform 0.2s;
            }

            .club-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .club-name {
                color: #008b8b;
                font-size: 16px;
                margin-bottom: 8px;
                font-weight: bold;
            }

            .club-info {
                color: #34495e;
                margin: 2px 0;
                font-size: 13px;
            }

            .club-info strong {
                color: #2c3e50;
            }

            .message {
                padding: 6px;
                margin: 6px 0;
                border-radius: 5px;
                text-align: center;
                font-size: 13px;
            }

            .success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .action-buttons {
                margin-top: 8px;
                text-align: right;
            }

            .join-btn, .leave-btn {
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                font-size: 13px;
                transition: background-color 0.2s;
            }

            .join-btn {
                background-color: #008b8b;
                color: white;
            }

            .join-btn:hover {
                background-color: #006d6d;
            }

            .leave-btn {
                background-color: #dc3545;
                color: white;
            }

            .leave-btn:hover {
                background-color: #c82333;
            }

            .join-btn:disabled {
                background-color: #6c757d;
                cursor: not-allowed;
            }

            .no-clubs {
                text-align: center;
                color: #7f8c8d;
                font-size: 14px;
                margin-top: 20px;
                padding: 15px;
                background-color: #f8f9fa;
                border-radius: 8px;
            }

            .membership-status {
                background-color: #e8f4f4;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 15px;
            }

            .status-title {
                color: #008b8b;
                font-weight: bold;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .status-message {
                color: #2c3e50;
                font-size: 13px;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <img src="image/amin.jpg" alt="Profile Picture">
            <h2>
                <%= session.getAttribute("studName") %><br>
                <%= session.getAttribute("studID") %>
            </h2>
            <div class="menu">
                <a href="studentDashboardPage.jsp">DASHBOARD</a>
                <a href="activities.jsp">ACTIVITIES</a>
                <a href="studentClub.jsp">CLUBS</a>
                <a href="achievements.jsp">ACHIEVEMENTS</a>
                <a href="settings.jsp">SETTINGS</a>
            </div>
        </div>

        <!-- Top Navigation Bar -->
        <div class="topbar">
            <div class="search-container">
                <input type="text" placeholder="Search..." />
                <button class="search-btn">X</button>
            </div>
            <div class="dashboard-title">CLUBS</div>
            <div class="top-icons">
                <img src="image/umpsa.png" alt="UMPSA" class="umpsa-icon">
                <button class="notification-btn" id="notificationBtn">
                    <img src="image/bell.png" alt="Notification">
                </button>
                <div class="notification-dropdown" id="notificationDropdown">
                    <p>No new notifications</p>
                </div>
                <img src="image/amin.jpg" alt="Profile" class="profile-icon">
            </div>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="club-container">
                <%
                    String studIDStr = (String) session.getAttribute("studID");
                    Integer studID = null;
                    if (studIDStr != null) {
                        try {
                            studID = Integer.parseInt(studIDStr);
                        } catch (NumberFormatException e) {
                            studID = null;
                        }
                    }
                    
                    if (studID != null) {
                        List<CLUB> studentClubs = CLUB.getClubsByStudentId(studID);
                        List<CLUB> allClubs = CLUB.getAllClubs();
                %>
                        <!-- Current Membership Section -->
                        <div class="current-membership">
                            <h2 class="section-title">Current Membership</h2>
                            
                            <% if (request.getParameter("message") != null) { %>
                                <div class="message success">
                                    <% if ("joined_successfully".equals(request.getParameter("message"))) { %>
                                        Successfully joined the club!
                                    <% } else if ("left_successfully".equals(request.getParameter("message"))) { %>
                                        Successfully left the club!
                                    <% } %>
                                </div>
                            <% } %>
                            
                            <% if (request.getParameter("error") != null) { %>
                                <div class="message error">
                                    <% 
                                        String error = request.getParameter("error");
                                        if ("student_is_already_a_member_of_a_club".equals(error)) {
                                            out.print("You are already a member of a club. Please leave your current club before joining another one.");
                                        } else if ("club_does_not_exist".equals(error)) {
                                            out.print("The selected club does not exist.");
                                        } else if ("club_is_not_active".equals(error)) {
                                            out.print("The selected club is not active.");
                                        } else if ("failed_to_leave".equals(error)) {
                                            out.print("Failed to leave the club. Please try again.");
                                        } else {
                                            out.print("An error occurred. Please try again.");
                                        }
                                    %>
                                </div>
                            <% } %>

                            <% if (studentClubs != null && !studentClubs.isEmpty()) {
                                for (CLUB club : studentClubs) { %>
                                    <div class="club-card">
                                        <div class="club-name"><%= club.getClubName() %></div>
                                        <div class="club-info"><strong>Description:</strong> <%= club.getClubDesc() %></div>
                                        <div class="club-info"><strong>Contact:</strong> <%= club.getClubContact() %></div>
                                        <div class="club-info"><strong>Status:</strong> <%= club.getClubStatus() %></div>
                                        <div class="club-info"><strong>Established:</strong> <%= club.getClubEstablisedDate() %></div>
                                        <div class="action-buttons">
                                            <form action="ClubMembershipServlet" method="post">
                                                <input type="hidden" name="clubID" value="<%= club.getClubId() %>">
                                                <input type="hidden" name="action" value="leave">
                                                <button type="submit" class="leave-btn">Leave Club</button>
                                            </form>
                                        </div>
                                    </div>
                                <% }
                            } else { %>
                                <div class="membership-status">
                                    <div class="status-title">No Active Membership</div>
                                    <div class="status-message">You are not currently a member of any club. Browse available clubs to join one!</div>
                                </div>
                            <% } %>
                        </div>

                        <!-- Available Clubs Section -->
                        <div class="available-clubs">
                            <h2 class="section-title">Available Clubs</h2>
                            <% 
                                boolean hasActiveClubs = false;
                                for (CLUB club : allClubs) { 
                                    if ("active".equalsIgnoreCase(club.getClubStatus())) {
                                        hasActiveClubs = true;
                            %>
                                        <div class="club-card">
                                            <div class="club-name"><%= club.getClubName() %></div>
                                            <div class="club-info"><strong>Description:</strong> <%= club.getClubDesc() %></div>
                                            <div class="club-info"><strong>Contact:</strong> <%= club.getClubContact() %></div>
                                            <div class="club-info"><strong>Status:</strong> <%= club.getClubStatus() %></div>
                                            <div class="club-info"><strong>Established:</strong> <%= club.getClubEstablisedDate() %></div>
                                            <div class="action-buttons">
                                                <form action="ClubMembershipServlet" method="post">
                                                    <input type="hidden" name="clubID" value="<%= club.getClubId() %>">
                                                    <input type="hidden" name="action" value="join">
                                                    <button type="submit" class="join-btn" 
                                                            <%= (studentClubs != null && !studentClubs.isEmpty()) ? "disabled" : "" %>>
                                                        Join Club
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                            <% }
                                }
                                if (!hasActiveClubs) { %>
                                    <div class="no-clubs">
                                        <p>No active clubs available at the moment.</p>
                                    </div>
                            <% } %>
                        </div>
                <% } else { %>
                        <div class="no-clubs">
                            <p>Please log in to view and join clubs.</p>
                        </div>
                <% } %>
            </div>
        </div>

        <script>
            const notificationBtn = document.getElementById('notificationBtn');
            const notificationDropdown = document.getElementById('notificationDropdown');

            notificationBtn.addEventListener('click', function(event) {
                event.stopPropagation();
                notificationDropdown.classList.toggle('show');
            });

            window.addEventListener('click', function(event) {
                if (!notificationDropdown.contains(event.target) && !notificationBtn.contains(event.target)) {
                    notificationDropdown.classList.remove('show');
                }
            });
        </script>
    </body>
</html>
