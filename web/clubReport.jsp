<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File, java.io.InputStream, java.io.FileOutputStream, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="model.REPORT" %>
<%
    String message = null;
    boolean submitted = false;
    int clubID = (session.getAttribute("clubID") != null) ? Integer.parseInt(session.getAttribute("clubID").toString()) : 0;
    List activities = new ArrayList(); // [activityID, activityName]
    if (clubID > 0) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC", "root", "");
            stmt = conn.prepareStatement("SELECT activityID, activityName FROM activity WHERE clubID = ?");
            stmt.setInt(1, clubID);
            rs = stmt.executeQuery();
            while (rs.next()) {
                String[] act = new String[2];
                act[0] = rs.getString("activityID");
                act[1] = rs.getString("activityName");
                activities.add(act);
            }
        } catch (Exception e) { e.printStackTrace(); }
        finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String activityIdStr = request.getParameter("activityID");
        String reportDate = request.getParameter("reportDate");
        String remarks = request.getParameter("remarks");
        Part filePart = request.getPart("reportFile");
        int activityID = Integer.parseInt(activityIdStr);
        String fileName = null;
        String filePath = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = application.getRealPath("/reports");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePath = "reports/" + fileName;
            FileOutputStream output = null;
            InputStream input = null;
            try {
                input = filePart.getInputStream();
                output = new FileOutputStream(new File(uploadPath, fileName));
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            } finally {
                try { if (input != null) input.close(); } catch (Exception e) {}
                try { if (output != null) output.close(); } catch (Exception e) {}
            }
        }
        // Save to DB (assume REPORT table has filePath, remarks columns)
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC", "root", "");
            String sql = "INSERT INTO report (clubID, activityID, reportDate, filePath, reportDetails, status) VALUES (?, ?, ?, ?, ?, 'unchecked')";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, clubID);
            stmt.setInt(2, activityID);
            stmt.setString(3, reportDate);
            stmt.setString(4, filePath);
            stmt.setString(5, remarks);
            int result = stmt.executeUpdate();
            if (result > 0) {
                message = "<b>Report submitted successfully!</b>";
                submitted = true;
            } else {
                message = "Failed to submit report.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Club Report</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; margin: 0; padding: 40px; }
        .container {
            max-width: 520px;
            margin: 0 auto;
            background: #fff;
            padding: 38px 44px 32px 44px;
            border-radius: 18px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        }
        h1 { text-align: center; color: #238B87; margin-bottom: 30px; font-size: 2.1em; }
        .form-group { margin-bottom: 22px; }
        label { display: block; font-weight: bold; margin-bottom: 8px; color: #238B87; }
        select, input[type="date"], textarea {
            width: 100%; padding: 10px; border-radius: 7px; border: 1.5px solid #b2dfdb; font-size: 16px; background: #f8f8f8;
        }
        input[type="file"] {
            display: none;
        }
        .file-label {
            display: inline-block;
            background: #e0f7fa;
            color: #00796B;
            padding: 10px 22px;
            border-radius: 7px;
            cursor: pointer;
            font-weight: 500;
            font-size: 16px;
            margin-top: 6px;
            margin-bottom: 6px;
            transition: background 0.2s;
        }
        .file-label:hover {
            background: #b2ebf2;
        }
        .file-name {
            margin-left: 10px;
            font-size: 15px;
            color: #555;
        }
        textarea {
            min-height: 80px;
            resize: vertical;
        }
        .submit-btn {
            width: 100%;
            background: linear-gradient(90deg, #238B87 60%, #00bfa6 100%);
            color: #fff;
            border: none;
            padding: 14px 0;
            border-radius: 8px;
            font-size: 20px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: background 0.2s, transform 0.2s;
        }
        .submit-btn:hover {
            background: linear-gradient(90deg, #00796B 60%, #00bfa6 100%);
            transform: translateY(-2px) scale(1.03);
        }
        .message {
            text-align: center;
            margin-bottom: 20px;
            color: #219a98;
            font-size: 18px;
        }
        .icon-upload {
            vertical-align: middle;
            margin-right: 8px;
        }
    </style>
    <script>
        function showFileName(input) {
            var fileName = input.files[0] ? input.files[0].name : '';
            document.getElementById('fileName').textContent = fileName;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Submit Activity Report</h1>
        <% if (message != null) { %>
            <div class="message"><%= message %></div>
        <% } %>
        <% if (!submitted) { %>
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="activityID">Select Activity</label>
                <select name="activityID" id="activityID" required>
                    <option value="">-- Select Activity --</option>
                    <% for (int i = 0; i < activities.size(); i++) {
                        String[] act = (String[])activities.get(i); %>
                        <option value="<%= act[0] %>"><%= act[1] %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="reportDate">Report Date</label>
                <input type="date" name="reportDate" id="reportDate" value="<%= today %>" required>
            </div>
            <div class="form-group">
                <label for="reportFile">Upload PDF Report</label>
                <label class="file-label" for="reportFile"><span class="icon-upload">📄</span>Choose PDF</label>
                <input type="file" name="reportFile" id="reportFile" accept="application/pdf" required onchange="showFileName(this)">
                <span class="file-name" id="fileName"></span>
            </div>
            <div class="form-group">
                <label for="remarks">Remarks / Description (optional)</label>
                <textarea name="remarks" id="remarks" placeholder="Add any remarks or description..."></textarea>
            </div>
            <button type="submit" class="submit-btn">Submit Report</button>
        </form>
        <% } %>
    </div>
</body>
</html> 