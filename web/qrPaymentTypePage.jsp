<%-- 
    Document   : QRpaymentTypePage
    Created on : Jun 9, 2025, 4:39:52 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Activity - IT Workshop</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

           body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            background-color: #f0f0f0;
        }


        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #008b8b;
            color: white;
            padding: 20px;
            height: 100vh;
        }

        .sidebar img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            display: block;
            margin: 0 auto;
        }

        .sidebar h3 {
            text-align: center;
            font-size: 14px;
            margin: 10px 0 0;
        }

        .menu {
            margin-top: 30px;
        }

        .menu a {
            display: block;
            padding: 10px;
            background-color: #0a6d6d;
            margin-top: 10px;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            text-align: center;
        }
    /* Toggle Button */
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

    /* Main Content */
    .main-content {
      margin-left: 270px;
      transition: margin-left 0.3s ease;
    }

    .main-content.full-width {
      margin-left: 20px;
    }

    /* Header */
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #0a8079;
      color: white;
      padding: 80px 40px 40px 40px;;
      width: 100%;
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

    .payment-header h1 {
      text-align: center;
      padding: 40px 0;
    }

    .qr-section {
      text-align: center;
      margin-top: 30px;
    }

    .qr-section img {
      width: 250px;
      margin-bottom: 20px;
    }

    .form {
      max-width: 400px;
      margin: 0 auto;
      text-align: left;
    }

    .form label {
      display: block;
      margin: 10px 0 5px;
    }

    .form input[type="text"],
    .form input[type="file"] {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
      background-color: #eee;
    }

    .submit-button {
      text-align: center;
      margin-top: 20px;
    }

    .submit-button button {
      padding: 10px 20px;
      background-color: #00796B;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
  </style>
</head>
<body>

  <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

  <!-- Sidebar -->
    <div class="sidebar">
        <img src="image/Raccoon.gif" alt="Profile Picture">
        <h3><%= request.getAttribute("name") %><br><%= request.getAttribute("studentId") %></h3>
        <div class="menu">
            <a href="studentDashboardPage.jsp">DASHBOARD</a>
            <a href="activities.jsp">ACTIVITIES</a>
            <a href="studentClub.jsp">CLUBS</a>
            <a href="achievements.jsp">ACHIEVEMENTS</a>
            <a href="settings.jsp">SETTINGS</a>
        </div>
    </div>

  <div class="main-content" id="mainContent">
    <div class="header">
      <div class="header-title">ACTIVITIES</div>
      <div class="top-icons">
        <img src="image/umpsa.png" alt="UMPSA Logo" class="umpsa-icon">
        <button class="notification-btn" id="notificationBtn">
          <img src="image/bell.png" alt="Notifications">
        </button>
        <img src="image/Raccoon.gif" alt="Profile Icon" class="profile-icon">
      </div>
    </div>

    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>

    <div class="payment-header">
      <h1>IT WORKSHOP</h1>
    </div>

    <div class="qr-section" id="qrSection">
      <img src="image/qr_zahwa.jfif" alt="QR Code">
      <div class="form">
        <form id="receiptForm" enctype="multipart/form-data">
          <label for="paymentType">Payment Method:</label>
          <input type="text" id="paymentType" name="paymentType" value="QR payment" readonly>

          <label for="receipt">Provide receipt:</label>
          <input type="file" id="receipt" name="receipt" accept=".jpg,.jpeg,.png,.pdf">

          <div class="submit-button">
            <button type="submit">Submit Receipt</button>
          </div>
        </form>
      </div>
    </div>

  </div>

  <script>
    function toggleSidebar() {
      const sidebar = document.getElementById('sidebar');
      const main = document.getElementById('mainContent');
      sidebar.classList.toggle('closed');
      main.classList.toggle('full-width');
    }

    document.getElementById("notificationBtn").addEventListener("click", function () {
      const dropdown = document.getElementById("notificationDropdown");
      dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
    });

    document.getElementById('receiptForm').addEventListener('submit', function (e) {
      e.preventDefault();
      const fileInput = document.getElementById('receipt');
      if (fileInput.files.length === 0) {
        alert("Please select a receipt file.");
        return;
      }
      alert('Receipt submitted successfully!');
    });
  </script>

</body>
</html>
