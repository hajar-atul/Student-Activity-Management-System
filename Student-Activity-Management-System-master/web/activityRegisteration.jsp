<%-- 
    Document   : activityRegisteration
    Created on : Jun 9, 2025, 3:50:45 PM
    Author     : wafa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Activity List</title>
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

    /* Sidebar */
    .sidebar {
      width: 270px;
      height: 100vh;
      background-color: #00796B;
      color: white;
      position: fixed;
      padding: 70px 20px 20px 20px;
      transition: transform 0.3s ease;
      overflow-y: auto;
      text-align: center;
      z-index: 10;
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
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
    }

    .sidebar h4,
    .sidebar p {
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
      padding: 20px 40px;
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
    
    /* Table Section */
    .payment-header h1 {
        text-align: center;
        padding: 40px;
    }

    .payment-form {
  max-width: 500px;
  margin: 50px auto;
  padding: 30px;
  background-color: #f7f7f7;
  border-radius: 10px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

.payment-form h2 {
  text-align: center;
  margin-bottom: 30px;
}

.payment-form .form-group {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.payment-form .form-group label {
  width: 150px;
  font-weight: 500;
}

.payment-form .form-group input,
.payment-form .form-group select {
  flex: 1;
  padding: 10px;
  border: 1px solid #aaa;
  border-radius: 5px;
  background-color: #ddd;
}

.payment-form .form-group select option {
  background-color: #f0f0f0;
}

  </style>
</head>
<body>

  <!-- Toggle Sidebar Button -->
  <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <img src="image/amin.jpg" alt="Profile Picture" class="profile-pic">
    <h4>MUHAMMAD AMINUDDIN BIN HASNAN</h4>
    <p>2023217854</p>

    <ul>
      <li><a href="dashboard.jsp">Dashboard</a></li>
      <li><a href="activities.jsp" class="active">Activities</a></li>
      <li><a href="clubs.jsp">Clubs</a></li>
      <li><a href="achievements.jsp">Achievements</a></li>
      <li><a href="settings.jsp">Settings</a></li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">
    <div class="header">
      <div class="header-title">ACTIVITIES</div>
      <div class="top-icons">
        <img src="image/umpsa.png" alt="Universiti Malaysia Pahang Logo" class="umpsa-icon" />
        <button class="notification-btn" id="notificationBtn">
          <img src="image/bell.png" alt="Notifications" />
        </button>
        <img src="image/amin.jpg" alt="User Avatar" class="profile-icon" />
      </div>
    </div>
      
    <!-- Notification Dropdown -->
    <div class="notification-dropdown" id="notificationDropdown">
      <p>No new notifications</p>
    </div>

    <!-- Activity List Section -->
    <div class="payment-header">
        <h1>IT WORKSHOP</h1>
    </div>

    <div class="payment-form">
        <div class="form-group">
            <label for="amount">Amount:</label>
         <input type="text" id="amount" value="RM180.00" readonly />
        </div>

        <div class="form-group">
            <label for="payment">Payment Method:</label>
               <select id="payment">
                  <option selected disabled>choose</option>
                  <option>QR payment</option>
                  <option>Online Transfer</option>
               </select>
        </div>
    </div>

  <!-- Script -->
  <script>
    function toggleSidebar() {
      const sidebar = document.getElementById('sidebar');
      const main = document.getElementById('mainContent');
      sidebar.classList.toggle('closed');
      main.classList.toggle('full-width');
    }

    document.getElementById("notificationBtn").addEventListener("click", function () {
      const dropdown = document.getElementById("notificationDropdown");
      dropdown.style.display = dropdown.style.display === "none" ? "block" : "none";
    });
  </script>

</body>
</html>
