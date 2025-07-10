<%-- 
    Document   : clubFeedback
    Created on : Jun 23, 2025, 5:02:53 PM
    Author     : HP
--%>

<%@page import="java.sql.*, java.util.*" %>
<%@ page import="model.ACTIVITY, model.FEEDBACK, model.STUDENT" %>
<%
    Integer clubID = null;
    Object clubIdObj = session.getAttribute("clubID");
    if (clubIdObj != null) {
        if (clubIdObj instanceof Integer) {
            clubID = (Integer) clubIdObj;
        } else if (clubIdObj instanceof String) {
            clubID = Integer.parseInt((String) clubIdObj);
        }
    }
    List<Map<String, String>> feedbacks = new ArrayList<Map<String, String>>();
    if (clubID != null) {
        List<ACTIVITY> activities = ACTIVITY.getActivitiesByClubId(clubID);
        for (ACTIVITY activity : activities) {
            List<FEEDBACK> activityFeedbacks = FEEDBACK.getFeedbacksByActivityId(activity.getActivityID());
            for (FEEDBACK fb : activityFeedbacks) {
                Map<String, String> fbMap = new HashMap<String, String>();
                fbMap.put("feedbackID", String.valueOf(fb.getFeedbackId()));
                STUDENT stud = STUDENT.getStudentById(fb.getStudID());
                fbMap.put("studName", stud != null ? stud.getStudName() : "");
                fbMap.put("activityName", activity.getActivityName());
                fbMap.put("feedRating", String.valueOf(fb.getFeedRating()));
                fbMap.put("feedComment", fb.getFeedComment());
                fbMap.put("DateSubmit", fb.getDateSubmit());
                fbMap.put("clubResponse", ""); // Add if you have this field in FEEDBACK
                feedbacks.add(fbMap);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Club Feedback Management</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', Arial, sans-serif; background: #f0f4f8; }
            .container { max-width: 1000px; margin: 40px auto; background: #fff; border-radius: 18px; box-shadow: 0 4px 24px rgba(0,0,0,0.10); padding: 36px; }
            h2 { color: #008b8b; margin-bottom: 24px; }
            table { width: 100%; border-collapse: collapse; }
            th, td { padding: 12px; border-bottom: 1px solid #ccc; text-align: left; }
            th { background: #e0f7fa; }
            .response-form textarea { width: 100%; min-height: 40px; border-radius: 6px; border: 1px solid #b2dfdb; padding: 8px; font-family: 'Poppins', Arial, sans-serif; }
            .response-form button { background: #008b8b; color: #fff; border: none; border-radius: 6px; padding: 8px 18px; margin-top: 6px; cursor: pointer; font-family: 'Poppins', Arial, sans-serif; }
            .response-form button:hover { background: #006d6d; }
            .star { color: #FFD700; font-size: 1.2em; }
            .content {
                margin-left: 250px;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: margin-left 0.3s ease;
                overflow: hidden;
                background: none;
            }
            .dashboard-card {
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.13), 0 0 0 6px #e0f7fa44;
                padding: 0 0 32px 0;
                width: 400px;
                max-width: 95vw;
                margin: 0 auto;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .profile-header {
                width: 400px;
                max-width: 100%;
                background: linear-gradient(90deg, #00bfae 60%, #008b8b 100%);
                border-radius: 22px 22px 0 0;
                padding: 32px 0 18px 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .profile-details {
                width: 90%;
                margin-top: 18px;
                background: #e0f7fa;
                border-radius: 18px;
                padding: 24px 18px 18px 18px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Feedback Received</h2>
            <table>
                <tr>
                    <th>Student</th>
                    <th>Activity</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Date</th>
                    <th>Response</th>
                </tr>
                <% for (Map<String, String> fb : feedbacks) { %>
                <tr>
                    <td><%= fb.get("studName") %></td>
                    <td><%= fb.get("activityName") %></td>
                    <td>
                        <% for (int i = 0; i < Integer.parseInt(fb.get("feedRating")); i++) { %>
                            <span class="star">&#9733;</span>
                        <% } %>
                    </td>
                    <td><%= fb.get("feedComment") %></td>
                    <td><%= fb.get("DateSubmit") %></td>
                    <td>
                        <form class="response-form" method="post" action="ClubRespondFeedbackServlet">
                            <input type="hidden" name="feedbackID" value="<%= fb.get("feedbackID") %>">
                            <textarea name="clubResponse" placeholder="Write response..."><%= fb.get("clubResponse") != null ? fb.get("clubResponse") : "" %></textarea>
                            <button type="submit">Save Response</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                <% if (feedbacks.isEmpty()) { %>
                <tr><td colspan="6" style="text-align:center; color:#888;">No feedback available.</td></tr>
                <% } %>
            </table>
        </div>
    </body>
</html>