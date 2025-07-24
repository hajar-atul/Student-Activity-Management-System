<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register New Club</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #e6f2ff;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin-left: 0;
        }
        .container {
            width: 100%;
            max-width: 600px;
            background: #fff;
            padding: 30px 40px 40px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        }
        h2 {
            text-align: center;
            color: #0a8079;
            margin-bottom: 30px;
        }
        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 18px;
        }
        .form-row label {
            font-weight: bold;
            width: 180px;
            margin: 0;
            text-align: right;
            margin-right: 18px;
        }
        .form-row input[type="text"],
        .form-row input[type="email"],
        .form-row input[type="password"],
        .form-row textarea {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: #e0ffff;
            font-size: 1em;
        }
        .form-row textarea {
            resize: vertical;
            min-height: 70px;
        }
        .form-row input[readonly] {
            background: #f0f0f0;
        }
        .button {
            width: 100%;
            padding: 12px;
            background-color: #007b7b;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            margin-top: 25px;
            cursor: pointer;
            font-size: 1em;
        }
        .button:hover {
            background-color: #005f5f;
        }
        .error {
            color: red;
            margin-bottom: 15px;
            text-align: center;
        }
        .success {
            color: green;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="container">
            <h2>Register New Club</h2>
            <% if (request.getParameter("error") != null) { %>
                <div class="error"><%= request.getParameter("error") %></div>
            <% } %>
            <% if (request.getParameter("success") != null) { %>
                <div class="success">
                    <%= request.getParameter("success") %><br/>
                    <% if (request.getParameter("clubID") != null && request.getParameter("clubPassword") != null) { %>
                        <strong>Club ID:</strong> <%= request.getParameter("clubID") %><br/>
                        <strong>Club Password:</strong> <%= request.getParameter("clubPassword") %>
                    <% } %>
                </div>
            <% } %>
            <form action="AddClubServlet" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <label for="clubName">Club Name<span style="color:red">*</span>:</label>
                    <input type="text" id="clubName" name="clubName" required>
                </div>
                <div class="form-row">
                    <label for="clubDesc">Club Description<span style="color:red">*</span>:</label>
                    <textarea id="clubDesc" name="clubDesc" required></textarea>
                </div>
                <div class="form-row">
                    <label for="clubEstablishedDate">Established Date<span style="color:red">*</span>:</label>
                    <input type="text" id="clubEstablishedDate" name="clubEstablishedDate" value="<%= LocalDate.now() %>" readonly required>
                </div>
                <div class="form-row">
                    <label for="clubContact">Club Contact (Email)<span style="color:red">*</span>:</label>
                    <input type="email" id="clubContact" name="clubContact" required>
                </div>
                <div class="form-row">
                    <label for="clubPassword">Club Password<span style="color:red">*</span>:</label>
                    <input type="password" id="clubPassword" name="clubPassword" required>
                </div>
                <div class="form-row">
                    <label>Profile Picture <span style='color:red'>*</span></label>
                    <input type="file" name="profilePic" accept="image/png, image/jpeg" required>
                </div>
                <button type="submit" class="button">Register Club</button>
            </form>
        </div>
    </div>
</body>
</html> 