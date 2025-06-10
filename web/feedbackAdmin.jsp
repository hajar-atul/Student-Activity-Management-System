<%@ page import="java.util.List" %>
<%@ page import="Controller.FeedbackAdminServlet.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #eaf6f6; }
        .sidebar { width: 250px; background: #218c8d; height: 100vh; float: left; color: #fff; }
        .sidebar img { width: 120px; margin: 30px auto 10px auto; display: block; border-radius: 50%; }
        .sidebar h2 { text-align: center; font-size: 18px; margin: 0; }
        .sidebar ul { list-style: none; padding: 0; margin: 40px 0 0 0; }
        .sidebar ul li { padding: 18px 30px; cursor: pointer; text-align: center; display: flex; align-items: center; justify-content: center; background: #008b8b; }
        .sidebar ul li.active { background: #20bebe; }
        .sidebar ul li:hover { background: #3bbdbd; }
        .main { margin-left: 250px; padding: 0; }
        .header { background: #218c8d; padding: 20px; display: flex; align-items: center; color: #fff; }
        .header-title { display: flex; align-items: center; gap: 10px; }
        .mail-icon { width: 40px; height: 40px; }
        .menu-icon { font-size: 30px; cursor: pointer; }
        .section-title { font-size: 32px; font-weight: bold; margin-bottom: 0; color: #fff; letter-spacing: 1px; }
        .header .icons { margin-left: auto; display: flex; gap: 20px; }
        .container { padding: 30px 40px; }
        .summary-row { display: flex; gap: 30px; background: #fff; border-radius: 16px; padding: 32px 0 0 0; margin-bottom: 40px; }
        .summary-box { flex: 1; text-align: center; }
        .summary-box img { width: 60px; height: 60px; display: block; margin: 0 auto 12px auto; }
        .summary-label { font-size: 22px; font-weight: bold; }
        .summary-value { font-size: 38px; font-weight: bold; margin-top: 12px; }
        .feedback-table-section { display: flex; gap: 40px; }
        .feedback-table { flex: 2; background: #fff; border-radius: 16px; overflow: hidden; }
        .feedback-table table { width: 100%; border-collapse: collapse; font-size: 20px; }
        .feedback-table th, .feedback-table td { padding: 18px 22px; text-align: left; border: 1px solid #222; }
        .feedback-table th { background: #eaf6f6; text-align: center; font-size: 22px; }
        .feedback-table td { vertical-align: top; }
        .rating-box { flex: 1; background: #fff; border-radius: 16px; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .rating-box img { width: 300px; margin-top: 30px; }
        .round-img { border-radius: 50%; }
    </style>
</head>
<body>
    <div class="sidebar">
        <img src="image/mppUMPSA.jpg" alt="Logo" class="round-img"/>
        <h2>MAJLIS PERWAKILAN PELAJAR</h2>
        <ul>
            <li>MANAGE ACTIVITIES</li>
            <li>STUDENT LIST</li>
            <li class="active">FEEDBACK</li>
            <li>REPORT</li>
        </ul>
    </div>
    <div class="main">
        <div class="header">
            <div class="header-title">
                <img src="image/notes.png" alt="Notes" class="mail-icon">
                <span class="menu-icon">&#9776;</span>
                <span class="section-title">Feedback</span>
            </div>
            <div class="icons">
                <img src="image/umpsa.png" alt="UMP" style="width:28px;">
                <img src="image/bell.png" alt="Bell" style="width:28px;cursor:pointer;" id="bell-icon">
                <div id="notification-dropdown" style="display:none; position:absolute; right:80px; top:70px; background:#fff; color:#333; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.15); min-width:250px; z-index:1000;">
                    <div style="padding:15px; border-bottom:1px solid #eee; font-weight:bold;">Notifications</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">New feedback received</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">Resolved feedback updated</div>
                    <div style="padding:12px;">4 new compliments today</div>
                </div>
                <img src="image/mppUMPSA.jpg" alt="User MPP" style="width:28px;" class="round-img">
            </div>
        </div>
        <div class="container">
            <div class="summary-row">
                <div class="summary-box">
                    <img src="image/Feedback.png" alt="Total Feedback"/>
                    <div class="summary-label">Total Feedback</div>
                    <div class="summary-value"><%= request.getAttribute("totalFeedback") %></div>
                </div>
                <div class="summary-box">
                    <img src="image/resolved.png" alt="Resolved"/>
                    <div class="summary-label">Resolved</div>
                    <div class="summary-value"><%= request.getAttribute("resolved") %></div>
                </div>
                <div class="summary-box">
                    <img src="image/pending.png" alt="Pending"/>
                    <div class="summary-label">Pending</div>
                    <div class="summary-value"><%= request.getAttribute("pending") %></div>
                </div>
                <div class="summary-box">
                    <img src="image/thoughtBubble.png" alt="New Today"/>
                    <div class="summary-label">New Today</div>
                    <div class="summary-value"><%= request.getAttribute("newToday") %></div>
                </div>
            </div>
            <div class="feedback-table-section">
                <div class="feedback-table">
                    <table>
                        <tr>
                            <th>NO</th>
                            <th>NAME</th>
                            <th>Type</th>
                            <th>Summary</th>
                        </tr>
                        <%
                            List<Feedback> feedbacks = (List<Feedback>)request.getAttribute("feedbacks");
                            for (Feedback f : feedbacks) {
                        %>
                        <tr>
                            <td><%= f.no %>.</td>
                            <td><%= f.name %></td>
                            <td><%= f.type %></td>
                            <td><%= f.summary %></td>
                        </tr>
                        <% } %>
                    </table>
                </div>
                <div class="rating-box">
                    <div style="font-weight:bold; font-size:18px; margin-top:10px;">Overall Activities Rating</div>
                    <img src="image/ratingChart.png" alt="Rating Chart"/>
                </div>
            </div>
        </div>
    </div>
    <script>
        // Toggle notification dropdown
        document.addEventListener('DOMContentLoaded', function() {
            var bell = document.getElementById('bell-icon');
            var dropdown = document.getElementById('notification-dropdown');
            bell.addEventListener('click', function(event) {
                event.stopPropagation();
                dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
            });
            // Hide dropdown when clicking outside
            document.addEventListener('click', function(event) {
                if (dropdown.style.display === 'block') {
                    dropdown.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
