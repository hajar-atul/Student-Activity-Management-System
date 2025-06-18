<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Report</title>
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
        .sidebar .sidebar-top {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .sidebar .mail-icon {
            position: relative;
            margin-left: 10px;
        }
        .sidebar .mail-icon img {
            width: 36px;
            height: 36px;
        }
        .sidebar .mail-badge {
            position: absolute;
            top: -6px;
            right: -6px;
            background: #f44336;
            color: #fff;
            font-size: 14px;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            border: 2px solid #fff;
        }
        .sidebar .hamburger {
            font-size: 32px;
            color: #fff;
            cursor: pointer;
            margin-right: 10px;
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
            width: 54px;
            height: 54px;
            object-fit: contain;
        }
        .header .top-icons {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-left: auto;
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
        .report-table-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 40px;
        }
        .report-table-container {
            width: 95%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .report-table {
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
        .report-table th, .report-table td {
            padding: 18px 12px;
            border: 2px solid #222;
            text-align: center;
            font-size: 18px;
        }
        .report-table th {
            background: #ededed;
            font-weight: bold;
            font-size: 20px;
            letter-spacing: 1px;
        }
        .report-table td {
            font-size: 18px;
            vertical-align: middle;
        }
        .activity-proposal-cell {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .activity-proposal-name {
            flex: 1;
            text-align: left;
            font-size: 18px;
            font-weight: 400;
            padding-right: 10px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .activity-proposal-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-download {
            background: none;
            border: none;
            padding: 0 0 0 8px;
            margin: 0;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: none;
            border-radius: 0;
            min-width: 0;
            min-height: 0;
            outline: none;
            transition: none;
        }
        .btn-download img {
            width: 35px;
            height: 35px;
            display: block;
            filter: none;
        }
        .btn-view {
            background-color: #23bfae;
            color: white;
            border: none;
            padding: 8px 22px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
            margin-right: 10px;
        }
        .btn-view:hover {
            background: #159e8a;
        }
        .icon-download {
            color: #222;
            font-size: 28px;
            cursor: pointer;
            vertical-align: middle;
            margin-left: 6px;
        }
        .status-checked {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 18px;
            font-weight: 500;
            color: #23bfae;
        }
        .status-checked img {
            width: 36px;
            height: 36px;
            vertical-align: middle;
        }
        .more-report-btn {
            background-color: #238B87;
            color: white;
            border: none;
            padding: 14px 38px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 30px;
            cursor: pointer;
            float: right;
            margin-top: 30px;
            margin-right: 40px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: background 0.2s;
        }
        .more-report-btn:hover {
            background: #1a7e7c;
        }
        .more-report-btn .arrow {
            font-size: 22px;
            margin-left: 6px;
        }
        @media (max-width: 1100px) {
            .report-table-container { width: 100%; }
            .main-content { margin-left: 0; }
            .sidebar { position: static; width: 100%; height: auto; }
        }
    </style>
</head>
<body>
<div class="sidebar" id="sidebar">
    <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-pic">
    <ul>
        <li><a href="adminDashboardPage.jsp">MANAGE ACTIVITIES</a></li>
        <li><a href="adminStudentList.jsp">STUDENT LIST</a></li>
        <li><a href="adminFeedback.jsp">FEEDBACK</a></li>
        <li><a href="adminReport.jsp" class="active">REPORT</a></li>
    </ul>
</div>

<div class="main-content" id="mainContent">
    <div class="header">
        <div class="header-title">
            <img src="image/filePlusIcon.png" alt="Report Icon">
            Report
        </div>
        <div class="top-icons">
            <img src="image/umpsa.png" alt="Logo UMPSA">
            <img src="image/bell.png" alt="Notifications">
            <img src="image/mppUMPSA.jpg" alt="MPP Logo" class="profile-icon">
        </div>
    </div>

    <div class="report-table-section">
        <div class="report-table-container">
            <table class="report-table">
                <thead>
                    <tr>
                        <th>CLUB</th>
                        <th>ACTIVITY PROPOSAL</th>
                        <th>DATE</th>
                        <th>STATUS</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>EACC</td>
                        <td>
                            <div class="activity-proposal-cell">
                                <span class="activity-proposal-name">KIMONO PAINTING</span>
                                <span class="activity-proposal-actions">
                                    <button class="btn-view">View</button>
                                    <button class="btn-download"><img src="image/downloadIcon.png" alt="Download"></button>
                                </span>
                            </div>
                        </td>
                        <td>23 FEB 2025</td>
                        <td class="status-checked"><img src="image/checked.png" alt="Checked">Checked</td>
                    </tr>
                    <tr>
                        <td>RELEX</td>
                        <td>
                            <div class="activity-proposal-cell">
                                <span class="activity-proposal-name">HIKING</span>
                                <span class="activity-proposal-actions">
                                    <button class="btn-view">View</button>
                                    <button class="btn-download"><img src="image/downloadIcon.png" alt="Download"></button>
                                </span>
                            </div>
                        </td>
                        <td>4 APR 2025</td>
                        <td class="status-checked"><img src="image/checked.png" alt="Checked">Checked</td>
                    </tr>
                    <tr>
                        <td>BADMINTOON</td>
                        <td>
                            <div class="activity-proposal-cell">
                                <span class="activity-proposal-name">FRIENDLY LEAGUE</span>
                                <span class="activity-proposal-actions">
                                    <button class="btn-view">View</button>
                                    <button class="btn-download"><img src="image/downloadIcon.png" alt="Download"></button>
                                </span>
                            </div>
                        </td>
                        <td>10 MAY 2025</td>
                        <td class="status-checked"><img src="image/checked.png" alt="Checked">Checked</td>
                    </tr>
                    <tr>
                        <td>PINGPONG</td>
                        <td>
                            <div class="activity-proposal-cell">
                                <span class="activity-proposal-name">SPORTS FEST</span>
                                <span class="activity-proposal-actions">
                                    <button class="btn-view">View</button>
                                    <button class="btn-download"><img src="image/downloadIcon.png" alt="Download"></button>
                                </span>
                            </div>
                        </td>
                        <td>28 JUNE 2025</td>
                        <td class="status-checked"><img src="image/checked.png" alt="Checked">Checked</td>
                    </tr>
                    <tr>
                        <td>RELEX</td>
                        <td>
                            <div class="activity-proposal-cell">
                                <span class="activity-proposal-name">KAYAKING</span>
                                <span class="activity-proposal-actions">
                                    <button class="btn-view">View</button>
                                    <button class="btn-download"><img src="image/downloadIcon.png" alt="Download"></button>
                                </span>
                            </div>
                        </td>
                        <td>12 JUNE 2025</td>
                        <td class="status-checked"><img src="image/checked.png" alt="Checked">Checked</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <button class="more-report-btn">More Report <span class="arrow">&#8594;</span></button>
</div>

</body>
</html>
