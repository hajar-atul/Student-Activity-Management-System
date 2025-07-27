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
        html, body { height: 100%; overflow: hidden; }
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
        .container { 
          max-width: 1000px; 
          margin: 30px auto; 
          background: #fff; 
          border-radius: 12px; 
          box-shadow: 0 4px 20px rgba(0,0,0,0.08); 
          padding: 30px; 
          overflow: hidden;
        }
        h1 { 
          color: #238B87; 
          margin-bottom: 32px; 
          font-size: 28px;
          font-weight: 600;
          letter-spacing: -0.5px;
        }
        .proposal-info { 
          margin-bottom: 32px; 
        }
        .info-grid {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 16px;
        }
        .info-item {
          display: flex;
          flex-direction: column;
          padding: 16px;
          border: 1px solid #e9ecef;
          border-radius: 8px;
          background: #fafbfc;
          transition: all 0.2s ease;
          min-height: 80px;
        }
        .info-item:hover {
          background-color: #fff;
          border-color: #238B87;
          box-shadow: 0 2px 8px rgba(35, 139, 135, 0.1);
          transform: translateY(-1px);
        }
        .label { 
          font-weight: 600; 
          color: #555; 
          font-size: 11px;
          text-transform: uppercase;
          letter-spacing: 0.5px;
          margin-bottom: 6px;
          color: #238B87;
        }
        .value { 
          color: #333; 
          font-size: 14px;
          line-height: 1.3;
          font-weight: 500;
        }
        .value a {
          color: #238B87;
          text-decoration: none;
          font-weight: 500;
          transition: color 0.2s ease;
        }
        .value a:hover {
          color: #1a7e7c;
          text-decoration: underline;
        }
        .back-btn { 
          background: #238B87; 
          color: #fff; 
          border: none; 
          border-radius: 8px; 
          padding: 12px 24px; 
          font-size: 14px; 
          font-weight: 500;
          cursor: pointer; 
          text-decoration: none; 
          display: inline-flex;
          align-items: center;
          gap: 8px;
          transition: all 0.2s ease;
          margin-bottom: 24px;
        }
        .back-btn:hover { 
          background: #1a7e7c; 
          transform: translateY(-1px);
          box-shadow: 0 4px 12px rgba(35, 139, 135, 0.3);
        }
        .poster-section {
          text-align: center;
          margin-bottom: 32px;
          padding: 24px;
          background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
          border-radius: 12px;
          border: 1px solid #e9ecef;
        }
        .poster-section img {
          max-width: 280px;
          border-radius: 12px;
          box-shadow: 0 8px 24px rgba(0,0,0,0.12);
          cursor: pointer;
          transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .poster-section img:hover {
          transform: scale(1.02);
          box-shadow: 0 12px 32px rgba(0,0,0,0.18);
        }
        .qr-section {
          display: inline-flex;
          align-items: center;
          gap: 12px;
        }
        .qr-section img {
          max-width: 80px;
          border-radius: 8px;
          box-shadow: 0 4px 12px rgba(0,0,0,0.1);
          cursor: pointer;
          transition: transform 0.2s ease;
        }
        .qr-section img:hover {
          transform: scale(1.05);
        }
        .status-badge {
          display: inline-block;
          padding: 6px 12px;
          border-radius: 20px;
          font-size: 12px;
          font-weight: 600;
          text-transform: uppercase;
          letter-spacing: 0.5px;
        }
        .status-pending {
          background-color: #fff3cd;
          color: #856404;
        }
        .status-approved {
          background-color: #d4edda;
          color: #155724;
        }
        .status-rejected {
          background-color: #f8d7da;
          color: #721c24;
        }
        .no-data {
          color: #6c757d;
          font-style: italic;
          font-size: 14px;
        }
        .error-message {
          color: #dc3545;
          background-color: #f8d7da;
          border: 1px solid #f5c6cb;
          border-radius: 8px;
          padding: 16px;
          text-align: center;
          font-weight: 500;
        }
        
        /* Responsive design for smaller screens */
        @media (max-width: 768px) {
          .info-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
          }
          .container {
            max-width: 95%;
            padding: 20px;
            margin: 15px auto;
          }
          .main-content {
            margin-left: 0;
          }
          .sidebar {
            display: none;
          }
        }
        
        @media (max-width: 480px) {
          .info-grid {
            grid-template-columns: 1fr;
            gap: 10px;
          }
          .info-item {
            padding: 12px;
            min-height: 70px;
          }
        }
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
        <a href="adminDashboardPage.jsp" class="back-btn">
            <span>&larr;</span>
            <span>Back to Dashboard</span>
        </a>
        <h1>Activity Proposal Details</h1>
        <% if (activity != null) { %>
        <% if (activity.getPosterImage() != null) { %>
          <div class="poster-section">
            <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=poster" alt="Poster Image" id="posterThumb">
          </div>
          <!-- Modal for full-size poster image -->
          <div id="posterModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.8); align-items:center; justify-content:center;">
            <span id="closeModal" style="position:absolute; top:30px; right:50px; color:#fff; font-size:40px; font-weight:bold; cursor:pointer;">&times;</span>
            <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=poster" alt="Poster Image" style="max-width:80vw; max-height:80vh; border-radius:12px; box-shadow:0 4px 24px rgba(0,0,0,0.25); display:block; margin:auto;">
          </div>
        <% } %>
        
        <div class="proposal-info">
            <div class="info-grid">
                <div class="info-item">
                    <span class="label">Activity ID</span>
                    <span class="value"><%= activity.getActivityID() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Activity Name</span>
                    <span class="value"><%= activity.getActivityName() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Activity Type</span>
                    <span class="value"><%= activity.getActivityType() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Description</span>
                    <span class="value"><%= activity.getActivityDesc() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Date</span>
                    <span class="value"><%= activity.getActivityDate() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Venue</span>
                    <span class="value"><%= activity.getActivityVenue() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Status</span>
                    <span class="value">
                        <span class="status-badge status-<%= activity.getActivityStatus().toLowerCase() %>">
                            <%= activity.getActivityStatus() %>
                        </span>
                    </span>
                </div>
                <div class="info-item">
                    <span class="label">Budget</span>
                    <span class="value">RM <%= activity.getActivityBudget() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Adab Point</span>
                    <span class="value"><%= activity.getAdabPoint() %> points</span>
                </div>
                <div class="info-item">
                    <span class="label">Activity Fee</span>
                    <span class="value">RM <%= activity.getActivityFee() %></span>
                </div>
                <div class="info-item">
                    <span class="label">Proposal File</span>
                    <span class="value">
                        <% if (activity.getProposalFile() != null) { %>
                          <a href="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=proposal" target="_blank">📄 Download Proposal</a>
                        <% } else { %>
                          <span class="no-data">No file uploaded</span>
                        <% } %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="label">QR Code</span>
                    <span class="value">
                        <% if (activity.getQrImage() != null) { %>
                          <div class="qr-section">
                            <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=qr" alt="QR Image" id="qrThumb">
                            <span>Click to enlarge</span>
                          </div>
                          <!-- Modal for full-size QR image -->
                          <div id="qrModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.8); align-items:center; justify-content:center;">
                            <span id="closeQrModal" style="position:absolute; top:30px; right:50px; color:#fff; font-size:40px; font-weight:bold; cursor:pointer;">&times;</span>
                            <img src="ActivityFileServlet?activityID=<%= activity.getActivityID() %>&type=qr" alt="QR Image" style="max-width:60vw; max-height:60vh; border-radius:12px; box-shadow:0 4px 24px rgba(0,0,0,0.25); display:block; margin:auto;">
                          </div>
                        <% } else { %>
                          <span class="no-data">No QR code generated</span>
                        <% } %>
                    </span>
                </div>
            </div>
        </div>
        <% } else { %>
        <div class="error-message">
            <strong>No activity found.</strong><br>
            The requested activity proposal could not be located.
        </div>
        <% } %>
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
    
    // Poster modal functionality
    var posterThumb = document.getElementById('posterThumb');
    var posterModal = document.getElementById('posterModal');
    var closeModal = document.getElementById('closeModal');
    
    if (posterThumb) {
      posterThumb.onclick = function() {
        posterModal.style.display = 'flex';
      };
    }
    
    if (closeModal) {
      closeModal.onclick = function() {
        posterModal.style.display = 'none';
      };
    }
    
    if (posterModal) {
      posterModal.onclick = function(e) {
        if (e.target === this) this.style.display = 'none';
      };
    }
    
    // QR modal functionality
    var qrThumb = document.getElementById('qrThumb');
    var qrModal = document.getElementById('qrModal');
    var closeQrModal = document.getElementById('closeQrModal');
    
    if (qrThumb) {
      qrThumb.onclick = function() {
        qrModal.style.display = 'flex';
      };
    }
    
    if (closeQrModal) {
      closeQrModal.onclick = function() {
        qrModal.style.display = 'none';
      };
    }
    
    if (qrModal) {
      qrModal.onclick = function(e) {
        if (e.target === this) this.style.display = 'none';
      };
    }
  });
</script>
</body>
</html> 