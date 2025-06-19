<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - Student Activities Management System</title>
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

        .forgot-password-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .forgot-password-container h2 {
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

        input[type="number"] {
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

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #007b7b;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
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
        <div class="forgot-password-container">
            <h2>Forgot Password</h2>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    <% 
                        String error = request.getParameter("error");
                        if (error.equals("not_found")) { %>
                            Student ID not found. Please check your ID and try again.
                        <% } else if (error.equals("invalid_id")) { %>
                            Please enter a valid Student ID.
                        <% } else if (error.equals("invalid_format")) { %>
                            Invalid Student ID format. Please enter numbers only.
                        <% } else if (error.equals("system_error")) { %>
                            System error occurred. Please try again later.
                        <% } %>
                </div>
            <% } %>

            <form action="ForgotPasswordServlet" method="post">
                <div class="form-group">
                    <label for="studID">Enter your Student ID:</label>
                    <input type="number" id="studID" name="studID" required 
                           placeholder="Enter your Student ID">
                </div>

                <button type="submit" class="button">Verify Student ID</button>
            </form>

            <div class="back-link">
                <a href="indexStudent.jsp">Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html> 