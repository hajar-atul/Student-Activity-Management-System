<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Report</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 32px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f9f9f9;
            font-weight: bold;
        }

        .btn-view {
            background-color: #2196F3;
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

        .icon-download {
            color: #4CAF50;
            font-size: 18px;
            cursor: pointer;
        }

        .more-report-btn {
            background-color: #FF9800;
            color: white;
            border: none;
            padding: 12px 24px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            float: right;
        }

    </style>
</head>
<body>

<div class="container">
    <h1>ADMIN REPORT</h1>

    <table>
        <thead>
            <tr>
                <th>ACTIVITY</th>
                <th>CLUB</th>
                <th>DATE</th>
                <th>ACTION</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>TECH EXPO</td>
                <td>IT CLUB</td>
                <td>26 JUNE 2025</td>
                <td>
                    <button class="btn-view">View</button>
                    <span class="icon-download">&#128190;</span> <!-- 💾 icon -->
                </td>
            </tr>
            <tr>
                <td>CHARITY RUN</td>
                <td>EACC CLUB</td>
                <td>12 JULY 2025</td>
                <td>
                    <button class="btn-view">View</button>
                    <span class="icon-download">&#128190;</span>
                </td>
            </tr>
            <tr>
                <td>DEBATE NIGHT</td>
                <td>SOCIETY</td>
                <td>15 JULY 2025</td>
                <td>
                    <button class="btn-view">View</button>
                    <span class="icon-download">&#128190;</span>
                </td>
            </tr>
        </tbody>
    </table>

    <button class="more-report-btn">More Report</button>
</div>

</body>
</html>
