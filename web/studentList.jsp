<%@ page import="java.util.List" %>
<%@ page import="Controller.StudentListServlet.Activity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student List</title>
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
        .header input[type="text"] { margin-left: 30px; padding: 8px; width: 300px; border-radius: 5px; border: none; }
        .header .icons { margin-left: auto; display: flex; gap: 20px; }
        .container { padding: 30px 40px; }
        .section-title { font-size: 24px; font-weight: bold; margin-bottom: 20px; color: #fff; }
        .top-row { display: flex; gap: 40px; margin-bottom: 20px; }
        .top-row img { width: 150px; height: 100px; object-fit: cover; border-radius: 10px; }
        .top-row .info-box { background: #fff; border-radius: 12px; padding: 28px 45px; display: flex; align-items: center; gap: 20px; border: 2px solid #222; }
        .top-row .info-box img { width: 65px; height: 65px; }
        .top-row .info-box span { font-size: 22px; font-weight: bold; }
        .filters { display: flex; gap: 20px; margin-bottom: 20px; }
        .filters label { font-weight: bold; margin-right: 8px; }
        .filters select { padding: 7px 12px; border-radius: 5px; border: 1px solid #aaa; }
        .activity-table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 10px; overflow: hidden; }
        .activity-table th, .activity-table td { padding: 14px 18px; text-align: center; }
        .activity-table th { background: #eaf6f6; font-size: 18px; }
        .activity-table tr { border-bottom: 1px solid #ccc; }
        .activity-table tr:last-child { border-bottom: none; }
        .btn-view { background: #3bbdbd; color: #fff; border: none; padding: 8px 18px; border-radius: 5px; cursor: pointer; font-size: 15px; }
        .round-img { border-radius: 50%; }
        .header-title {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .mail-icon {
            width: 50px;
            height: 50px;
        }
        .menu-icon {
            font-size: 30px;
            cursor: pointer;
        }
        .section-title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 0;
            color: #fff;
            letter-spacing: 1px;
        }
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
                <img src="image/mail.png" alt="Mail" class="mail-icon">
                <span class="menu-icon">&#9776;</span>
                <span class="section-title">STUDENT LIST</span>
            </div>
            <div class="icons">
                <img src="image/umpsa.png" alt="UMP" style="width:28px;">
                <img src="image/bell.png" alt="Bell" style="width:28px;cursor:pointer;" id="bell-icon">
                <div id="notification-dropdown" style="display:none; position:absolute; right:80px; top:70px; background:#fff; color:#333; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.15); min-width:250px; z-index:1000;">
                    <div style="padding:15px; border-bottom:1px solid #eee; font-weight:bold;">Notifications</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">New student registered for Tech Expo</div>
                    <div style="padding:12px; border-bottom:1px solid #eee;">ROTU Solo Night has 30 students</div>
                    <div style="padding:12px;">Debate Night participation updated</div>
                </div>
                <img src="image/mppUMPSA.jpg" alt="User MPP" style="width:28px;" class="round-img">
            </div>
        </div>
        <div class="container">
            <div class="top-row">
                <img src="image/Graduation.jpg" alt="Graduation"/>
                <div class="info-box">
                    <img src="image/pieChart.png" alt="Faculty"/>
                    <span>Faculty-wise<br>Participation</span>
                </div>
                <div class="info-box">
                    <img src="image/statistic.png" alt="Activity"/>
                    <span>Activity<br>Popularity</span>
                </div>
            </div>
            <div class="filters">
                <div>
                    <label for="club">Filter by Club :</label>
                    <select id="club">
                        <option>Select club</option>
                        <option>IT CLUB</option>
                        <option>ROTU CLUB</option>
                        <option>SOCIETY</option>
                    </select>
                </div>
                <div>
                    <label for="course">Filter by Course :</label>
                    <select id="course">
                        <option>Select Course</option>
                        <option>Software Engineering</option>
                        <option>Mechanical Engineering</option>
                        <option>Business</option>
                    </select>
                </div>
            </div>
            <table class="activity-table">
                <tr>
                    <th>ACTIVITY</th>
                    <th>CLUB</th>
                    <th>STUDENT</th>
                    <th></th>
                </tr>
                <%
                    List<Activity> activities = (List<Activity>)request.getAttribute("activities");
                    for (Activity a : activities) {
                %>
                <tr>
                    <td><%= a.activity %></td>
                    <td><%= a.club %></td>
                    <td><%= a.studentCount %></td>
                    <td><button class="btn-view">View Students</button></td>
                </tr>
                <% } %>
            </table>
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
