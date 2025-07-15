<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ACTIVITY, model.CLUB" %>
<%
    String activityId = request.getParameter("activityID");
    ACTIVITY activity = (activityId != null) ? ACTIVITY.getActivityById(activityId) : null;
    CLUB club = (activity != null) ? CLUB.getClubById(activity.getClubID()) : null;
    String clubName = (club != null) ? club.getClubName() : "N/A";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Activity Proposal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; }
        .sidebar {
          width: 270px;
          height: 100vh;
          background-color: #238B87;
          color: white;
          position: fixed;
          padding: 30px 20px 20px 20px;
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
          margin-bottom: 10px;
          border: 3px solid white;
          background: #fff;
        }
        .sidebar .mpp-title {
          font-weight: bold;
          font-size: 18px;
          margin-bottom: 30px;
          line-height: 1.2;
          letter-spacing: 1px;
        }
        .sidebar ul {
          list-style: none;
          padding-left: 0;
          margin-top: 20px;
          width: 100%;
        }
        .sidebar ul li {
          margin-bottom: 15px;
        }
        .sidebar ul li a {
          color: white;
          text-decoration: none;
          padding: 12px 0;
          display: block;
          border-radius: 5px;
          font-size: 16px;
          transition: background-color 0.2s ease;
          width: 100%;
        }
        .sidebar ul li a.active, .sidebar ul li a:hover {
          background-color: #1a7e7c;
          font-weight: bold;
        }
        .toggle-btn {
          position: fixed;
          left: 20px;
          top: 20px;
          z-index: 1000;
          background-color: #219a98;
          color: white;
          border: none;
          padding: 10px 15px;
          cursor: pointer;
          border-radius: 5px;
          font-size: 22px;
          display: none;
        }
        .main-content {
          margin-left: 270px;
          transition: margin-left 0.3s ease;
          min-height: 100vh;
        }
        .header {
          display: flex;
          align-items: center;
          background-color: #238B87;
          color: #333;
          padding: 18px 40px 18px 40px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.05);
          position: sticky;
          top: 0;
          z-index: 5;
          gap: 20px;
        }
        .header .top-icons {
          display: flex;
          align-items: center;
          gap: 18px;
          margin-left: auto;
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
          top: 80px;
          right: 60px;
          background-color: white;
          color: black;
          border: 1px solid #ccc;
          border-radius: 8px;
          padding: 10px;
          width: 200px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.15);
          z-index: 100;
        }
        @media (max-width: 900px) {
          .main-content { margin-left: 0; }
          .sidebar { position: static; width: 100%; height: auto; }
          .toggle-btn { display: block; }
        }
        /* Proposal card styles (from previous) */
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #fff;
            padding: 36px 48px;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.10);
        }
        h1 { text-align: center; color: #238B87; margin-bottom: 32px; }
        .detail-row {
            margin-bottom: 18px;
            font-size: 18px;
            display: flex;
            align-items: flex-start;
        }
        .detail-row strong {
            display: inline-block;
            width: 200px;
            color: #00796B;
            font-weight: 600;
        }
        .detail-row span { color: #333; flex: 1; }
        .poster {
            display: block;
            margin: 0 auto 18px auto;
            width: 100%;
            max-width: 340px;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        }
        .actions {
            text-align: center;
            margin-top: 40px;
            display: flex;
            gap: 20px;
            justify-content: center;
        }
        .action-btn {
            text-decoration: none;
            color: #fff;
            padding: 12px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            transition: background 0.2s;
        }
        .approve-btn { background: #4caf50; }
        .reject-btn { background: #f44336; }
        .back-btn { background: #777; }
        .file-link {
            color: #00796B;
            text-decoration: underline;
            font-weight: 500;
        }
        @media (max-width: 700px) {
            .container { padding: 18px 6vw; }
            .detail-row strong { width: 120px; }
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

<button class="toggle-btn" onclick="toggleSidebar()">☰</button>

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
    <button class="toggle-btn" onclick="toggleSidebar()" style="display:block;">☰</button>
    <div class="top-icons">
      <img src="image/umpsa.png" alt="Logo UMP">
      <button class="notification-btn" id="notificationBtn" style="background:none; border:none; cursor:pointer; padding:0;">
        <img src="image/bell.png" alt="Notifications">
      </button>
      <img src="image/mppUMPSA.jpg" alt="Profile" class="profile-icon">
    </div>
  </div>
  <div class="notification-dropdown" id="notificationDropdown">
    <p>No new notifications</p>
  </div>

  <div class="container">
    <h1>Activity Proposal Details</h1>
    <% if (activity != null) { %>
        <% if (activity.getPosterImage() != null && activity.getPosterImage().length > 0) { %>
            <img class="poster" src="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=poster" alt="Activity Poster" />
        <% } %>
        <div class="detail-row">
            <strong>Activity Name:</strong>
            <span><%= activity.getActivityName() %></span>
        </div>
        <div class="detail-row">
            <strong>Club:</strong>
            <span><%= clubName %></span>
        </div>
        <div class="detail-row">
            <strong>Type:</strong>
            <span><%= activity.getActivityType() %></span>
        </div>
        <div class="detail-row">
            <strong>Date:</strong>
            <span><%= activity.getActivityDate() %></span>
        </div>
        <div class="detail-row">
            <strong>Venue:</strong>
            <span><%= activity.getActivityVenue() %></span>
        </div>
        <div class="detail-row">
            <strong>Status:</strong>
            <span><%= activity.getActivityStatus() %></span>
        </div>
        <div class="detail-row">
            <strong>Budget (RM):</strong>
            <span><%= String.format("%.2f", activity.getActivityBudget()) %></span>
        </div>
        <div class="detail-row">
            <strong>Adab Points:</strong>
            <span><%= activity.getAdabPoint() %></span>
        </div>
        <div class="detail-row">
            <strong>Description:</strong>
            <span><%= activity.getActivityDesc() %></span>
        </div>
        <% if (activity.getProposalFile() != null && activity.getProposalFile().length > 0) { %>
        <div class="detail-row">
            <strong>Proposal File:</strong>
            <span><a class="file-link" href="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=proposal" target="_blank">Download/View</a></span>
        </div>
        <% } %>
        <% if ("Approved".equalsIgnoreCase(activity.getActivityStatus()) && activity.getQrImage() != null && activity.getQrImage().length > 0) { %>
        <div class="detail-row">
            <strong>QR Image:</strong>
            <span><a class="file-link" href="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=qr" target="_blank">View QR</a></span>
        </div>
        <% } %>
        <div class="actions">
            <% if ("Pending".equalsIgnoreCase(activity.getActivityStatus())) { %>
                <a href="handleProposal?action=approve&activityID=<%= activity.getActivityID() %>" class="action-btn approve-btn">Approve</a>
                <a href="handleProposal?action=reject&activityID=<%= activity.getActivityID() %>" class="action-btn reject-btn">Reject</a>
            <% } %>
            <a href="adminDashboardPage.jsp" class="action-btn back-btn">Back</a>
        </div>
    <% } else { %>
        <p>Activity not found.</p>
        <div class="actions">
            <a href="adminDashboardPage.jsp" class="action-btn back-btn">Back</a>
        </div>
    <% } %>
  </div>
</div>

<script>
  function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('mainContent');
    sidebar.classList.toggle('closed');
    mainContent.classList.toggle('full-width');
  }
  document.getElementById("notificationBtn").addEventListener("click", function () {
    const dropdown = document.getElementById("notificationDropdown");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
  });
</script>

</body>
</html> 