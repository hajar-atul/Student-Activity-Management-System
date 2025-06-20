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
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Settings</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #ffffff;
            height: 100vh;
        }
        .header {
            background-color: #0a8079;
            color: white;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
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
            max-width: 400px;
            width: 100%;
        }
        .form-group {
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
            min-height: 60px;
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
            <div class="form-group">
                <label>Club Name</label>
                <input type="text" name="clubName" value="<%= club.getClubName() %>" required />
            </div>
            <div style="display: flex; gap: 4%; flex-wrap: wrap;">
                <div class="form-group" style="flex: 1 1 48%; min-width: 180px;">
                    <label>Contact</label>
                    <input type="text" name="clubContact" value="<%= club.getClubContact() %>" required />
                </div>
                <div class="form-group" style="flex: 1 1 48%; min-width: 180px;">
                    <label>Description</label>
                    <textarea name="clubDesc" required style="min-height: 40px;"><%= club.getClubDesc() %></textarea>
                </div>
                <div class="form-group" style="flex: 1 1 48%; min-width: 180px;">
                    <label>Established Date</label>
                    <input type="text" name="clubEstablishedDate" value="<%= club.getClubEstablisedDate() %>" readonly disabled />
                </div>
                <div class="form-group" style="flex: 1 1 48%; min-width: 180px;">
                    <label>Password</label>
                    <input type="password" name="clubPassword" value="<%= club.getClubPassword() %>" required />
                </div>
            </div>
            <div class="submit-section">
                <button type="submit">Update</button>
            </div>
        </form>
    </div>
</body>
</html>
