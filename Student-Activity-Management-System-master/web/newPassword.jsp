<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Set New Password - Student Activities Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #e6f2ff;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            background-color: #0a8079;
            color: white;
            padding: 20px 40px;
            display: flex;
            align-items: center;
        }

        .logo {
            height: 60px;
            margin-right: 20px;
        }

        .header-text {
            display: flex;
            flex-direction: column;
        }

        .header-text .welcome {
            font-size: 32px;
            font-weight: bold;
        }

        .header-text .system-name {
            font-size: 22px;
            margin-top: 5px;
        }

        .main-content {
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .new-password-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .new-password-container h2 {
            color: #0a8079;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .button {
            width: 100%;
            padding: 12px;
            background-color: #007b7b;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #005f5f;
        }

        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .success-message {
            color: #28a745;
            background-color: #d4edda;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="image/logoUMP.jpg" alt="Logo" class="logo">
        <div class="header-text">
            <div class="welcome">Welcome To</div>
            <div class="system-name">STUDENT ACTIVITIES MANAGEMENT SYSTEM</div>
        </div>
    </div>

    <div class="main-content">
        <div class="new-password-container">
            <h2>Set New Password</h2>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    <% if (request.getParameter("error").equals("mismatch")) { %>
                        Passwords do not match. Please try again.
                    <% } else if (request.getParameter("error").equals("invalid")) { %>
                        Password must be at least 6 characters long.
                    <% } %>
                </div>
            <% } %>

            <form action="UpdatePasswordServlet" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="studID" value="<%= request.getParameter("studID") %>">
                
                <div class="form-group">
                    <label for="newPassword">New Password:</label>
                    <input type="password" id="newPassword" name="newPassword" required 
                           placeholder="Enter new password">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required 
                           placeholder="Confirm new password">
                </div>

                <button type="submit" class="button">Update Password</button>
            </form>
        </div>
    </div>

    <script>
        function validateForm() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            if (newPassword.length < 6) {
                alert("Password must be at least 6 characters long");
                return false;
            }
            
            if (newPassword !== confirmPassword) {
                alert("Passwords do not match");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html> 