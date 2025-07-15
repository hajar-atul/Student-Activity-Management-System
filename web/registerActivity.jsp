<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ACTIVITY, model.STUDENT" %>
<%
    String activityID = request.getParameter("activityID");
    ACTIVITY activity = null;
    if (activityID != null) {
        activity = ACTIVITY.getActivityById(activityID);
    }
    STUDENT student = (STUDENT) session.getAttribute("student");
    boolean isPaid = (activity != null && activity.getActivityFee() > 0);
    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register for Activity</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body { height: 100%; overflow: hidden; font-family: Arial, sans-serif; background-color: #f0f0f0; }
    .sidebar { width: 250px; background-color: #008b8b; color: white; padding: 20px; height: 100vh; position: fixed; left: 0; top: 0; z-index: 1001; display: flex; flex-direction: column; transition: transform 0.3s ease; }
    .sidebar.closed { transform: translateX(-100%); }
    .toggle-btn { position: fixed; top: 20px; left: 20px; background-color: #008b8b; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; z-index: 1002; }
    .sidebar img.profile-pic { width: 100px; aspect-ratio: 1 / 1; border-radius: 50%; object-fit: cover; margin: 0 auto 15px; display: block; border: 3px solid white; box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); }
    .sidebar h2 {
        color: white !important;
    }
    .menu { margin-top: 30px; }
    .menu a { display: block; padding: 10px; background-color: #0a6d6d; margin-top: 10px; text-decoration: none; color: white; border-radius: 5px; text-align: center; }
    .logout-container { margin-top: auto; padding-top: 20px; }
    .LOGOUT-btn { display: block; width: 100%; padding: 10px; background-color: #d82215d2; color: white; border: none; border-radius: 5px; text-align: center; font-size: 16px; font-weight: bold; transition: background-color 0.2s; cursor: pointer; }
    .LOGOUT-btn:hover { background-color: #b71c1c; }
    .topbar { position: fixed; top: 0; left: 0; right: 0; height: 80px; background-color: #008b8b; color: white; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; }
    .search-container { display: flex; align-items: center; margin-left: 250px; transition: margin-left 0.3s ease; }
    .sidebar.closed ~ .topbar .search-container { margin-left: 70px; }
    .search-container input { padding: 8px 12px; border-radius: 20px; border: none; outline: none; width: 200px; }
    .search-btn { background: white; border: none; margin-left: -30px; cursor: pointer; font-weight: bold; border-radius: 50%; padding: 4px 8px; color: #009B9D; }
    .dashboard-title { font-size: 26px; font-weight: bold; text-align: center; flex-grow: 1; margin-left: 60px; }
    .top-icons { display: flex; align-items: center; gap: 15px; }
    .top-icons img.umpsa-icon { width: 40px; height: 40px; }
    .notification-btn img, .profile-icon { width: 36px; height: 36px; border-radius: 50%; cursor: pointer; }
    .notification-dropdown, .profile-dropdown { display: none; position: absolute; top: 80px; right: 30px; background: white; color: black; min-width: 200px; box-shadow: 0 2px 8px rgba(0,0,0,0.2); z-index: 999; border-radius: 8px; overflow: hidden; }
    .notification-dropdown.show, .profile-dropdown.show { display: block; }
    .notification-dropdown p, .profile-dropdown a { margin: 0; padding: 10px 20px; border-bottom: 1px solid #eee; text-decoration: none; color: black; display: block; }
    .profile-dropdown a:hover { background-color: #f0f0f0; }
    .content { padding: 100px 30px 20px 30px; margin-left: 250px; min-height: 100vh; overflow-y: auto; transition: margin-left 0.3s ease; }
    @media (max-width: 768px) { .content { margin-left: 0; padding: 100px 10px 20px 10px; } .sidebar { position: static; width: 100%; height: auto; } .toggle-btn { display: block; } }
    @media (max-width: 480px) { .dashboard-title { font-size: 18px; margin-left: 20px; } .content { padding: 100px 5px 20px 5px; } }
    /* Registration form styles */
    .container-inner {
      max-width: 1500px;
      min-width: 1200px;
      height: 700px;
      margin: 40px auto;
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 8px 32px rgba(0,121,107,0.10);
      padding: 56px 60px;
      display: flex;
      flex-direction: row;
      align-items: flex-start;
      gap: 80px;
      overflow: hidden;
    }
    .form-horizontal {
      display: flex;
      flex-direction: row;
      gap: 32px;
      width: 100%;
      align-items: flex-start;
      justify-content: center;
    }
    .form-group {
      display: flex;
      flex-direction: column;
      min-width: 180px;
      flex: 1 1 0;
      margin-bottom: 0;
    }
    .poster-col {
      flex: 0 0 420px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      gap: 24px;
      height: 100%;
      background: none;
    }
    .poster-col img {
      max-width: 380px;
      max-height: 520px;
      border-radius: 16px;
      box-shadow: 0 2px 16px rgba(0,121,107,0.08);
      background: #f4f8f7;
      border: none;
      transition: box-shadow 0.3s;
    }
    .poster-col .no-poster {
      color: #b0b0b0;
      font-size: 16px;
      text-align: center;
      margin-top: 60px;
      font-style: italic;
    }
    .form-fields-col {
      flex: 1 1 0;
      display: flex;
      flex-direction: column;
      gap: 32px;
      height: 100%;
      justify-content: center;
      background: none;
    }
    h2 {
      text-align: left;
      color: #00796B;
      margin-bottom: 8px;
      font-size: 1.5em;
      font-weight: 600;
      letter-spacing: 0.5px;
    }
    .form-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
      min-width: 220px;
      margin-bottom: 0;
    }
    label {
      font-weight: 500;
      color: #00796B;
      font-size: 15px;
      margin-bottom: 2px;
      letter-spacing: 0.2px;
    }
    input[type="text"], input[type="file"] {
      width: 100%;
      padding: 14px 16px;
      border: 1.5px solid #e0e0e0;
      border-radius: 8px;
      font-size: 1em;
      background: #f8fdfc;
      font-family: 'Poppins', Arial, sans-serif;
      outline: none;
      transition: border 0.2s;
      color: #222;
    }
    input[readonly] {
      background: #e0f7fa;
      color: #333;
      border: 1.5px solid #b2dfdb;
    }
    .fee {
      color: #009688;
      font-weight: 600;
      font-size: 1.1em;
      margin-bottom: 10px;
      background: #e0f7fa;
      border-radius: 6px;
      padding: 8px 16px;
      display: inline-block;
    }
    .qr-section {
      text-align: left;
      margin-bottom: 12px;
      position: relative;
    }
    .qr-section img.qr-thumb {
      max-width: 90px;
      border-radius: 8px;
      background: #f4f8f7;
      border: 1.5px solid #e0e0e0;
      cursor: pointer;
      transition: box-shadow 0.2s, transform 0.2s;
      box-shadow: 0 2px 8px rgba(0,121,107,0.08);
    }
    .qr-section img.qr-thumb:hover {
      box-shadow: 0 8px 32px rgba(0,121,107,0.18);
      transform: scale(1.08);
    }
    .qr-modal {
      display: none;
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(0,0,0,0.55);
      z-index: 2000;
      align-items: center;
      justify-content: center;
      animation: fadeIn 0.3s;
    }
    .qr-modal.active {
      display: flex;
    }
    .qr-modal-content {
      background: #fff;
      border-radius: 18px;
      padding: 32px 32px 24px 32px;
      box-shadow: 0 8px 32px rgba(0,121,107,0.18);
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 18px;
      max-width: 95vw;
      max-height: 90vh;
      animation: popIn 0.25s;
    }
    .qr-modal-content img {
      max-width: 340px;
      max-height: 420px;
      border-radius: 12px;
      background: #f4f8f7;
      border: none;
      box-shadow: 0 2px 16px rgba(0,121,107,0.12);
    }
    .qr-modal-close {
      margin-top: 10px;
      background: #00796B;
      color: #fff;
      border: none;
      border-radius: 6px;
      padding: 8px 24px;
      font-size: 1em;
      font-family: 'Poppins', Arial, sans-serif;
      cursor: pointer;
      transition: background 0.2s;
    }
    .qr-modal-close:hover {
      background: #004d40;
    }
    @keyframes fadeIn {
      from { opacity: 0; } to { opacity: 1; }
    }
    @keyframes popIn {
      from { transform: scale(0.92); opacity: 0.5; } to { transform: scale(1); opacity: 1; }
    }
    .submit-btn {
      background: linear-gradient(90deg, #009688 0%, #00796B 100%);
      color: #fff;
      border: none;
      border-radius: 12px;
      font-size: 1.35em;
      font-weight: 700;
      padding: 22px 0;
      width: 320px;
      max-width: 100%;
      cursor: pointer;
      transition: background 0.2s, box-shadow 0.2s, transform 0.15s;
      margin: 36px auto 0 auto;
      display: block;
      box-shadow: 0 6px 24px rgba(0,150,136,0.13);
      letter-spacing: 1px;
      text-align: center;
    }
    .submit-btn:hover {
      background: linear-gradient(90deg, #00796B 0%, #009688 100%);
      box-shadow: 0 12px 32px rgba(0,150,136,0.18);
      transform: translateY(-2px) scale(1.04);
    }
    
    /* Message styling */
    .message {
      padding: 16px 20px;
      border-radius: 8px;
      margin-bottom: 24px;
      font-weight: 500;
      font-size: 15px;
      text-align: center;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      animation: slideInDown 0.4s ease-out;
    }
    
    @keyframes slideInDown {
      from {
        opacity: 0;
        transform: translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    /* Success Modal Styling */
    .success-modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0,0,0,0.6);
      z-index: 3000;
      align-items: center;
      justify-content: center;
      animation: fadeIn 0.3s;
    }
    
    .success-modal.active {
      display: flex;
    }
    
    .success-modal-content {
      background: #fff;
      border-radius: 18px;
      padding: 40px 40px 32px 40px;
      box-shadow: 0 12px 40px rgba(0,121,107,0.25);
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 24px;
      max-width: 450px;
      width: 90vw;
      text-align: center;
      animation: popIn 0.4s;
    }
    
    .success-icon {
      width: 80px;
      height: 80px;
      background: #008b8b;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 40px;
      color: white;
      animation: bounceIn 0.6s;
    }
    
    .success-title {
      color: #008b8b;
      font-size: 24px;
      font-weight: 700;
      margin: 0;
      letter-spacing: 0.5px;
    }
    
    .success-message {
      color: #555;
      font-size: 16px;
      line-height: 1.5;
      margin: 0;
    }
    
    .success-buttons {
      display: flex;
      gap: 8px;
      margin-top: 8px;
      flex-wrap: wrap;
      justify-content: center;
    }
    
    .success-btn {
      padding: 10px 16px;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s;
      text-decoration: none;
      display: inline-block;
      min-width: 120px;
    }
    
    .success-btn.primary {
      background: #008b8b;
      color: white;
    }
    
    .success-btn.primary:hover {
      background: #006d6d;
      transform: translateY(-1px);
    }
    
    .success-btn.secondary {
      background: #f5f5f5;
      color: #666;
      border: 1px solid #ddd;
    }
    
    .success-btn.secondary:hover {
      background: #e0e0e0;
      color: #333;
    }
    
    @keyframes bounceIn {
      0% {
        transform: scale(0.3);
        opacity: 0;
      }
      50% {
        transform: scale(1.05);
      }
      70% {
        transform: scale(0.9);
      }
      100% {
        transform: scale(1);
        opacity: 1;
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
  <div class="dashboard-title">REGISTER ACTIVITY</div>
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
  <div class="container-inner">
    <% if (error != null) { %>
      <div class="message" style="background:#f8d7da; color:#721c24; border:1px solid #f5c6cb;">
        <%= error %>
      </div>
    <% } %>

    <% if (activity == null) { %>
      <div class="message">Invalid or missing activity. Please go back and try again.</div>
    <% } else if (student == null) { %>
      <div class="message">You must be logged in as a student to register.</div>
    <% } else { %>
      <% if (activity.getPosterImage() != null && activity.getPosterImage().length > 0) { %>
        <div class="poster-col">
          <img src="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=poster" alt="Activity Poster" />
        </div>
      <% } else { %>
        <div class="poster-col">
          <div class="no-poster">No poster image available.</div>
        </div>
      <% } %>
      <div class="form-fields-col">
        <h2>Register for <%= activity.getActivityName() %></h2>
        <form action="RegisterActivityStudentServlet" method="post" enctype="multipart/form-data">
          <input type="hidden" name="activityID" value="<%= activity.getActivityID() %>" />
          <div class="form-group">
            <label>Student Name</label>
            <input type="text" name="studName" value="<%= student.getStudName() %>" readonly />
      </div>
          <div class="form-group">
            <label>Student ID</label>
            <input type="text" name="studID" value="<%= student.getStudID() %>" readonly />
      </div>
          <% if (isPaid) { %>
            <div class="fee">Activity Fee: RM <%= String.format("%.2f", activity.getActivityFee()) %></div>
            <div class="qr-section">
              <label>Scan to Pay (QR):</label><br>
              <% if (activity.getQrImage() != null && activity.getQrImage().length > 0) { %>
                <img src="ActivityImageServlet?activityID=<%= activity.getActivityID() %>&type=qr" alt="QR Payment" class="qr-thumb" id="qrThumb" />
              <% } else { %>
                <div style="color:#888;">No QR image available.</div>
              <% } %>
      </div>
            <div class="form-group">
              <label>Upload Payment Proof (Receipt)</label>
              <input type="file" name="paymentProof" accept="image/*,application/pdf" required />
      </div>
          <% } %>
          <button type="submit" class="submit-btn">Submit Registration</button>
        </form>
      </div>
    <% } %>
      </div>
      </div>
<!-- QR Modal -->
<div class="qr-modal" id="qrModal">
  <div class="qr-modal-content">
    <img src="ActivityImageServlet?activityID=<%= activity != null ? activity.getActivityID() : "" %>&type=qr" alt="QR Code" id="qrModalImg" />
    <button class="qr-modal-close" id="qrModalClose">Close</button>
      </div>
      </div>
      
<!-- Success Modal -->
<div class="success-modal" id="successModal">
  <div class="success-modal-content">
    <div class="success-icon">✓</div>
    <h2 class="success-title">Registration Successful!</h2>
    <p class="success-message" id="successMessage">You have been successfully registered for this activity.</p>
    <div class="success-buttons">
      <a href="activities.jsp" class="success-btn primary">Continue to Activities</a>
      <button class="success-btn secondary" onclick="closeSuccessModal()">Stay Here</button>
    </div>
  </div>
</div>
<script>
  // Set success message from JSP
  var successMessageText = '<%= success != null ? success : "" %>';
  
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

  // QR Modal logic
  const qrThumb = document.getElementById('qrThumb');
  const qrModal = document.getElementById('qrModal');
  
  // Success Modal logic
  const successModal = document.getElementById('successModal');
  const successMessage = document.getElementById('successMessage');
  
  // Show success modal if there's a success message
  if (successMessageText && successMessageText.trim() !== '') {
    successMessage.textContent = successMessageText;
    successModal.classList.add('active');
  }
  
  function closeSuccessModal() {
    successModal.classList.remove('active');
  }
  
  // Close modal when clicking outside
  successModal.addEventListener('click', function(e) {
    if (e.target === successModal) {
      closeSuccessModal();
    }
  });
  const qrModalClose = document.getElementById('qrModalClose');
  if (qrThumb && qrModal && qrModalClose) {
    qrThumb.addEventListener('click', function() {
      qrModal.classList.add('active');
    });
    // Removed mouseenter event for hover
    qrModalClose.addEventListener('click', function() {
      qrModal.classList.remove('active');
    });
    qrModal.addEventListener('click', function(e) {
      if (e.target === qrModal) qrModal.classList.remove('active');
    });
  }
  </script>
</body>
</html> 