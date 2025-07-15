<%--
    Document   : clubSettings
    Created on : Jun 11, 2025, 1:52:51 AM
    Author     : aniqf
--%>

<%@page import="model.CLUB"%>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    if (club == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Settings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { 
          margin: 0; 
          padding: 0; 
          box-sizing: border-box; 
        }
        
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #f0f0f0;
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

        .settings-container {
            max-width: 800px;
            margin: 40px auto;
        }
        
        .form-section {
            background-color: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .profile-picture-section {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            border: 2px dashed #ddd;
            border-radius: 10px;
            background-color: #fafafa;
        }
        
        .current-profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 15px;
            display: block;
            border: 3px solid #0a8079;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .file-input-container {
            position: relative;
            display: inline-block;
            cursor: pointer;
            margin-top: 10px;
        }
        
        .file-input-container input[type="file"] {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        
        .file-input-label {
            display: inline-block;
            padding: 10px 20px;
            background-color: #0a8079;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .file-input-label:hover {
            background-color: #086e68;
        }
        
        .file-info {
            margin-top: 10px;
            font-size: 12px;
            color: #666;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            flex: 1;
            min-width: 0;
            margin-bottom: 20px;
        }
        
        .form-group label {
            font-weight: bold;
            font-size: 16px;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #0a8079;
            outline: none;
        }
        
        .form-group textarea {
            min-height: 80px;
            resize: vertical;
        }
        
        .form-group input[readonly] {
            background-color: #f5f5f5;
            color: #666;
        }
        
        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .password-toggle {
            position: absolute;
            right: 10px;
            background: none;
            border: none;
            cursor: pointer;
            color: #666;
            font-size: 14px;
            padding: 5px;
        }
        
        .password-toggle:hover {
            color: #0a8079;
        }
        
        .password-field {
            padding-right: 40px;
        }
        
        .submit-section {
            text-align: center;
            margin-top: 20px;
        }
        
        .submit-section button {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #0a8079;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .submit-section button:hover {
            background-color: #086e68;
        }

        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            z-index: 1000;
            display: none;
            min-width: 300px;
            text-align: center;
        }
        
        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
            display: none;
        }
        
        .popup.success { border-left: 5px solid #28a745; }
        .popup.error { border-left: 5px solid #dc3545; }
        .popup h3 { margin: 0 0 10px 0; color: #333; }
        .popup p { margin: 0 0 20px 0; color: #666; }
        .popup button {
            background: #0a8079;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .popup button:hover { background: #086e68; }

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

          .settings-container {
            margin: 20px;
          }

          .form-section {
            padding: 20px;
          }
        }

        @media (max-width: 900px) {
            .settings-container, .form-section { 
              max-width: 100%; 
              padding: 10px; 
            }
            .form-row { 
              flex-direction: column; 
              gap: 0; 
            }
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
      <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Profile Picture" class="profile-pic">
      <h3><%= session.getAttribute("clubName") %></h3>
      <ul>
        <li><a href="clubDashboardPage.jsp">DASHBOARD</a></li>
        <li><a href="clubActivitiesPage.jsp">ACTIVITIES</a></li>
        <li><a href="venueBooking.jsp">VENUE BOOKING</a></li>
        <li><a href="resourceReq.jsp">RESOURCE BOOKING</a></li>
        <li><a href="clubFeedback.jsp">FEEDBACK</a></li>
        <li><a href="clubReport.jsp">REPORT</a></li>
        <li><a href="clubSettings.jsp" class="active">SETTINGS</a></li>
      </ul>
      <div style="position: absolute; bottom: 20px; width: 80%; left: 10%; margin-top: 50px; margin-bottom: 25px;">
        <form action="index.jsp">
          <button type="submit" class="activity-btn">Logout</button>
        </form>
      </div>
    </div>

    <div class="main-content" id="mainContent">
      <div class="header">
        <div class="header-title">CLUB SETTINGS</div>
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

      <div class="settings-container">
          <form class="form-section" action="clubSettings" method="post" enctype="multipart/form-data">
              <div class="profile-picture-section">
                  <h3 style="margin-bottom: 20px; color: #0a8079;">Profile Picture</h3>
                  <img src="ClubImageServlet?clubID=<%= club.getClubId() %>" alt="Current Profile" class="current-profile-pic" id="currentProfilePic" />
                  <div class="file-input-container">
                      <input type="file" name="profilePicture" id="profilePicture" accept="image/*" onchange="previewImage(this)" />
                      <label for="profilePicture" class="file-input-label">Choose New Profile Picture</label>
                  </div>
                  <div class="file-info">Supported formats: JPG, PNG, GIF (Max size: 5MB)</div>
              </div>
              <div class="form-row">
                  <div class="form-group">
                      <label>Club Name</label>
                      <input type="text" name="clubName" value="<%= club.getClubName() %>" required />
                  </div>
                  <div class="form-group">
                      <label>Contact</label>
                      <input type="text" name="clubContact" value="<%= club.getClubContact() %>" required />
                  </div>
              </div>
              <div class="form-row">
                  <div class="form-group">
                      <label>Description</label>
                      <textarea name="clubDesc" required><%= club.getClubDesc() %></textarea>
                  </div>
                  <div class="form-group">
                      <label>Established Date</label>
                      <input type="text" name="clubEstablishedDate" value="<%= club.getClubEstablishedDate() %>" readonly disabled />
                  </div>
              </div>
              <div class="form-group password-group">
                  <label>Password</label>
                  <div class="password-container">
                      <input type="password" name="clubPassword" id="clubPassword" value="<%= club.getClubPassword() %>" required class="password-field" />
                      <button type="button" class="password-toggle" onclick="togglePassword()" id="passwordToggle">👁️</button>
                  </div>
              </div>
              <div class="submit-section">
                  <button type="submit">Update</button>
              </div>
              <input type="hidden" id="successMsg" value="<%= message != null ? message : "" %>">
              <input type="hidden" id="errorMsg" value="<%= error != null ? error : "" %>">
          </form>
      </div>
    </div>

    <div class="popup-overlay" id="popupOverlay"></div>
    <div class="popup success" id="successPopup">
        <h3>Success!</h3>
        <p id="successMessage"></p>
        <button onclick="closePopup()">OK</button>
    </div>
    <div class="popup error" id="errorPopup">
        <h3>Error!</h3>
        <p id="errorMessage"></p>
        <button onclick="closePopup()">OK</button>
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

        function showPopup(type, message) {
            const overlay = document.getElementById('popupOverlay');
            const popup = document.getElementById(type + 'Popup');
            const messageElement = document.getElementById(type + 'Message');
            messageElement.textContent = message;
            overlay.style.display = 'block';
            popup.style.display = 'block';
        }
        
        function closePopup() {
            const overlay = document.getElementById('popupOverlay');
            const successPopup = document.getElementById('successPopup');
            const errorPopup = document.getElementById('errorPopup');
            overlay.style.display = 'none';
            successPopup.style.display = 'none';
            errorPopup.style.display = 'none';
        }
        
        function togglePassword() {
            const passwordField = document.getElementById('clubPassword');
            const toggleButton = document.getElementById('passwordToggle');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleButton.textContent = '🙈';
                toggleButton.title = 'Hide password';
            } else {
                passwordField.type = 'password';
                toggleButton.textContent = '👁️';
                toggleButton.title = 'Show password';
            }
        }
        
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const file = input.files[0];
                if (file.size > 5 * 1024 * 1024) {
                    showPopup('error', 'File size must be less than 5MB');
                    input.value = '';
                    return;
                }
                if (!file.type.match('image.*')) {
                    showPopup('error', 'Please select an image file');
                    input.value = '';
                    return;
                }
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('currentProfilePic').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
        
        document.getElementById('popupOverlay').addEventListener('click', function() {
            closePopup();
        });
        
        window.onload = function() {
            var successMsg = document.getElementById('successMsg').value;
            var errorMsg = document.getElementById('errorMsg').value;
            if (successMsg && successMsg.trim() !== '') {
                showPopup('success', successMsg);
            }
            if (errorMsg && errorMsg.trim() !== '') {
                showPopup('error', errorMsg);
            }
        };
        
        document.querySelector('form').addEventListener('submit', function(e) {
            const fileInput = document.getElementById('profilePicture');
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                if (file.size > 5 * 1024 * 1024) {
                    e.preventDefault();
                    showPopup('error', 'File size must be less than 5MB');
                    return;
                }
                if (!file.type.match('image.*')) {
                    e.preventDefault();
                    showPopup('error', 'Please select an image file');
                    return;
                }
            }
        });
    </script>
</body>
</html>
