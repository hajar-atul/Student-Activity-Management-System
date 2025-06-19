
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Feedback</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', Arial, sans-serif;
    }

    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #00796B;
      color: white;
      position: fixed;
      padding: 70px 20px 20px 20px;
      overflow-y: auto;
      z-index: 10;
      text-align: center;
    }

    .sidebar.closed {
      transform: translateX(-100%);
    }

    .sidebar img.profile-pic {
      width: 100px;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 15px;
      border: 3px solid white;
    }

    .sidebar h3 {
      margin-bottom: 10px;
    }

    .sidebar ul {
      list-style: none;
      padding-left: 0;
      margin-top: 20px;
    }

    .sidebar ul li {
      margin-bottom: 15px;
    }

    .sidebar ul li a {
      color: white;
      text-decoration: none;
      padding: 10px;
      display: block;
      border-radius: 5px;
      transition: background-color 0.2s ease;
    }

    .sidebar ul li a:hover,
    .sidebar ul li a.active {
      background-color: rgba(0, 0, 0, 0.2);
    }

    .toggle-btn {
      position: fixed;
      left: 10px;
      top: 10px;
      z-index: 1000;
      background-color: #00796B;
      color: white;
      border: none;
      padding: 10px 15px;
      cursor: pointer;
      border-radius: 5px;
    }

    .main-content {
      margin-left: 270px;
      transition: margin-left 0.3s ease;
    }

    .main-content.full-width {
      margin-left: 20px;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #0a8079;
      color: white;
      padding: 20px 40px;
    }

    .header-title {
      font-size: 28px;
      font-weight: bold;
    }

    .top-icons {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .top-icons img.umpsa-icon {
      width: 36px;
      height: 36px;
    }

    .notification-btn {
      background: none;
      border: none;
      cursor: pointer;
      padding: 0;
    }

    .notification-btn img {
      width: 30px;
      height: 30px;
    }

    .profile-icon {
      width: 40px;
      height: 40px;
      border-radius: 50%;
    }

    .notification-dropdown {
      position: absolute;
      top: 80px;
      right: 40px;
      background-color: white;
      color: black;
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 10px;
      width: 200px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      display: none;
      z-index: 100;
    }

    .activity-section {
      padding: 40px;
    }
    
    .activity-section:hover {
      padding: none;
    }

    .activity-section h2 {
      text-align: center;
      font-size: 32px;
      font-weight: bold;
    }

    .summary-container {
      display: flex;
      justify-content: space-around;
      margin-bottom: 30px;
      flex-wrap: wrap;
      gap: 20px;
    }

    .summary-card {
      background: #D0F0EF;
      padding: 20px;
      border-radius: 12px;
      width: 30%;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .summary-card:nth-child(2) {
      background: #E8E6F1;
    }

    .summary-icon img {
      height: 60px;
      width: 60px;
    }

    .summary-text h3 {
      margin: 0;
      font-size: 20px;
    }

    .summary-text p {
      font-size: 26px;
      font-weight: bold;
      margin: 5px 0 0;
    }

    .rejected-activities-box {
      background-color: #f9f9f9;
      border-radius: 12px;
      padding: 30px;
      margin: 60px 40px 40px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .rejected-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .rejected-header h2 {
      font-size: 24px;
      font-weight: bold;
      margin: 0;
    }

    .view-all-btn {
      background-color: #00796B;
      color: white;
      padding: 8px 14px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
    }

    .view-all-btn:hover {
      background-color: #005f56;
    }

    .rejected-cards-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    .activity-card {
      width: 220px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }

    .activity-card img {
      width: 100%;
      height: 120px;
      object-fit: cover;
    }

    .activity-info {
      padding: 15px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: 130px;
    }

    .activity-info h4 {
      font-size: 16px;
      margin-bottom: 5px;
    }

    .activity-info p {
      font-size: 12px;
      margin: 2px 0;
    }

    .card-actions {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 8px;
    }

    .rejected-label {
      background-color: #ff9295;
      color: red;
      font-weight: bold;
      font-size: 11px;
      padding: 4px 7px;
      border-radius: 4px;
    }

    .appeal-btn {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 5px 10px;
      font-size: 12px;
      border-radius: 4px;
      cursor: pointer;
    }

    .appeal-btn:hover {
      background-color: #0056b3;
    }

    /* Modal */
    .modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.4);
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }

    .modal-content {
      background: white;
      padding: 30px;
      border-radius: 10px;
      width: 90%;
      max-width: 400px;
    }

    .modal-content h3 {
      margin-bottom: 20px;
    }

    .modal-content textarea {
      width: 100%;
      height: 100px;
      margin-bottom: 15px;
      padding: 10px;
      resize: none;
    }

    .modal-buttons {
      text-align: right;
    }

    .modal-buttons button {
      padding: 8px 14px;
      margin-left: 10px;
      border-radius: 6px;
      border: none;
      cursor: pointer;
    }

    .btn-cancel {
      background-color: #ccc;
    }

    .btn-submit {
      background-color: #00796B;
      color: white;
    }

    @media (max-width: 768px) {
      .main-content {
        margin-left: 0 !important;
      }

      .sidebar {
        width: 100%;
        height: auto;
        position: static;
      }

      .toggle-btn {
        position: absolute;
        left: 10px;
        top: 10px;
      }

      .summary-card {
        width: 100%;
      }

      .rejected-cards-container {
        justify-content: center;
      }
    }
    </style>
</head>
<body>
<div class="sidebar">
    <img src="image/logo_mpp.png" alt="Logo" style="width:100px; border-radius: 50%; display:block; margin:0 auto 20px;">
    <ul>
        <li><a href="adminDashboardPage.jsp">MANAGE ACTIVITIES</a></li>
        <li><a href="adminStudentList.jsp">STUDENT LIST</a></li>
        <li><a href="adminFeedback.jsp" class="active">FEEDBACK</a></li>
        <li><a href="adminReport.jsp">REPORT</a></li>
    </ul>
</div>

<div class="main-content">
    <div class="header">
        <h2>Feedback</h2>
    </div>

    <div class="feedback-summary">
        <div class="summary-box">
            <h3>Total Feedback</h3>
            <p>125</p>
        </div>
        <div class="summary-box">
            <h3>Resolved</h3>
            <p>83</p>
        </div>
        <div class="summary-box">
            <h3>Pending</h3>
            <p>29</p>
        </div>
        <div class="summary-box">
            <h3>New Today</h3>
            <p>13</p>
        </div>
    </div>

    <table>
        <tr>
            <th>NO</th>
            <th>NAME</th>
            <th>Type</th>
            <th>Summary</th>
        </tr>
        <tr>
            <td>1</td>
            <td>AHMAD KASSIM</td>
            <td>Complaint</td>
            <td>Low management</td>
        </tr>
        <tr>
            <td>2</td>
            <td>SITI JENAB</td>
            <td>Complaint</td>
            <td>Food are not enough for participants</td>
        </tr>
        <tr>
            <td>3</td>
            <td>LAW ANN CHAY</td>
            <td>Suggestion</td>
            <td>Add projector for debate night</td>
        </tr>
        <tr>
            <td>4</td>
            <td>DARSHAN</td>
            <td>Compliment</td>
            <td>Everything was perfect, the food, the vibe, the people were very friendly.</td>
        </tr>
    </table>

    <div class="chart-section">
        <canvas id="feedbackChart"></canvas>
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
                    display: true,
                    text: 'Overall Activities Rating'
                }
            }
        }
    });
</script>

</body>
</html>
