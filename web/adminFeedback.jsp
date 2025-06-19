<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Feedback</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; }
    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #238B87;
      color: white;
      position: fixed;
      padding: 40px 20px 20px 20px;
      overflow-y: auto;
      z-index: 10;
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .sidebar img.profile-pic {
      width: 170px;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 30px;
      border: 3px solid white;
      background: #fff;
    }
    .sidebar ul {
      list-style: none;
      padding-left: 0;
      margin-top: 20px;
      width: 100%;
    }
    .sidebar ul li {
      margin-bottom: 15px;
    }
    .sidebar ul li a {
      color: white;
      text-decoration: none;
      padding: 12px 0;
      display: block;
      border-radius: 5px;
      font-size: 16px;
      transition: background-color 0.2s ease;
      width: 100%;
      text-align: center;
    }
    .sidebar ul li a.active, .sidebar ul li a:hover {
      background-color: #1a7e7c;
      font-weight: bold;
    }
    .main-content {
      margin-left: 270px;
      min-height: 100vh;
      background: #f6f6f6;
      padding-bottom: 40px;
    }
    .header {
      display: flex;
      align-items: center;
      background-color: #238B87;
      color: #fff;
      padding: 18px 40px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
      position: sticky;
      top: 0;
      z-index: 5;
      gap: 20px;
      justify-content: flex-start;
    }
    .header-title {
      font-size: 36px;
      font-weight: bold;
      letter-spacing: 1px;
      display: flex;
      align-items: center;
      gap: 16px;
    }
    .header-title img {
      width: 44px;
      height: 44px;
      object-fit: contain;
    }
    .header .top-icons {
      display: flex;
      align-items: center;
      gap: 18px;
      margin-left: auto;
      position: relative;
    }
    .header .top-icons img {
      width: 45px;
      height: 45px;
      object-fit: contain;
      background: transparent;
    }
    .header .top-icons .profile-icon {
      width: 45px;
      height: 45px;
      border-radius: 50%;
      border: none;
      background: transparent;
    }
    .notification-dropdown {
      display: none;
      position: absolute;
      top: 60px;
      right: 60px;
      background-color: #fff;
      color: #222;
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 14px 18px;
      width: 240px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      z-index: 100;
      font-size: 16px;
    }
    .feedback-summary-row {
      display: flex;
      gap: 40px;
      margin: 40px 0 30px 0;
      justify-content: flex-start;
      align-items: stretch;
      background: #fafdff;
      border-radius: 16px;
      padding: 24px 32px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
      max-width: 900px;
      margin-left: auto;
      margin-right: auto;
    }
    .summary-box {
      display: flex;
      flex-direction: column;
      align-items: center;
      flex: 1;
      min-width: 120px;
      max-width: 180px;
      gap: 8px;
    }
    .summary-box .summary-icon {
      font-size: 32px;
      margin-bottom: 4px;
    }
    .summary-box .summary-label {
      font-size: 18px;
      color: #222;
      font-weight: 500;
      margin-bottom: 2px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .summary-box .summary-value {
      font-size: 28px;
      font-weight: bold;
      color: #222;
    }
    .feedback-table-section {
      display: flex;
      flex-direction: row;
      gap: 46px;
      justify-content: center;
      align-items: flex-start;
      margin-top: 38px;
      margin-left: 0;
    }
    .feedback-table-container {
      flex: 2;
      min-width: 470px;
      max-width: 800px;
    }
    .feedback-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      background: #fff;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
      border: 3px solid #222;
      margin: 0 auto;
    }
    .feedback-table th, .feedback-table td {
      padding: 20px 20px;
      border: 2px solid #222;
      text-align: center;
      font-size: 19px;
    }
    .feedback-table th {
      background: #ededed;
      font-weight: bold;
      font-size: 22px;
      letter-spacing: 1px;
    }
    .feedback-table td {
      font-size: 19px;
    }
    .feedback-chart-section {
      flex: 1;
      min-width: 310px;
      max-width: 400px;
      background: #fff;
      border-radius: 16px;
      border: 3px solid #222;
      padding: 26px 26px 26px 26px;
      display: flex;
      flex-direction: column;
      align-items: center;
      box-sizing: border-box;
    }
    .feedback-chart-section h3 {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #222;
    }
    #feedbackChart {
      width: 180px !important;
      height: 180px !important;
      max-width: 100%;
      margin: 0 auto;
      display: block;
    }
    @media (max-width: 1100px) {
      .feedback-summary-row { flex-direction: column; gap: 18px; }
      .feedback-table-section { flex-direction: column; gap: 18px; }
      .feedback-chart-section { max-width: 100%; min-width: 0; }
    }
  </style>
</head>
<body>
<div class="sidebar">
    <img src="image/mppUMPSA.jpg" alt="Logo" class="profile-pic">
    <ul>
        <li><a href="adminDashboardPage.jsp">MANAGE ACTIVITIES</a></li>
        <li><a href="adminStudentList.jsp">STUDENT LIST</a></li>
        <li><a href="adminFeedback.jsp" class="active">FEEDBACK</a></li>
        <li><a href="adminReport.jsp">REPORT</a></li>
    </ul>
</div>

<div class="main-content">
    <div class="header">
      <div class="header-title">
        <img src="image/Feedback.png" alt="Feedback Icon">
        Feedback
      </div>
      <div class="top-icons">
        <img src="image/umpsa.png" alt="UMPSA Logo">
        <img src="image/bell.png" alt="Notifications" id="notificationBtn" style="cursor:pointer;">
        <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-icon">
        <div class="notification-dropdown" id="notificationDropdown">
          <strong>Notifications</strong>
          <ul style="margin:10px 0 0 0; padding:0 0 0 18px;">
            <li>No new notifications</li>
          </ul>
        </div>
      </div>
    </div>

    <div class="feedback-summary-row">
      <div class="summary-box">
        <span class="summary-icon">&#128172;</span>
        <span class="summary-label">Total Feedback</span>
        <span class="summary-value">125</span>
      </div>
      <div class="summary-box">
        <span class="summary-icon">&#128202;</span>
        <span class="summary-label">Resolved</span>
        <span class="summary-value">83</span>
      </div>
      <div class="summary-box">
        <span class="summary-icon">&#9203;</span>
        <span class="summary-label">Pending</span>
        <span class="summary-value">29</span>
      </div>
      <div class="summary-box">
        <span class="summary-icon">&#128172;</span>
        <span class="summary-label">New Today</span>
        <span class="summary-value">13</span>
      </div>
    </div>

    <div class="feedback-table-section">
      <div class="feedback-table-container">
        <table class="feedback-table">
          <thead>
            <tr>
              <th>NO</th>
              <th>NAME</th>
              <th>Type</th>
              <th>Summary</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1.</td>
              <td>AHMAD KASSIM</td>
              <td>Complaint</td>
              <td>Low management</td>
            </tr>
            <tr>
              <td>2.</td>
              <td>SITI JENAB</td>
              <td>Complaint</td>
              <td>Food are not enough for participants</td>
            </tr>
            <tr>
              <td>3.</td>
              <td>LAW ANN CHAY</td>
              <td>Suggestion</td>
              <td>Add projector for debate night</td>
            </tr>
            <tr>
              <td>4.</td>
              <td>DARSHAN</td>
              <td>Compliment</td>
              <td>Everything was perfect, the food, the vibe, the people were very friendly.</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="feedback-chart-section">
        <h3>Overall Activities Rating</h3>
        <canvas id="feedbackChart"></canvas>
      </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('feedbackChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['5 star', '4 star', '3 star', '2 star', '1 star'],
            datasets: [{
                label: 'Overall Activities Rating',
                data: [30, 25, 22, 15, 8],
                backgroundColor: [
                    '#4caf50', '#2196f3', '#ffeb3b', '#ff9800', '#f44336'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'right'
                },
                title: {
                    display: false
                }
            }
        }
    });
</script>

<script>
document.addEventListener('DOMContentLoaded', function() {
  var bell = document.getElementById('notificationBtn');
  var dropdown = document.getElementById('notificationDropdown');
  bell.addEventListener('click', function(e) {
    e.stopPropagation();
    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
  });
  document.addEventListener('click', function(e) {
    if (dropdown.style.display === 'block') {
      dropdown.style.display = 'none';
    }
  });
});
</script>

</body>
</html>
