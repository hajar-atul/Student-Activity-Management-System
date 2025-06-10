<%@ page import="Controller.AdminDashboardServlet" %>
<%@ page import="java.util.List" %>
<%@ page import="Controller.AdminDashboardServlet.Proposal" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Activity Management System</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #eaf6f6; }
        .sidebar { width: 250px; background: #218c8d; height: 100vh; float: left; color: #fff; }
        .sidebar img { width: 120px; margin: 30px auto 10px auto; display: block; }
        .sidebar h2 { text-align: center; font-size: 18px; margin: 0; }
        .sidebar ul { list-style: none; padding: 0; margin: 40px 0 0 0; }
        .sidebar ul li { padding: 18px 30px; cursor: pointer; text-align: center; display: flex; align-items: center; justify-content: center; background: #008b8b; }
        .sidebar ul li:hover { background: #3bbdbd; }
        .sidebar ul li.active { background: #20bebe; }
        .main { margin-left: 250px; padding: 0; }
        .header { background: #218c8d; padding: 20px; display: flex; align-items: center; }
        .header input[type="text"] { margin-left: 30px; padding: 8px; width: 300px; border-radius: 5px; border: none; }
        .header .icons { margin-left: auto; display: flex; gap: 20px; }
        .container { padding: 30px 40px; }
        .proposal-table { background: #fff; border-radius: 10px; padding: 25px; margin-bottom: 30px; }
        .proposal-table h2 { margin: 0 0 20px 0; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 15px; text-align: center; }
        th { background: #eaf6f6; }
        tr:nth-child(even) { background: #f7f7f7; }
        .btn { border: none; padding: 7px 18px; border-radius: 5px; color: #fff; cursor: pointer; }
        .btn-view { background: #3bbdbd; }
        .btn-approve { background: #4caf50; }
        .btn-reject { background: #f44336; }
        .overview { display: flex; gap: 30px; }
        .overview-box { background: #fff; border-radius: 10px; flex: 1; padding: 25px; display: flex; align-items: center; gap: 20px; }
        .overview-box img { width: 60px; height: 60px; }
        .overview-box .stat { font-size: 28px; font-weight: bold; }
        .overview-box .label { font-size: 16px; color: #888; }
        .round-img { border-radius: 50%; }
    </style>
</head>
<body>
    <div class="sidebar">
        <img src="image/mppUMPSA.jpg" alt="Logo" class="round-img"/>
        <h2>MAJLIS PERWAKILAN PELAJAR</h2>
        <ul>
            <li class="active">MANAGE ACTIVITIES</li>
            <li><a href="studentList.jsp">STUDENT LIST</a></li>
            <li><a href="feedbackAdmin.jsp">FEEDBACK</a></li>
            <li><a href="adminReport.jsp">REPORT</a></li>
        </ul>
    </div>
    <div class="main">
        <div class="header">
            <img src="image/mail.png" alt="Mail" style="width:50px;">
            <span style="font-size:30px;cursor:pointer;margin-left:20px;">&#9776;</span>
            <input type="text" placeholder="Search..."/>
            <div class="icons">
                <img src="image/umpsa.png" alt="UMP" style="width:28px;">
                <img src="image/bell.png" alt="Bell" style="width:28px;cursor:pointer;" id="bell-icon">
                <div id="notification-dropdown" style="display:none; position:absolute; right:80px; top:70px; background:#fff; color:#333; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.15); min-width:250px; z-index:1000;">
                    <div style="padding:15px; border-bottom:1px solid #eee; font-weight:bold;">Notifications</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">New proposal submitted: Tech Expo</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">Charity Run needs approval</div>
                    <div style="padding:12px;">Debate Night scheduled for 15 July</div>
                </div>
                <img src="image/mppUMPSA.jpg" alt="User MPP" style="width:28px;" class="round-img">
            </div>
        </div>
        <div class="container">
            <div class="proposal-table">
                <h2>Proposal Requests</h2>
                <table border="1">
                    <tr>
                        <th>ACTIVITY</th>
                        <th>CLUB</th>
                        <th>DATE</th>
                        <th>ACTION</th>
                    </tr>
                    <%
                        List<Proposal> proposals = AdminDashboardServlet.getProposals();
                        for (Proposal p : proposals) {
                    %>
                    <tr>
                        <td><%= p.activity %></td>
                        <td><%= p.club %></td>
                        <td><%= p.date %></td>
                        <td>
                            <button class="btn btn-view">View</button>
                            <button class="btn btn-approve">Approve</button>
                            <button class="btn btn-reject">Reject</button>
                        </td>
                    </tr>
                    <% } %>
                </table>
            </div>
            <h2>Overview</h2>
            <div class="overview">
                <div class="overview-box">
                    <img src="image/userIcon.png" alt="User Icon"/>
                    <div>
                        <div class="stat"><%= AdminDashboardServlet.getStudentCount() %></div>
                        <div class="label">Student</div>
                    </div>
                </div>
                <div class="overview-box">
                    <img src="image/clubIcon.jpg" alt="Club"/>
                    <div>
                        <div class="stat"><%= AdminDashboardServlet.getClubCount() %></div>
                        <div class="label">Club</div>
                    </div>
                </div>
                <div class="overview-box">
                    <img src="image/statistic.png" alt="Statistic"/>
                    <div>
                        <div class="stat">Statistic</div>
                    </div>
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
