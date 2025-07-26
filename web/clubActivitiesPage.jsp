<%-- 
    Document   : ClubActivitiesPage
    Created on : Jun 9, 2025, 10:46:41 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CLUB"%>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    if (club == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Club Activities</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
    }

 /* Sidebar */
        .sidebar {
            width: 270px;
            height: 100vh;
            background-color: #00796B;
            color: white;
            position: fixed;
            padding: 70px 20px 20px 20px;
            overflow: hidden; /* Make unscrollable */
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
            margin-bottom: 10%;
        }
        .activity-btn:hover {
            background-color: #d32f2f;
        }

    /* Toggle Button */
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

    /* Main Content */
    .main-content {
      margin-left: 270px;
      transition: margin-left 0.3s ease;
    }

    .main-content.full-width {
      margin-left: 20px;
    }

    /* Header */
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

    /* New Boxes Section */
    .box-section {
      height: calc(100vh - 100px);
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 40px;
      flex-wrap: wrap;
      padding: 20px;
    }


    .action-box {
      width: 250px;
      height: 250px;
      border: 3px solid #004d40;
      border-radius: 12px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.3s ease;
      text-align: center;
      background-color: white;
    }

    .action-box:hover {
      transform: scale(1.02);
    }

    .action-box.active {
      background-color: #004d40;
      color: white;
    }

    .action-box img {
      width: 90px;
      height: 90px;
      margin-bottom: 15px;
      transition: filter 0.3s ease;
    }

    .action-box.active img {
      filter: brightness(0) invert(1);
    }

    .action-title {
      font-size: 18px;
      font-weight: bold;
    }

    /* Dashboard Buttons */
    .dashboard-btn {
      background: #00796B;
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 0.9em;
      transition: background-color 0.3s ease;
    }

    .dashboard-btn:hover {
      background: #004d40;
    }

    .dashboard-btn.active {
      background: #004d40;
    }

    @media (max-width: 768px) {
      .main-content {
        margin-left: 0 !important;
      }

      .sidebar {
        width: 100%;
        height: auto;
        position: static;
        transform: none !important;
      }

      .toggle-btn {
        position: absolute;
        left: 10px;
        top: 10px;
      }

      .box-section {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>

  <!-- Toggle Sidebar Button -->
  <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Profile Picture" class="profile-pic">
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
    <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
      <form action="index.jsp">
        <button type="submit" class="activity-btn">Logout</button>
      </form>
    </div>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">
    <div class="header">
      <div class="header-title">LIST ACTIVITIES</div>
      <div class="top-icons">
        <img src="image/umpsa.png" alt="Universiti Malaysia Pahang Logo" class="umpsa-icon" />
        <button class="notification-btn" id="notificationBtn">
          <img src="image/bell.png" alt="Notifications" />
        </button>
        <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Avatar" class="profile-icon" />
      </div>
    </div>

    <!-- Notification Dropdown -->
    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>

    <!-- Activities Table Section -->
    <div class="activity-section" style="padding: 40px;">
      <h2 style="text-align:center; font-size: 28px; margin-bottom: 30px;">List Activities</h2>
      
      <!-- Success/Error Messages -->
      <% 
        String successMsg = request.getParameter("success");
        String errorMsg = request.getParameter("error");
        if (successMsg != null) {
      %>
        <div style="background: #c8f7c5; color: #218838; padding: 12px; margin-bottom: 20px; border-radius: 6px; text-align: center; font-weight: 500;">
          <%= successMsg.replace("+", " ") %>
        </div>
      <% } %>
      <% if (errorMsg != null) { %>
        <div style="background: #f8d7da; color: #721c24; padding: 12px; margin-bottom: 20px; border-radius: 6px; text-align: center; font-weight: 500;">
          <%= errorMsg.replace("+", " ") %>
        </div>
      <% } %>     
      <div style="margin-bottom: 20px; display: flex; gap: 10px; align-items: center;">
        <span style="font-weight: 500;">Sort:</span>
        <form method="get" style="display:inline;">
          <button type="submit" name="status" value="All" class="dashboard-btn">All</button>
          <button type="submit" name="status" value="Approved" class="dashboard-btn">Approve</button>
          <button type="submit" name="status" value="Reject" class="dashboard-btn">Rejected</button>
          <button type="submit" name="status" value="Pending" class="dashboard-btn">Pending</button>
        </form>
      </div>
      <table style="width:100%; border-collapse:collapse; background:white; box-shadow:0 2px 8px rgba(0,0,0,0.07);">
        <thead style="background:#e0f7fa;">
          <tr>
            <th style="padding:12px; text-align:left;">Activity ID</th>
            <th style="padding:12px; text-align:left;">Activity Name</th>
            <th style="padding:12px; text-align:left;">Date</th>
            <th style="padding:12px; text-align:left;">Venue</th>
            <th style="padding:12px; text-align:left;">Status</th>
            <th style="padding:12px; text-align:left;">Participants</th>
            <th style="padding:12px; text-align:left;">Actions</th>
          </tr>
        </thead>
        <tbody>
          <%-- Java code to fetch and display activities --%>
          <%
            String filterStatus = request.getParameter("status");
            java.util.List<model.ACTIVITY> activities = new java.util.ArrayList<model.ACTIVITY>();
            if (club != null) {
              int clubId = club.getClubId();
              activities = model.ACTIVITY.getActivitiesByClubId(clubId);
              if (filterStatus != null && !filterStatus.equals("All")) {
                java.util.Iterator<model.ACTIVITY> it = activities.iterator();
                while (it.hasNext()) {
                  model.ACTIVITY act = it.next();
                  if ("Reject".equalsIgnoreCase(filterStatus) || "Rejected".equalsIgnoreCase(filterStatus)) {
                      if (!("Rejected".equalsIgnoreCase(act.getActivityStatus()) || "Reject".equalsIgnoreCase(act.getActivityStatus()))) {
                          it.remove();
                      }
                  } else if (!act.getActivityStatus().equalsIgnoreCase(filterStatus)) {
                      it.remove();
                  }
                }
              }
              // Sort activities by date descending (latest first)
              java.util.Collections.sort(activities, new java.util.Comparator<model.ACTIVITY>() {
                public int compare(model.ACTIVITY a1, model.ACTIVITY a2) {
                  if (a1.getActivityDate() == null) return 1;
                  if (a2.getActivityDate() == null) return -1;
                  return a2.getActivityDate().compareTo(a1.getActivityDate());
                }
              });
            }
            for (model.ACTIVITY act : activities) {
              int participantCount = model.ACTIVITY.getParticipantCount(act.getActivityID());
          %>
          <tr>
            <td style="padding:10px; border-bottom:1px solid #eee;"><%= act.getActivityID() %></td>
            <td style="padding:10px; border-bottom:1px solid #eee;"><%= act.getActivityName() %></td>
            <td style="padding:10px; border-bottom:1px solid #eee;"><%= act.getActivityDate() %></td>
            <td style="padding:10px; border-bottom:1px solid #eee;"><%= act.getActivityVenue() != null ? act.getActivityVenue() : "-" %></td>
            <td style="padding:10px; border-bottom:1px solid #eee;">
              <% if ("Approved".equalsIgnoreCase(act.getActivityStatus())) { %>
                <span style="background:#c8f7c5; color:#218838; padding:4px 12px; border-radius:12px; font-weight:500;">Approved</span>
              <% } else if ("Pending".equalsIgnoreCase(act.getActivityStatus())) { %>
                <span style="background:#fff3cd; color:#856404; padding:4px 12px; border-radius:12px; font-weight:500;">Pending</span>
              <% } else if ("Rejected".equalsIgnoreCase(act.getActivityStatus()) || "Reject".equalsIgnoreCase(act.getActivityStatus())) { %>
                <span style="background:#f8d7da; color:#721c24; padding:4px 12px; border-radius:12px; font-weight:500;">Rejected</span>
              <% } else { %>
                <span style="background:#e2e3e5; color:#383d41; padding:4px 12px; border-radius:12px; font-weight:500;"><%= act.getActivityStatus() %></span>
              <% } %>
            </td>
            <td style="padding:10px; border-bottom:1px solid #eee; text-align:center;">
              <span style="background:#00796B; color:white; padding:4px 8px; border-radius:12px; font-weight:500; font-size:0.9em;">
                <%= participantCount %>
              </span>
            </td>
            <td style="padding:10px; border-bottom:1px solid #eee; text-align:center;">
              <a href="ActivityParticipantStudentServlet?activityId=<%= act.getActivityID() %>" 
                 style="background:#00796B; color:white; padding:8px 16px; border-radius:5px; text-decoration:none; font-size:0.9em; transition:background-color 0.3s ease;"
                 onmouseover="this.style.background='#004d40'"
                 onmouseout="this.style.background='#00796B'">
                List Participants
              </a>
            </td>
          </tr>
          <% } %>
          <% if (activities.isEmpty()) { %>
          <tr><td colspan="6" style="text-align:center; padding:20px; color:#888;">No activities found.</td></tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Script -->
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

    function selectBox(box) {
      const boxes = document.querySelectorAll('.action-box');
      boxes.forEach(b => b.classList.remove('active'));
      box.classList.add('active');
    }
  </script>

</body>
</html>
