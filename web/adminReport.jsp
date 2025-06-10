<%@ page import="java.util.List" %>
<%@ page import="Controller.AdminReportServlet.ReportRow" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report</title>
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
        .mail-icon { width: 54px; height: 54px; }
        .menu-icon { font-size: 30px; cursor: pointer; }
        .section-title { font-size: 32px; font-weight: bold; margin-bottom: 0; color: #fff; letter-spacing: 1px; }
        .header .icons { margin-left: auto; display: flex; gap: 20px; }
        .container { padding: 30px 40px; }
        .report-table { background: #fff; border-radius: 10px; padding: 25px; margin-bottom: 30px; }
        .report-table table { width: 100%; border-collapse: collapse; }
        .report-table th, .report-table td { padding: 16px 18px; text-align: center; font-size: 18px; }
        .report-table th { background: #eaf6f6; }
        .report-table td .btn-view { background: #3bbdbd; color: #fff; border: none; padding: 7px 18px; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .report-table td .download-icon { width: 38px; vertical-align: middle; margin-left: 12px; cursor: pointer; }
        .report-table td .status-icon { width: 40px; vertical-align: middle; }
        .more-report-btn { background: #20bebe; color: #fff; border: none; padding: 12px 32px; border-radius: 25px; font-size: 18px; font-weight: bold; float: right; display: flex; align-items: center; gap: 10px; cursor: pointer; margin-top: 40px; }
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
            <div class="header-title">
                <img src="image/filePlusIcon.png" alt="Report" class="mail-icon">
                <span class="menu-icon">&#9776;</span>
                <span class="section-title">Report</span>
            </div>
            <div class="icons">
                <img src="image/umpsa.png" alt="UMP" style="width:28px;">
                <img src="image/bell.png" alt="Bell" style="width:28px;cursor:pointer;" id="bell-icon">
                <div id="notification-dropdown" style="display:none; position:absolute; right:80px; top:70px; background:#fff; color:#333; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.15); min-width:250px; z-index:1000;">
                    <div style="padding:15px; border-bottom:1px solid #eee; font-weight:bold;">Notifications</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">New report submitted</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">Activity proposal checked</div>
                    <div style="padding:12px;">5 new activities approved</div>
                </div>
                <img src="image/mppUMPSA.jpg" alt="User MPP" style="width:28px;" class="round-img">
            </div>
        </div>
        <div class="container">
            <div class="report-table">
                <table border="1">
                    <tr>
                        <th>CLUB</th>
                        <th>ACTIVITY PROPOSAL</th>
                        <th>DATE</th>
                        <th>STATUS</th>
                    </tr>
                    <%
                        List<ReportRow> reports = (List<ReportRow>)request.getAttribute("reports");
                        for (ReportRow r : reports) {
                    %>
                    <tr>
                        <td><%= r.club %></td>
                        <td>
                            <%= r.proposal %>
                            <button class="btn-view">View</button>
                            <img src="image/downloadIcon.png" alt="Download" class="download-icon">
                        </td>
                        <td><%= r.date %></td>
                        <td>
                            <img src="image/checked.png" alt="Checked" class="status-icon">
                            <span style="margin-left:8px;">Checked</span>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <button class="more-report-btn">
                    More Report <span style="font-size:22px;">&#8594;</span>
                </button>
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
