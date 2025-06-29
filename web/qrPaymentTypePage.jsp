<%-- 
    Document   : QRpaymentTypePage
    Created on : Jun 9, 2025, 4:39:52 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.ACTIVITY, model.STUDENT, model.CLUB" %>
<%
    String activityID = request.getParameter("activityID");
    ACTIVITY activity = null;
    STUDENT student = null;
    CLUB club = null;
    
    if (activityID != null) {
        activity = ACTIVITY.getActivityById(activityID);
        if (activity != null) {
            String studIDStr = (String) session.getAttribute("studID");
            if (studIDStr != null) {
                int studID = Integer.parseInt(studIDStr);
                student = STUDENT.getStudentById(studID);
                club = CLUB.getClubById(activity.getClubID());
            }
        }
    }
    
    if (activity == null || student == null) {
        response.sendRedirect("availableActivityList.jsp?error=Invalid+activity+or+student+data");
        return;
    }
    
    // Check if activity is paid
    if (!"Paid".equals(activity.getActivityType())) {
        response.sendRedirect("availableActivityList.jsp?error=This+is+a+free+activity.+Please+use+the+free+registration+page.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Payment - <%= activity.getActivityName() %></title>
  <link href="https://fonts.googleapis.com/css2?family=Arial&display=swap" rel="stylesheet">
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
      display: flex;
      flex-direction: column;
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

    .logout-container {
      margin-top: auto;
      padding-top: 20px;
    }

    .logout-container .LOGOUT-btn {
      display: block;
      width: 100%;
      padding: 10px;
      background-color: #d82215d2;
      color: white;
      border: none;
      border-radius: 5px;
      text-align: center;
      font-size: 16px;
      font-weight: bold;
      transition: background-color 0.2s;
      cursor: pointer;
    }

    .logout-container .LOGOUT-btn:hover {
      background-color: #b71c1c;
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
      margin-left: 250px;
      height: calc(100vh - 80px);
      transition: margin-left 0.3s ease;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      align-items: center;
      padding: 100px 30px 20px 30px;
      box-sizing: border-box;
    }

    .sidebar.closed ~ .content {
      margin-left: 0;
    }

    .payment-container {
      background: white;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      padding: 32px;
      max-width: 500px;
      width: 100%;
      margin: 20px;
    }

    .activity-title {
      text-align: center;
      color: #008b8b;
      font-size: 1.8em;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .activity-info {
      margin-bottom: 20px;
      padding: 15px;
      background: #f8f9fa;
      border-radius: 8px;
    }

    .info-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
      font-size: 0.9em;
    }

    .info-label {
      font-weight: bold;
      color: #00796B;
    }

    .info-value {
      color: #333;
    }

    .qr-section {
      text-align: center;
      margin: 20px 0;
    }

    .qr-section img {
      width: 250px;
      max-width: 100%;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .student-info {
      margin: 20px 0;
      padding: 15px;
      background: #e3f2fd;
      border-radius: 8px;
    }

    .form {
      margin-top: 20px;
    }

    .form label {
      display: block;
      margin: 10px 0 5px;
      font-weight: bold;
      color: #00796B;
    }

    .form input[type="text"],
    .form input[type="file"] {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
      background-color: #f9f9f9;
      margin-bottom: 10px;
    }

    .form input[type="text"] {
      background-color: #eee;
      color: #666;
    }

    .submit-button {
      text-align: center;
      margin-top: 20px;
    }

    .submit-button button {
      padding: 12px 24px;
      background-color: #00796B;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      font-weight: bold;
      transition: background-color 0.2s;
    }

    .submit-button button:hover {
      background-color: #005a4f;
    }

    .back-btn {
      background-color: #008b8b;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      margin-bottom: 20px;
      font-size: 16px;
      transition: background-color 0.2s;
    }

    .back-btn:hover {
      background-color: #006d6d;
    }

    .paid-badge {
      background: #ff9800;
      color: white;
      padding: 4px 12px;
      border-radius: 6px;
      font-size: 0.9em;
      font-weight: bold;
      display: inline-block;
      margin-bottom: 10px;
    }

    @media (max-width: 768px) {
      .content {
        margin-left: 0;
        padding: 100px 15px 20px 15px;
      }
      
      .payment-container {
        margin: 10px;
        padding: 20px;
      }
    }
  </style>
</head>
<body>

   <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <img src="StudentImageServlet?studID=${studID}" alt="Profile" class="profile-pic" />
    <h2>
      <%= session.getAttribute("studName") %><br>
      <%= session.getAttribute("studID") %>
    </h2>
    <div class="menu">
      <a href="studentDashboardPage.jsp">DASHBOARD</a>
      <a href="activities.jsp">ACTIVITIES</a>
      <a href="studentClub.jsp">CLUBS</a>
      <a href="SettingsServlet">SETTINGS</a>
    </div>

    <!-- Logout button fixed at the bottom -->
    <div class="logout-container">
      <form action="index.jsp">
        <button type="submit" class="LOGOUT-btn">Logout</button>
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
    <div class="dashboard-title">PAYMENT</div>
    <div class="top-icons">
      <img src="image/umpsa.png" class="umpsa-icon" alt="UMPSA">
      <button class="notification-btn" id="notificationBtn">
        <img src="image/bell.png" alt="Notification">
      </button>
      <div class="notification-dropdown" id="notificationDropdown">
        <p>No new notifications</p>
      </div>
      <img src="StudentImageServlet?studID=${studID}" alt="Profile" class="profile-icon" id="profileBtn">
      <div class="profile-dropdown" id="profileDropdown">
        <a href="profile.jsp">My Profile</a>
        <a href="logout.jsp">Logout</a>
      </div>
    </div>
  </div>

  <!-- Content -->
  <div class="content" id="content">
    <div class="payment-container">
      <div class="activity-title"><%= activity.getActivityName() %></div>
      <div class="paid-badge">PAID ACTIVITY</div>
      
      <div class="activity-info">
        <div class="info-row">
          <span class="info-label">Organized by:</span>
          <span class="info-value"><%= club != null ? club.getClubName() : "N/A" %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Date:</span>
          <span class="info-value"><%= activity.getActivityDate() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Venue:</span>
          <span class="info-value"><%= activity.getActivityVenue() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Adab Points:</span>
          <span class="info-value"><%= activity.getAdabPoint() %></span>
        </div>
      </div>

      <% if (activity.getQrImage() != null && activity.getQrImage().length > 0) { %>
        <div class="qr-section">
          <h3>Payment QR Code</h3>
          <img src="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=qr" alt="QR Code" />
        </div>
      <% } else { %>
        <div class="qr-section">
          <h3>Payment QR Code</h3>
          <p style="color: #666;">QR code not available</p>
        </div>
      <% } %>

      <div class="student-info">
        <h3>Student Information</h3>
        <div class="info-row">
          <span class="info-label">Name:</span>
          <span class="info-value"><%= student.getStudName() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">ID:</span>
          <span class="info-value"><%= student.getStudID() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Email:</span>
          <span class="info-value"><%= student.getStudEmail() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Course:</span>
          <span class="info-value"><%= student.getStudCourse() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Semester:</span>
          <span class="info-value"><%= student.getStudSemester() %></span>
        </div>
        <div class="info-row">
          <span class="info-label">Phone:</span>
          <span class="info-value"><%= student.getStudNoPhone() %></span>
        </div>
      </div>

      <form id="receiptForm" enctype="multipart/form-data" class="form" action="PaidActivityRegistrationServlet" method="post">
        <input type="hidden" name="activityID" value="<%= activity.getActivityID() %>" />
        
        <label for="paymentType">Payment Method:</label>
        <input type="text" id="paymentType" name="paymentType" value="QR Payment" readonly />

        <label for="receipt">Upload Payment Receipt:</label>
        <input type="file" id="receipt" name="receipt" accept=".jpg,.jpeg,.png,.pdf" required />
        <small style="color: #666; font-size: 0.8em;">Please upload your payment receipt (JPG, PNG, or PDF)</small>

        <div class="submit-button">
          <button type="submit">Submit Receipt & Register</button>
        </div>
      </form>
    </div>

    <!-- BACK BUTTON -->
    <div style="align-self: flex-start;">
      <button class="back-btn" onclick="location.href='availableActivityList.jsp'">← Back to Activities</button>
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

    document.getElementById('receiptForm').addEventListener('submit', function (e) {
      const fileInput = document.getElementById('receipt');
      if (fileInput.files.length === 0) {
        alert("Please select a receipt file.");
        e.preventDefault();
        return;
      }
      
      if (!confirm("Are you sure you want to submit your receipt and register for this activity? You will receive <%= activity.getAdabPoint() %> Adab Points upon successful registration.")) {
        e.preventDefault();
        return;
      }
    });
  </script>

</body>
</html>
