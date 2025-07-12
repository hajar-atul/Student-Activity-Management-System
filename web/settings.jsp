<%-- 
    Document   : Settings
    Created on : Jun 6, 2025, 3:57:43 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Settings</title>
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

        .settings-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .form-section {
            background-color: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
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
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #008b8b;
            outline: none;
        }

        .form-group textarea {
            min-height: 40px;
            resize: vertical;
        }

        .form-group input[readonly] {
            background-color: #f5f5f5;
            color: #666;
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
            border: 3px solid #008b8b;
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
            background-color: #008b8b;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .file-input-label:hover {
            background-color: #006d6d;
        }

        .file-info {
            margin-top: 10px;
            font-size: 12px;
            color: #666;
        }

        .submit-section {
            text-align: center;
            margin-top: 20px;
        }

        .submit-section button {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #008b8b;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-section button:hover {
            background-color: #006d6d;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
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

        .popup.success {
            border-left: 5px solid #28a745;
        }

        .popup.error {
            border-left: 5px solid #dc3545;
        }

        .popup h3 {
            margin: 0 0 10px 0;
            color: #333;
        }

        .popup p {
            margin: 0 0 20px 0;
            color: #666;
        }

        .popup button {
            background: #008b8b;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .popup button:hover {
            background: #006d6d;
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
            color: #008b8b;
        }

        .password-field {
            padding-right: 40px;
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
        <div class="dashboard-title">SETTINGS</div>
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
        <div class="settings-container">
            <form class="form-section" action="UpdateStudentServlet" method="post" enctype="multipart/form-data">
                <!-- Profile Picture Section -->
                <div class="profile-picture-section">
                    <h3 style="margin-bottom: 20px; color: #008b8b;">Profile Picture</h3>
                    <img src="StudentImageServlet?studID=${studID}" alt="Current Profile" class="current-profile-pic" id="currentProfilePic" />
                    <div class="file-input-container">
                        <input type="file" name="profilePicture" id="profilePicture" accept="image/*" onchange="previewImage(this)" />
                        <label for="profilePicture" class="file-input-label">Choose New Profile Picture</label>
                    </div>
                    <div class="file-info">
                        Supported formats: JPG, PNG, GIF (Max size: 5MB)
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Student ID</label>
                        <input type="text" name="studID" value="<%= session.getAttribute("studID") %>" readonly />
                    </div>
                    <div class="form-group">
                        <label>Student Name</label>
                        <input type="text" name="studName" value="<%= session.getAttribute("studName") %>" required />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="studEmail" value="<%= session.getAttribute("studEmail") %>" required />
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="studNoPhone" value="<%= session.getAttribute("studNoPhone") %>" required />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Course</label>
                        <input type="text" name="studCourse" value="<%= session.getAttribute("studCourse") %>" required />
                    </div>
                    <div class="form-group">
                        <label>Semester</label>
                        <select name="studSemester" required>
                            <option value="1" <%= "1".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 1</option>
                            <option value="2" <%= "2".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 2</option>
                            <option value="3" <%= "3".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 3</option>
                            <option value="4" <%= "4".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 4</option>
                            <option value="5" <%= "5".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 5</option>
                            <option value="6" <%= "6".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 6</option>
                            <option value="7" <%= "7".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 7</option>
                            <option value="8" <%= "8".equals(session.getAttribute("studSemester")) ? "selected" : "" %>>Semester 8</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" value="<%= session.getAttribute("dob") %>" required />
                    </div>
                    <div class="form-group">
                        <label>MUET Status</label>
                        <select name="muetStatus" required>
                            <option value="Not Taken" <%= "Not Taken".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Not Taken</option>
                            <option value="Band 3" <%= "Band 3".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Band 3</option>
                            <option value="Band 3.5" <%= "Band 3.5".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Band 3.5</option>
                            <option value="Band 4" <%= "Band 4".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Band 4</option>
                            <option value="Band 4.5" <%= "Band 4.5".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Band 4.5</option>
                            <option value="Band 5" <%= "Band 5".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Band 5</option>
                            <option value="Band 5.5" <%= "Band 5.5".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Band 5.5</option>
                            <option value="Band 6" <%= "Band 6".equals(session.getAttribute("muetStatus")) ? "selected" : "" %>>Band 6</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Advisor</label>
                        <input type="text" name="advisor" value="<%= session.getAttribute("advisor") %>" required />
                    </div>
                </div>
                <div class="submit-section">
                    <button type="submit">Update Profile</button>
                </div>
            </form>
            
            <!-- Hidden fields for messages -->
            <input type="hidden" id="successMsg" value="<%= request.getParameter("message") != null ? request.getParameter("message") : "" %>">
            <input type="hidden" id="errorMsg" value="<%= request.getParameter("error") != null ? request.getParameter("error") : "" %>">
        </div>
    </div>
    
    <!-- Popup Overlay -->
    <div class="popup-overlay" id="popupOverlay"></div>
    
    <!-- Success Popup -->
    <div class="popup success" id="successPopup">
        <h3>Success!</h3>
        <p id="successMessage"></p>
        <button onclick="closePopup()">OK</button>
    </div>
    
    <!-- Error Popup -->
    <div class="popup error" id="errorPopup">
        <h3>Error!</h3>
        <p id="errorMessage"></p>
        <button onclick="closePopup()">OK</button>
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
        
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const file = input.files[0];
                
                // Check file size (5MB limit)
                if (file.size > 5 * 1024 * 1024) {
                    showPopup('error', 'File size must be less than 5MB');
                    input.value = '';
                    return;
                }
                
                // Check file type
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
        
        // Close popup when clicking on overlay
        document.getElementById('popupOverlay').addEventListener('click', function() {
            closePopup();
        });
        
        // Show popup on page load if there are messages
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
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const fileInput = document.getElementById('profilePicture');
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                
                // Check file size again on submit
                if (file.size > 5 * 1024 * 1024) {
                    e.preventDefault();
                    showPopup('error', 'File size must be less than 5MB');
                    return;
                }
                
                // Check file type again on submit
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
