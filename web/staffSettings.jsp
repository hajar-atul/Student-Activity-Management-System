<%-- 
    Document   : staffSettings
    Created on : 26/7/2025
    Author     : aniq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Settings</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html, body { height: 100%; overflow: hidden; font-family: Arial, sans-serif; background-color: #f0f0f0; }
        .sidebar { width: 250px; background-color: #008b8b; color: white; padding: 20px; height: 100vh; position: fixed; left: 0; top: 0; z-index: 1001; display: flex; flex-direction: column; transition: transform 0.3s ease; }
        .sidebar.closed { transform: translateX(-100%); }
        .toggle-btn { position: fixed; top: 20px; left: 20px; background-color: #008b8b; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; z-index: 1002; }
        .sidebar img.profile-pic { width: 100px; aspect-ratio: 1 / 1; border-radius: 50%; object-fit: cover; margin: 0 auto 15px; display: block; border: 3px solid white; box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); }
        .sidebar h2 { text-align: center; font-size: 14px; margin-top: 10px; }
        .menu { margin-top: 30px; }
        .menu a { display: block; padding: 10px; background-color: #0a6d6d; margin-top: 10px; text-decoration: none; color: white; border-radius: 5px; text-align: center; }
        .activity-btn { width: 100%; padding: 15px; background-color: #f44336; color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: bold; cursor: pointer; transition: background-color 0.2s; margin: 0; }
        .activity-btn:hover { background-color: #d32f2f; }
        .topbar { position: fixed; top: 0; left: 0; right: 0; height: 80px; background-color: #008b8b; color: white; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; }
        .dashboard-title { font-size: 26px; font-weight: bold; text-align: center; flex-grow: 1; margin-left: 60px; }
        .top-icons { display: flex; align-items: center; gap: 15px; }
        .top-icons img.umpsa-icon { width: 40px; height: 40px; }
        .notification-btn img, .profile-icon { width: 36px; height: 36px; border-radius: 50%; cursor: pointer; }
        .notification-dropdown { display: none; position: absolute; top: 80px; right: 40px; background: white; min-width: 250px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); z-index: 2000; padding: 10px 0; border-radius: 8px; color: #333; }
        .notification-dropdown.show { display: block; }
        .notification-dropdown p { margin: 0; padding: 10px 20px; border-bottom: 1px solid #eee; }
        .notification-dropdown p:last-child { border-bottom: none; }
        .notification-btn { background: none; border: none; padding: 0; cursor: pointer; position: relative; }
        .content { flex-grow: 1; padding: 100px 40px 40px 40px; margin-left: 250px; transition: margin-left 0.3s; }
        body.sidebar-collapsed .content { margin-left: 60px; }
        @media (max-width: 768px) { .content { margin-left: 0; } .sidebar { position: static; width: 100%; height: auto; } .toggle-btn { display: block; } }
        .form-section { background-color: white; padding: 30px 40px; border-radius: 10px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); max-width: 600px; margin: 0 auto; }
        .form-group { display: flex; align-items: center; margin-bottom: 20px; }
        .form-group label { flex: 0 0 180px; font-weight: bold; font-size: 16px; margin-bottom: 0; color: #333; text-align: right; margin-right: 24px; }
        .form-group input, .form-group select { flex: 1; padding: 10px; font-size: 14px; background-color: #ffffff; border: 1px solid #ddd; border-radius: 5px; transition: border-color 0.3s ease; }
        .form-group input:focus, .form-group select:focus { border-color: #008b8b; outline: none; }
        .form-group input[readonly] { background-color: #f5f5f5; color: #666; }
        .profile-picture-section { text-align: center; margin-bottom: 30px; padding: 20px; border: 2px dashed #ddd; border-radius: 10px; background-color: #fafafa; }
        .current-profile-pic { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; margin: 0 auto 15px; display: block; border: 3px solid #008b8b; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        .file-input-container { position: relative; display: inline-block; cursor: pointer; margin-top: 10px; }
        .file-input-container input[type="file"] { position: absolute; opacity: 0; width: 100%; height: 100%; cursor: pointer; }
        .file-input-label { display: inline-block; padding: 10px 20px; background-color: #008b8b; color: white; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease; }
        .file-input-label:hover { background-color: #006d6d; }
        .file-info { margin-top: 10px; font-size: 12px; color: #666; }
        .submit-section { text-align: center; margin-top: 20px; }
        .submit-section button { width: 100%; padding: 12px; font-size: 16px; background-color: #008b8b; color: white; font-weight: bold; border: none; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease; }
        .submit-section button:hover { background-color: #006d6d; }
        .popup { position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); z-index: 1000; display: none; min-width: 300px; text-align: center; }
        .popup-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999; display: none; }
        .popup.success { border-left: 5px solid #28a745; }
        .popup.error { border-left: 5px solid #dc3545; }
        .popup h3 { margin: 0 0 10px 0; color: #333; }
        .popup p { margin: 0 0 20px 0; color: #666; }
        .popup button { background: #008b8b; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; }
        .popup button:hover { background: #006d6d; }
        @media (max-width: 700px) {
            .form-section { padding: 20px 5vw; }
            .form-group { flex-direction: column; align-items: stretch; }
            .form-group label { text-align: left; margin-bottom: 6px; margin-right: 0; }
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <img src="StaffImageServlet?staffID=${staffID}" alt="Profile" class="profile-pic" />
    <h2>
        <%= session.getAttribute("staffName") %><br>
        <%= session.getAttribute("staffID") %>
    </h2>
    <div class="menu">
        <a href="<%= request.getContextPath() %>/StaffDashboardServlet">DASHBOARD</a>
        <a href="<%= request.getContextPath() %>/staffBooking.jsp">BOOKING</a>
        <a href="<%= request.getContextPath() %>/StaffAdabPointServlet">ADAB POINT</a>
        <a href="<%= request.getContextPath() %>/addClub.jsp">CLUB REGISTRATION</a>
        <a href="<%= request.getContextPath() %>/addStaff.jsp">ADD STAFF</a>
        <a href="<%= request.getContextPath() %>/staffSettings.jsp">SETTINGS</a>
    </div>
    <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
        <form action="index.jsp" method="get">
            <button type="submit" class="activity-btn">Logout</button>
        </form>
    </div>
</div>
<!-- Toggle Button -->
<button class="toggle-btn" id="toggleBtn">☰</button>
<!-- Topbar -->
<div class="topbar">
    <div class="dashboard-title">STAFF SETTINGS</div>
    <div class="top-icons">
        <img src="image/umpsa.png" class="umpsa-icon" alt="UMPSA">
        <button class="notification-btn" id="notificationBtn">
            <img src="image/bell.png" alt="Notification">
        </button>
        <div class="notification-dropdown" id="notificationDropdown">
            <p>No new notifications</p>
        </div>
        <img src="StaffImageServlet?staffID=${staffID}" alt="Profile" class="profile-icon" id="profileBtn">
    </div>
</div>
<div class="content">
    <div class="settings-container">
        <form class="form-section" action="UpdateStaffServlet" method="post" enctype="multipart/form-data">
            <!-- Profile Picture Section -->
            <div class="profile-picture-section">
                <h3 style="margin-bottom: 20px; color: #008b8b;">Profile Picture</h3>
                <img src="StaffImageServlet?staffID=${staffID}" alt="Current Profile" class="current-profile-pic" id="currentProfilePic" />
                <div class="file-input-container">
                    <input type="file" name="profilePicture" id="profilePicture" accept="image/*" onchange="previewImage(this)" />
                    <label for="profilePicture" class="file-input-label">Choose New Profile Picture</label>
                </div>
                <div class="file-info">
                    Supported formats: JPG, PNG, GIF (Max size: 5MB)
                </div>
            </div>
            <div class="form-group">
                <label>Staff Name</label>
                <input type="text" name="staffName" value="<%= session.getAttribute("staffName") %>" required />
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="staffEmail" value="<%= session.getAttribute("staffEmail") %>" required readonly />
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="staffNoPhone" value="<%= session.getAttribute("staffNoPhone") %>" required />
            </div>
            <div class="form-group">
                <label>Department</label>
                <select name="staffDepartment" required>
                    <option value="">Select Department</option>
                    <option value="Computer Science" <%= "Computer Science".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Computer Science</option>
                    <option value="Engineering" <%= "Engineering".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Engineering</option>
                    <option value="Business" <%= "Business".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Business</option>
                    <option value="Arts" <%= "Arts".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Arts</option>
                    <option value="Science" <%= "Science".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Science</option>
                    <option value="Medicine" <%= "Medicine".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Medicine</option>
                    <option value="Law" <%= "Law".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Law</option>
                    <option value="Education" <%= "Education".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Education</option>
                    <option value="Administration" <%= "Administration".equals(session.getAttribute("staffDepartment")) ? "selected" : "" %>>Administration</option>
                </select>
            </div>
            <div class="submit-section">
                <button type="submit">Update Profile</button>
            </div>
        </form>
        <!-- Hidden fields for messages -->
        <input type="hidden" id="successMsg" value="<%= request.getParameter("message") != null ? request.getParameter("message") : "" %>">
        <input type="hidden" id="errorMsg" value="<%= request.getParameter("error") != null ? request.getParameter("error") : "" %>">
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
</div>
<script>
    const sidebar = document.getElementById('sidebar');
    const toggleBtn = document.getElementById('toggleBtn');
    toggleBtn.addEventListener('click', function() {
        sidebar.classList.toggle('closed');
        document.body.classList.toggle('sidebar-collapsed');
    });
    function showPopup(type, message) { const overlay = document.getElementById('popupOverlay'); const popup = document.getElementById(type + 'Popup'); const messageElement = document.getElementById(type + 'Message'); messageElement.textContent = message; overlay.style.display = 'block'; popup.style.display = 'block'; }
    function closePopup() { const overlay = document.getElementById('popupOverlay'); const successPopup = document.getElementById('successPopup'); const errorPopup = document.getElementById('errorPopup'); overlay.style.display = 'none'; successPopup.style.display = 'none'; errorPopup.style.display = 'none'; }
    function previewImage(input) { if (input.files && input.files[0]) { const file = input.files[0]; if (file.size > 5 * 1024 * 1024) { showPopup('error', 'File size must be less than 5MB'); input.value = ''; return; } if (!file.type.match('image.*')) { showPopup('error', 'Please select an image file'); input.value = ''; return; } const reader = new FileReader(); reader.onload = function(e) { document.getElementById('currentProfilePic').src = e.target.result; }; reader.readAsDataURL(file); } }
    window.onload = function() { var successMsg = document.getElementById('successMsg').value; var errorMsg = document.getElementById('errorMsg').value; if (successMsg && successMsg.trim() !== '') { showPopup('success', successMsg); } if (errorMsg && errorMsg.trim() !== '') { showPopup('error', errorMsg); } };
    document.querySelector('form').addEventListener('submit', function(e) { const fileInput = document.getElementById('profilePicture'); if (fileInput.files.length > 0) { const file = fileInput.files[0]; if (file.size > 5 * 1024 * 1024) { e.preventDefault(); showPopup('error', 'File size must be less than 5MB'); return; } if (!file.type.match('image.*')) { e.preventDefault(); showPopup('error', 'Please select an image file'); return; } } });
</script>
</body>
</html> 