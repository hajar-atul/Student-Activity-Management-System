<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ACTIVITY" %>
<%
    String activityId = request.getParameter("activityID");
    ACTIVITY activity = null;
    if (activityId != null) {
        activity = ACTIVITY.getActivityById(activityId);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Proposal</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; }
        .sidebar {
          width: 270px;
          height: 100vh;
          background-color: #238B87;
          color: white;
          position: fixed;
          padding: 40px 20px 20px 20px;
          overflow-y: auto;
          z-index: 10;
          text-align: center;
          display: flex;
          flex-direction: column;
          align-items: center;
        }
        .sidebar img.profile-pic {
          width: 170px;
          aspect-ratio: 1 / 1;
          border-radius: 50%;
          object-fit: cover;
          margin-bottom: 30px;
          border: 3px solid white;
          background: #fff;
        }
        .sidebar ul {
          list-style: none;
          padding-left: 0;
          width: 100%;
        }
        .sidebar ul li {
          margin-bottom: 15px;
          margin-top: 20px;
        }
        .sidebar ul li a {
          color: white;
          text-decoration: none;
          padding: 13px 0;
          display: block;
          border-radius: 5px;
          font-size: 16px;
          transition: background-color 0.2s ease;
          width: 100%;
          text-align: center;
        }
        .sidebar ul li a.active, .sidebar ul li a:hover {
          background-color: #1a7e7c;
          font-weight: bold;
        }
        .main-content {
          margin-left: 270px;
          min-height: 100vh;
          background: #f6f6f6;
        }
        .header {
          display: flex;
          align-items: center;
          background-color: #238B87;
          color: #fff;
          padding: 18px 40px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.05);
          position: sticky;
          top: 0;
          z-index: 5;
          gap: 20px;
          justify-content: space-between;
        }
        .header-title {
          font-size: 32px;
          font-weight: bold;
          letter-spacing: 1px;
        }
        .header .top-icons {
          display: flex;
          align-items: center;
          gap: 18px;
          position: relative;
        }
        .header .top-icons img {
          width: 45px;
          height: 45px;
          object-fit: contain;
          background: transparent;
        }
        .header .top-icons .profile-icon {
          width: 45px;
          height: 45px;
          border-radius: 50%;
          border: none;
          background: transparent;
        }
        .notification-dropdown {
          display: none;
          position: absolute;
          top: 60px;
          right: 60px;
          background-color: #fff;
          color: #222;
          border: 1px solid #ccc;
          border-radius: 8px;
          padding: 14px 18px;
          width: 240px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.15);
          z-index: 100;
          font-size: 16px;
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
        .container { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.07); padding: 32px; }
        h1 { color: #008b8b; margin-bottom: 24px; }
        .proposal-info { margin-bottom: 32px; }
        .label { font-weight: bold; color: #333; display: inline-block; width: 180px; }
        .value { color: #444; }
        .back-btn { background: #008b8b; color: #fff; border: none; border-radius: 6px; padding: 10px 24px; font-size: 16px; cursor: pointer; text-decoration: none; }
        .back-btn:hover { background: #005f5f; }
    </style>
</head>
<body>

<div class="sidebar" id="sidebar">
  <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-pic">
  <ul>
    <li><a href="adminDashboardPage.jsp" class="active">MANAGE ACTIVITIES</a></li>
    <li><a href="adminStudentList.jsp">STUDENT LIST</a></li>
    <li><a href="adminFeedback.jsp">FEEDBACK</a></li>
    <li><a href="addAdmin.jsp">ADD ADMIN</a></li>
    <li><a href="adminReport.jsp">REPORT</a></li>
  </ul>
  <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
    <form action="index.jsp">
        <button type="submit" class="activity-btn">Logout</button>
    </form>
  </div>
</div>

<div class="main-content" id="mainContent">
  <div class="header">
    <div class="header-title">VIEW PROPOSAL</div>
    <div class="top-icons">
      <img src="image/umpsa.png" alt="UMPSA Logo">
      <img src="image/bell.png" alt="Notifications" id="notificationBtn" style="cursor:pointer;">
      <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-icon">
      <div class="notification-dropdown" id="notificationDropdown">
        <strong>Notifications</strong>
        <ul style="margin:10px 0 0 0; padding:0 0 0 18px;">
          <li>No new notifications</li>
        </ul>
      </div>
    </div>
  </div>
    <div class="container">
        <h1>View Proposal</h1>
        <% if (activity != null) { %>
        <div class="proposal-info">
            <% if (activity.getPosterImage() != null) { %>
              <div style="text-align:center; margin-bottom:24px;">
                <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=poster" alt="Poster Image" style="max-width:220px; border-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.08); cursor:pointer;" id="posterThumb">
              </div>
              <!-- Modal for full-size poster image -->
              <div id="posterModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.7); align-items:center; justify-content:center;">
                <span id="closeModal" style="position:absolute; top:30px; right:50px; color:#fff; font-size:40px; font-weight:bold; cursor:pointer;">&times;</span>
                <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=poster" alt="Poster Image" style="max-width:80vw; max-height:80vh; border-radius:12px; box-shadow:0 4px 24px rgba(0,0,0,0.25); display:block; margin:auto;">
              </div>
              <script>
                document.getElementById('posterThumb').onclick = function() {
                  document.getElementById('posterModal').style.display = 'flex';
                };
                document.getElementById('closeModal').onclick = function() {
                  document.getElementById('posterModal').style.display = 'none';
                };
                document.getElementById('posterModal').onclick = function(e) {
                  if (e.target === this) this.style.display = 'none';
                };
              </script>
            <% } %>
            <div><span class="label">Activity ID:</span> <span class="value"><%= activity.getActivityID() %></span></div>
            <div><span class="label">Name:</span> <span class="value"><%= activity.getActivityName() %></span></div>
            <div><span class="label">Type:</span> <span class="value"><%= activity.getActivityType() %></span></div>
            <div><span class="label">Description:</span> <span class="value"><%= activity.getActivityDesc() %></span></div>
            <div><span class="label">Date:</span> <span class="value"><%= activity.getActivityDate() %></span></div>
            <div><span class="label">Venue:</span> <span class="value"><%= activity.getActivityVenue() %></span></div>
            <div><span class="label">Status:</span> <span class="value"><%= activity.getActivityStatus() %></span></div>
            <div><span class="label">Budget:</span> <span class="value"><%= activity.getActivityBudget() %></span></div>
            <div><span class="label">Adab Point:</span> <span class="value"><%= activity.getAdabPoint() %></span></div>
            <div><span class="label">Proposal File:</span> <span class="value">
                <% if (activity.getProposalFile() != null) { %>
                  <a href="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=proposal" target="_blank">Download Proposal File</a>
                <% } else { %>
                  <span>No file</span>
                <% } %>
            </span></div>
            <div><span class="label">QR Image:</span> <span class="value">
                <% if (activity.getQrImage() != null) { %>
                  <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=qr" alt="QR Image" style="max-width:120px; cursor:pointer;" id="qrThumb">
                  <!-- Modal for full-size QR image -->
                  <div id="qrModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.7); align-items:center; justify-content:center;">
                    <span id="closeQrModal" style="position:absolute; top:30px; right:50px; color:#fff; font-size:40px; font-weight:bold; cursor:pointer;">&times;</span>
                    <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=qr" alt="QR Image" style="max-width:60vw; max-height:60vh; border-radius:12px; box-shadow:0 4px 24px rgba(0,0,0,0.25); display:block; margin:auto;">
                  </div>
                  <script>
                    document.getElementById('qrThumb').onclick = function() {
                      document.getElementById('qrModal').style.display = 'flex';
                    };
                    document.getElementById('closeQrModal').onclick = function() {
                      document.getElementById('qrModal').style.display = 'none';
                    };
                    document.getElementById('qrModal').onclick = function(e) {
                      if (e.target === this) this.style.display = 'none';
                    };
                  </script>
                <% } else { %>
                  <span>No QR image</span>
                <% } %>
            </span></div>
            <div><span class="label">Activity Fee:</span> <span class="value"><%= activity.getActivityFee() %></span></div>
        </div>
        <% } else { %>
        <div class="proposal-info">
            <span style="color:#c00;">No activity found.</span>
        </div>
        <% } %>
        <a href="adminDashboardPage.jsp" class="back-btn">Back</a>
    </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    var bell = document.getElementById('notificationBtn');
    var dropdown = document.getElementById('notificationDropdown');
    bell.addEventListener('click', function(e) {
      e.stopPropagation();
      dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
    });
    document.addEventListener('click', function(e) {
      if (dropdown.style.display === 'block') {
        dropdown.style.display = 'none';
      }
    });
  });
</script>
</body>
</html> 