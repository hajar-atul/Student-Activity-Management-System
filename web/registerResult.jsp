<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Result</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .result-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }

        .result-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .success {
            color: #4CAF50;
        }

        .error {
            color: #f44336;
        }

        .message {
            font-size: 20px;
            margin-bottom: 30px;
            color: #333;
        }

        .button-container {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .back-button {
            display: inline-block;
            padding: 12px 30px;
            background-color: #0a8079;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .back-button:hover {
            background-color: #086b65;
        }

        .register-button {
            display: inline-block;
            padding: 12px 30px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .register-button:hover {
            background-color: #45a049;
        }

        .header {
            background-color: #0a8079;
            color: white;
            padding: 20px;
            text-align: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
        }

        .header img {
            height: 60px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="image/logoUMP.jpg" alt="UMP Logo">
    </div>

    <div class="result-container">
        <% 
        String status = request.getParameter("status");
        String message = request.getParameter("message");
        
        if ("success".equals(status)) {
        %>
            <div class="result-icon success">✓</div>
            <div class="message"><%= message %></div>
            <div class="button-container">
                <a href="index.jsp" class="back-button">Back to Login Page</a>
            </div>
        <% } else { %>
            <div class="result-icon error">✕</div>
            <div class="message"><%= message %></div>
            <div class="button-container">
                <a href="registerPage.jsp" class="register-button">Return to Registration</a>
                <a href="index.jsp" class="back-button">Back to Login Page</a>
            </div>
        <% } %>
    </div>
</body>
</html> 