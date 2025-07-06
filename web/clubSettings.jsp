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
    
    // Get messages from request parameters
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Settings</title>
    <style>
        /* Existing CSS */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #ffffff;
            height: 100vh;
            overflow: hidden;
        }
        .header {
            background-color: #0a8079;
            color: white;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 100px;
        }
        .header img {
            height: 60px;
            margin-left: 20px;
        }
        .header h1 {
            font-size: 32px;
            margin-right: 40px;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 100px);
            padding: 20px;
        }
        .form-section {
            background-color: #f8f8f8;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            min-width: 350px;
            max-width: 800px;
            width: 100%;
        }
        /* Changed .form-group to allow it to be full width when not in a row */
        .form-group {
            flex: 1;
            min-width: 0;
            margin-bottom: 20px; /* Added margin-bottom here for consistent spacing */
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
            min-height: 40px;
            resize: vertical;
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
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        /* New or modified styles for responsive/single column behavior */
        .form-row:last-of-type { /* Adjust margin for the last row */
            margin-bottom: 0;
        }

        /* If a form-group is the only child of form-section, make it full width */
        .form-section > .form-group {
            width: 100%;
        }
        /* For the password container specifically if it's in its own row */
        .form-section .form-group.password-group { /* Added this class for specific targeting */
            width: 100%; /* Ensure it takes full width when alone */
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
            background: #0a8079;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .popup button:hover {
            background: #086e68;
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
    </style>
</head>
<body>
    <div class="header">
        <img src="image/logoUMP.jpg" alt="UMP Logo">
        <h1>Club Settings</h1>
        <div style="width: 60px;"></div>
    </div>
    
    <div class="container">
        <form class="form-section" action="clubSettings" method="post">
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
            <div class="form-group password-group"> <%-- Added a specific class for targeting --%>
                <label>Password</label>
                <div class="password-container">
                    <input type="password" name="clubPassword" id="clubPassword" value="<%= club.getClubPassword() %>" required class="password-field" />
                    <button type="button" class="password-toggle" onclick="togglePassword()" id="passwordToggle">👁️</button>
                </div>
            </div>
            <div class="submit-section">
                <button type="submit">Update</button>
            </div>
        </form>
        
        <input type="hidden" id="successMsg" value="<%= message != null ? message : "" %>">
        <input type="hidden" id="errorMsg" value="<%= error != null ? error : "" %>">
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
    </script>
</body>
</html>