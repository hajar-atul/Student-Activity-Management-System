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

            .search-container {
                display: flex;
                align-items: center;
                margin-left: 250px;
                transition: margin-left 0.3s ease;
            }

            .sidebar.closed ~ .topbar .search-container {
                margin-left: 70px;
            }

            .search-container input {
                padding: 8px 12px;
                border-radius: 20px;
                border: none;
                outline: none;
                width: 200px;
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

            .notification-dropdown,
            .profile-dropdown {
                display: none;
                position: absolute;
                top: 80px;
                right: 30px;
                background: white;
                color: black;
                min-width: 200px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.2);
                z-index: 999;
                border-radius: 8px;
                overflow: hidden;
            }

            .notification-dropdown.show,
            .profile-dropdown.show {
                display: block;
            }

            .notification-dropdown p,
            .profile-dropdown a {
                margin: 0;
                padding: 10px 20px;
                border-bottom: 1px solid #eee;
                text-decoration: none;
                color: black;
                display: block;
            }

            .profile-dropdown a:hover {
                background-color: #f0f0f0;
            }
            
            .content {
                padding: 100px 30px 20px 30px;
                margin-left: 250px;
                height: calc(100vh - 100px);
                overflow-y: auto;
                transition: margin-left 0.3s ease;
            }

            .sidebar.closed ~ .content {
                margin-left: 0;
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
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <img src="image/amin.jpg" alt="Profile" class="profile-pic" />
            <h2>
                <%= session.getAttribute("studName") %><br>
                <%= session.getAttribute("studID") %>
            </h2>
            <div class="menu">
                <a href="studentDashboardPage.jsp">DASHBOARD</a>
                <a href="activities.jsp">ACTIVITIES</a>
                <a href="studentClub.jsp">CLUBS</a>
                <a href="settings.jsp">SETTINGS</a>
            </div>
            <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
                <form action="index.jsp">
                    <button type="submit" class="activity-btn">Logout</button>
                </form>
            </div>
        </div>

        <!-- Toggle Button -->
        <button class="toggle-btn" id="toggleBtn">☰</button>

        <!-- Topbar -->
        <div class="topbar">
            <div class="search-container">
                <input type="text" placeholder="Search..." />
                <button class="search-btn">X</button>
            </div>
            <div class="dashboard-title">CLUBS</div>
            <div class="top-icons">
                <img src="image/umpsa.png" class="umpsa-icon" alt="UMPSA">
                <button class="notification-btn" id="notificationBtn">
                    <img src="image/bell.png" alt="Notification">
                </button>
                <div class="notification-dropdown" id="notificationDropdown">
                    <p>No new notifications</p>
                </div>
                <img src="image/amin.jpg" alt="Profile" class="profile-icon" id="profileBtn">
                <div class="profile-dropdown" id="profileDropdown">
                    <a href="profile.jsp">My Profile</a>
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="content" id="content">
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
                                        <div class="club-info"><strong>Established:</strong> <%= club.getClubEstablishedDate() %></div>
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
                                            <div class="club-info"><strong>Established:</strong> <%= club.getClubEstablishedDate() %></div>
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
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.getElementById('toggleBtn');
            const notificationBtn = document.getElementById('notificationBtn');
            const notificationDropdown = document.getElementById('notificationDropdown');
            const profileBtn = document.getElementById('profileBtn');
            const profileDropdown = document.getElementById('profileDropdown');

            toggleBtn.addEventListener('click', () => {
                sidebar.classList.toggle('closed');
            });

            notificationBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                notificationDropdown.classList.toggle('show');
                profileDropdown.classList.remove('show');
            });

            profileBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                profileDropdown.classList.toggle('show');
                notificationDropdown.classList.remove('show');
            });

            window.addEventListener('click', function () {
                notificationDropdown.classList.remove('show');
                profileDropdown.classList.remove('show');
            });
        </script>
    </body>
</html>
