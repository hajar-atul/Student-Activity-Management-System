<%-- 
    Document   : clubFeedback
    Created on : Jun 23, 2025, 5:02:53 PM
    Author     : HP
--%>

<%@page import="java.sql.*, java.util.*" %>
<%@ page import="model.ACTIVITY, model.FEEDBACK, model.STUDENT, model.CLUB" %>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    Integer clubID = null;
    Object clubIdObj = session.getAttribute("clubID");
    if (clubIdObj != null) {
        if (clubIdObj instanceof Integer) {
            clubID = (Integer) clubIdObj;
        } else if (clubIdObj instanceof String) {
            clubID = Integer.parseInt((String) clubIdObj);
        }
    }
    List<Map<String, String>> feedbacks = new ArrayList<Map<String, String>>();
    if (clubID != null) {
        List<ACTIVITY> activities = ACTIVITY.getActivitiesByClubId(clubID);
        for (ACTIVITY activity : activities) {
            List<FEEDBACK> activityFeedbacks = FEEDBACK.getFeedbacksByActivityId(activity.getActivityID());
            for (FEEDBACK fb : activityFeedbacks) {
                Map<String, String> fbMap = new HashMap<String, String>();
                fbMap.put("feedbackID", String.valueOf(fb.getFeedbackId()));
                STUDENT stud = STUDENT.getStudentById(fb.getStudID());
                fbMap.put("studName", stud != null ? stud.getStudName() : "");
                fbMap.put("activityName", activity.getActivityName());
                fbMap.put("feedRating", String.valueOf(fb.getFeedRating()));
                fbMap.put("feedComment", fb.getFeedComment());
                fbMap.put("DateSubmit", fb.getDateSubmit());
                fbMap.put("clubResponse", ""); // Add if you have this field in FEEDBACK
                feedbacks.add(fbMap);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Club Feedback Management</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
              margin: 0;
              padding: 0;
              box-sizing: border-box;
            }

            body { 
              font-family: 'Poppins', Arial, sans-serif; 
              background: #f0f4f8; 
              height: 100vh;
              overflow: hidden;
            }

            .sidebar {
              width: 270px;
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
              min-height: 100vh;
              overflow: hidden;
            }

            .main-content.full-width {
              margin-left: 20px;
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

            .container { 
              max-width: 1200px; 
              margin: 40px auto; 
              background: #fff; 
              border-radius: 18px; 
              box-shadow: 0 4px 24px rgba(0,0,0,0.10); 
              padding: 36px; 
            }
            
            h2 { 
              color: #008b8b; 
              margin-bottom: 24px; 
              font-size: 24px;
              font-weight: 600;
            }
            
            table { 
              width: 100%; 
              border-collapse: collapse; 
            }
            
            th, td { 
              padding: 12px; 
              border-bottom: 1px solid #ccc; 
              text-align: left; 
            }
            
            th { 
              background: #e0f7fa; 
              font-weight: 600;
              color: #00796B;
            }
            
            .response-form textarea { 
              width: 100%; 
              min-height: 40px; 
              border-radius: 6px; 
              border: 1px solid #b2dfdb; 
              padding: 8px; 
              font-family: 'Poppins', Arial, sans-serif; 
              resize: vertical;
            }
            
            .response-form button { 
              background: #008b8b; 
              color: #fff; 
              border: none; 
              border-radius: 6px; 
              padding: 8px 18px; 
              margin-top: 6px; 
              cursor: pointer; 
              font-family: 'Poppins', Arial, sans-serif; 
              font-weight: 500;
              transition: background 0.2s ease;
            }
            
            .response-form button:hover { 
              background: #006d6d; 
            }
            
            .star { 
              color: #FFD700; 
              font-size: 1.2em; 
            }

            @media (max-width: 768px) {
              .sidebar {
                position: static;
              }

              .toggle-btn {
                position: absolute;
                left: 10px;
                top: 10px;
              }

              .main-content {
                margin-left: 20px;
              }

              .header {
                padding: 15px 20px;
              }

              .header-title {
                font-size: 20px;
              }

              .container {
                margin: 20px;
                padding: 20px;
              }

              table {
                font-size: 14px;
              }

              th, td {
                padding: 8px;
              }
            }
        </style>
    </head>
    <body>
        <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

        <div class="sidebar" id="sidebar">
          <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Profile Picture" class="profile-pic">
          <h3><%= session.getAttribute("clubName") %></h3>
          <ul>
            <li><a href="clubDashboardPage.jsp">DASHBOARD</a></li>
            <li><a href="clubActivitiesPage.jsp">ACTIVITIES</a></li>
            <li><a href="venueBooking.jsp">VENUE BOOKING</a></li>
            <li><a href="resourceReq.jsp">RESOURCE BOOKING</a></li>
            <li><a href="clubFeedback.jsp" class="active">FEEDBACK</a></li>
            <li><a href="clubReport.jsp">REPORT</a></li>
            <li><a href="clubSettings.jsp">SETTINGS</a></li>
          </ul>
        </div>

        <div class="main-content" id="mainContent">
          <div class="header">
            <div class="header-title">FEEDBACK MANAGEMENT</div>
            <div class="top-icons">
              <img src="image/umpsa.png" alt="UMPSA Logo" class="umpsa-icon" />
              <button class="notification-btn" id="notificationBtn">
                <img src="image/bell.png" alt="Notifications" />
              </button>
              <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Avatar" class="profile-icon" />
            </div>
          </div>

          <div class="notification-dropdown" id="notificationDropdown">
            <p>No new notifications</p>
          </div>

          <div class="container">
            <h2>Feedback Received</h2>
            <table>
                <tr>
                    <th>Student</th>
                    <th>Activity</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Date</th>
                    <th>Response</th>
                </tr>
                <% for (Map<String, String> fb : feedbacks) { %>
                <tr>
                    <td><%= fb.get("studName") %></td>
                    <td><%= fb.get("activityName") %></td>
                    <td>
                        <% for (int i = 0; i < Integer.parseInt(fb.get("feedRating")); i++) { %>
                            <span class="star">&#9733;</span>
                        <% } %>
                    </td>
                    <td><%= fb.get("feedComment") %></td>
                    <td><%= fb.get("DateSubmit") %></td>
                    <td>
                        <form class="response-form" method="post" action="ClubRespondFeedbackServlet">
                            <input type="hidden" name="feedbackID" value="<%= fb.get("feedbackID") %>">
                            <textarea name="clubResponse" placeholder="Write response..."><%= fb.get("clubResponse") != null ? fb.get("clubResponse") : "" %></textarea>
                            <button type="submit">Save Response</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                <% if (feedbacks.isEmpty()) { %>
                <tr><td colspan="6" style="text-align:center; color:#888;">No feedback available.</td></tr>
                <% } %>
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