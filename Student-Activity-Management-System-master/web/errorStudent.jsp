<%@ page contentType="text/html; charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Student Activities Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffecec;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .error-box {
            background-color: #fff;
            border: 1px solid #f5c2c2;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            width: 500px;
        }

        h1 {
            color: #d8000c;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
        }

        .back-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #d8000c;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }

        .back-btn:hover {
            background-color: #a40000;
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h1>Oops! Something went wrong.</h1>
        <p>We're sorry, but an unexpected error occurred while processing your request.</p>
        <p>Please try again later or contact the administrator if the problem persists.</p>

        <% if (exception != null) { %>
            <p><strong>Error Details:</strong> <%= exception.getMessage() %></p>
        <% } %>

        <a href="index.jsp" class="back-btn">Go Back to Home</a>
    </div>
</body>
</html>
