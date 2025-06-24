<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.REPORT, model.CLUB" %>
<%
    String reportIdStr = request.getParameter("reportID");
    int reportId = 0;
    if (reportIdStr != null && !reportIdStr.isEmpty()) {
        reportId = Integer.parseInt(reportIdStr);
    }
    REPORT report = null;
    CLUB club = null;
    if (reportId > 0) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC", "root", "");
            java.sql.PreparedStatement updateStmt = conn.prepareStatement("UPDATE report SET status='checked' WHERE reportID=?");
            updateStmt.setInt(1, reportId);
            updateStmt.executeUpdate();
            java.sql.PreparedStatement stmt = conn.prepareStatement("SELECT * FROM report WHERE reportID=?");
            stmt.setInt(1, reportId);
            java.sql.ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                report = new REPORT();
                report.setReportId(rs.getInt("reportID"));
                report.setClubId(rs.getInt("clubID"));
                report.setActivityId(rs.getInt("activityID"));
                report.setReportDate(rs.getString("reportDate"));
                report.setReportDetails(rs.getString("reportDetails"));
                try { report.getClass().getMethod("setFilePath", String.class).invoke(report, rs.getString("filePath")); } catch(Exception e){}
                try { report.getClass().getMethod("setStatus", String.class).invoke(report, rs.getString("status")); } catch(Exception e){}
                club = CLUB.getClubById(report.getClubId());
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Report</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; margin: 0; padding: 40px; }
        .container {
            max-width: 700px;
            margin: 0 auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }
        h1 { text-align: center; color: #238B87; margin-bottom: 30px; }
        .detail-row { margin-bottom: 20px; font-size: 18px; }
        .detail-row strong { display: inline-block; width: 180px; color: #333; }
        .detail-row span { color: #555; }
        .actions { text-align: center; margin-top: 40px; }
        .action-btn { text-decoration: none; color: #fff; padding: 12px 30px; border-radius: 8px; font-size: 16px; font-weight: 500; transition: background 0.2s; background: #238B87; margin: 0 10px; }
        .action-btn:hover { background: #1a7e7c; }
        .download-btn { background: #00bfa6; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Report Details</h1>
        <% if (report != null) { %>
            <div class="detail-row">
                <strong>Club:</strong>
                <span><%= (club != null) ? club.getClubName() : "N/A" %></span>
            </div>
            <div class="detail-row">
                <strong>Activity ID:</strong>
                <span><%= report.getActivityId() %></span>
            </div>
            <div class="detail-row">
                <strong>Report Date:</strong>
                <span><%= report.getReportDate() %></span>
            </div>
            <div class="detail-row">
                <strong>Status:</strong>
                <span style="color:#23bfae;font-weight:bold;">Checked</span>
            </div>
            <div class="detail-row">
                <strong>Report File:</strong>
                <a href="downloadReport.jsp?reportID=<%= report.getReportId() %>" class="action-btn download-btn">Download PDF</a>
            </div>
            <div class="actions">
                <a href="adminReport.jsp" class="action-btn">Back to Report List</a>
            </div>
        <% } else { %>
            <p>Report not found.</p>
        <% } %>
    </div>
</body>
</html> 