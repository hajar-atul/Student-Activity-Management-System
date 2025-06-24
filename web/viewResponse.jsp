<%-- 
    Document   : viewResponse
    Created on : Jun 23, 2025, 5:02:27 PM
    Author     : HP
--%>

<%@page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String activityID = request.getParameter("activityID");
    Integer studID = (Integer) session.getAttribute("studID");
    String clubName = "";
    int feedRating = 0;
    String feedComment = "";
    String dateSubmit = "";
    String clubResponse = "";

    if (activityID != null && studID != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");
            PreparedStatement ps = conn.prepareStatement(
                "SELECT f.feedRating, f.feedComment, f.DateSubmit, f.clubResponse, c.clubName " +
                "FROM feedback f JOIN activity a ON f.activityID = a.activityID " +
                "JOIN club c ON a.clubID = c.clubID " +
                "WHERE f.activityID = ? AND f.studID = ?"
            );
            ps.setString(1, activityID);
            ps.setInt(2, studID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                feedRating = rs.getInt("feedRating");
                feedComment = rs.getString("feedComment");
                dateSubmit = rs.getString("DateSubmit");
                clubResponse = rs.getString("clubResponse");
                clubName = rs.getString("clubName");
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Club Response</title>
        <style>
            body { font-family: 'Poppins', Arial, sans-serif; background: #f0f4f8; }
            .container { max-width: 500px; margin: 60px auto; background: #fff; border-radius: 18px; box-shadow: 0 4px 24px rgba(0,0,0,0.10); padding: 36px; }
            h2 { color: #008b8b; }
            .label { font-weight: bold; color: #008b8b; }
            .response-box { background: #e0ffff; border-radius: 8px; padding: 16px; margin-top: 10px; }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Feedback & Club Response</h2>
            <div><span class="label">Club:</span> <%= clubName %></div>
            <div><span class="label">Your Rating:</span> <%= feedRating %> star(s)</div>
            <div><span class="label">Your Comment:</span> <%= feedComment %></div>
            <div><span class="label">Date Submitted:</span> <%= dateSubmit %></div>
            <hr>
            <div class="label">Club's Response:</div>
            <div class="response-box">
                <%= (clubResponse != null && !clubResponse.trim().isEmpty()) ? clubResponse : "No response yet." %>
            </div>
            <br>
            <button onclick="window.history.back()">Back</button>
        </div>
    </body>
</html>