<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File, java.io.InputStream, java.io.FileOutputStream, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="model.REPORT, model.CLUB" %>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    String message = null;
    boolean submitted = false;
    int clubID = (session.getAttribute("clubID") != null) ? Integer.parseInt(session.getAttribute("clubID").toString()) : 0;
    List activities = new ArrayList(); // [activityID, activityName]
    if (clubID > 0) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC", "root", "");
            stmt = conn.prepareStatement("SELECT activityID, activityName FROM activity WHERE clubID = ?");
            stmt.setInt(1, clubID);
            rs = stmt.executeQuery();
            while (rs.next()) {
                String[] act = new String[2];
                act[0] = rs.getString("activityID");
                act[1] = rs.getString("activityName");
                activities.add(act);
            }
        } catch (Exception e) { e.printStackTrace(); }
        finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String activityIdStr = request.getParameter("activityID");
        String reportDate = request.getParameter("reportDate");
        String remarks = request.getParameter("remarks");
        Part filePart = request.getPart("reportFile");
        int activityID = Integer.parseInt(activityIdStr);
        String fileName = null;
        String filePath = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = application.getRealPath("/reports");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePath = "reports/" + fileName;
            FileOutputStream output = null;
            InputStream input = null;
            try {
                input = filePart.getInputStream();
                output = new FileOutputStream(new File(uploadPath, fileName));
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            } finally {
                try { if (input != null) input.close(); } catch (Exception e) {}
                try { if (output != null) output.close(); } catch (Exception e) {}
            }
        }
        // Save to DB (assume REPORT table has filePath, remarks columns)
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC", "root", "");
            String sql = "INSERT INTO report (clubID, activityID, reportDate, filePath, reportDetails, status) VALUES (?, ?, ?, ?, ?, 'unchecked')";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, clubID);
            stmt.setInt(2, activityID);
            stmt.setString(3, reportDate);
            stmt.setString(4, filePath);
            stmt.setString(5, remarks);
            int result = stmt.executeUpdate();
            if (result > 0) {
                message = "<b>Report submitted successfully!</b>";
                submitted = true;
            } else {
                message = "Failed to submit report.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Club Report</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }

        body { 
          font-family: 'Poppins', Arial, sans-serif; 
          background: #f6f6f6; 
          height: 100vh;
          overflow: hidden;
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
          min-height: 100vh;
          overflow: hidden;
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

        .container {
            max-width: 520px;
            margin: 40px auto;
            background: #fff;
            padding: 38px 44px 32px 44px;
            border-radius: 18px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        }
        
        h1 { 
          text-align: center; 
          color: #238B87; 
          margin-bottom: 30px; 
          font-size: 2.1em; 
        }
        
        .form-group { 
          margin-bottom: 22px; 
        }
        
        label { 
          display: block; 
          font-weight: bold; 
          margin-bottom: 8px; 
          color: #238B87; 
        }
        
        select, input[type="date"], textarea {
            width: 100%; 
            padding: 10px; 
            border-radius: 7px; 
            border: 1.5px solid #b2dfdb; 
            font-size: 16px; 
            background: #f8f8f8;
        }
        
        input[type="file"] {
            display: none;
        }
        
        .file-label {
            display: inline-block;
            background: #e0f7fa;
            color: #00796B;
            padding: 10px 22px;
            border-radius: 7px;
            cursor: pointer;
            font-weight: 500;
            font-size: 16px;
            margin-top: 6px;
            margin-bottom: 6px;
            transition: background 0.2s;
        }
        
        .file-label:hover {
            background: #b2ebf2;
        }
        
        .file-name {
            margin-left: 10px;
            font-size: 15px;
            color: #555;
        }
        
        textarea {
            min-height: 80px;
            resize: vertical;
        }
        
        .submit-btn {
            width: 100%;
            background: linear-gradient(90deg, #238B87 60%, #00bfa6 100%);
            color: #fff;
            border: none;
            padding: 14px 0;
            border-radius: 8px;
            font-size: 20px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: background 0.2s, transform 0.2s;
        }
        
        .submit-btn:hover {
            background: linear-gradient(90deg, #00796B 60%, #00bfa6 100%);
            transform: translateY(-2px) scale(1.03);
        }
        
        .message {
            text-align: center;
            margin-bottom: 20px;
            color: #219a98;
            font-size: 18px;
        }
        
        .icon-upload {
            vertical-align: middle;
            margin-right: 8px;
        }

        @media (max-width: 768px) {
          .sidebar {
            position: static;
          }

          .toggle-btn {
            position: absolute;
            left: 10px;
            top: 10px;
          }

          .main-content {
            margin-left: 20px;
          }

          .header {
            padding: 15px 20px;
          }

          .header-title {
            font-size: 20px;
          }

          .container {
            margin: 20px;
            padding: 20px 24px;
          }
        }

        @media (max-width: 600px) {
          .container {
            margin: 10px;
            padding: 20px;
          }
        }
        .activity-btn {
          width: 100%;
          padding: 15px;
          background-color: #f44336;
          color: white;
          border: none;
          border-radius: 8px;
          font-size: 16px;
          font-weight: bold;
          cursor: pointer;
          transition: background-color 0.2s;
          margin: 0;
        }
        .activity-btn:hover {
          background-color: #d32f2f;
        }
    </style>
    <script>
        function showFileName(input) {
            var fileName = input.files[0] ? input.files[0].name : '';
            document.getElementById('fileName').textContent = fileName;
        }
    </script>
</head>
<body>
    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

    <div class="sidebar" id="sidebar">
      <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Profile Picture" class="profile-pic">
      <h3><%= session.getAttribute("clubName") %></h3>
      <ul>
        <li><a href="clubDashboardPage.jsp">DASHBOARD</a></li>
        <li><a href="clubActivitiesPage.jsp">ACTIVITIES</a></li>
        <li><a href="venueBooking.jsp">VENUE BOOKING</a></li>
        <li><a href="resourceReq.jsp">RESOURCE BOOKING</a></li>
        <li><a href="clubFeedback.jsp">FEEDBACK</a></li>
        <li><a href="clubReport.jsp" class="active">REPORT</a></li>
        <li><a href="clubSettings.jsp">SETTINGS</a></li>
      </ul>
      <div style="position: absolute; bottom: 20px; width: 80%; left: 10%; margin-top: 50px; margin-bottom: 25px;">
        <form action="index.jsp">
          <button type="submit" class="activity-btn">Logout</button>
        </form>
      </div>
    </div>

    <div class="main-content" id="mainContent">
      <div class="header">
        <div class="header-title">REPORT SUBMISSION</div>
        <div class="top-icons">
          <img src="image/umpsa.png" alt="UMPSA Logo" class="umpsa-icon" />
          <button class="notification-btn" id="notificationBtn">
            <img src="image/bell.png" alt="Notifications" />
          </button>
          <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Avatar" class="profile-icon" />
        </div>
      </div>

      <div class="notification-dropdown" id="notificationDropdown">
        <p>No new notifications</p>
      </div>

      <div class="container">
          <h1>Submit Activity Report</h1>
          <% if (message != null) { %>
              <div class="message"><%= message %></div>
          <% } %>
          <% if (!submitted) { %>
          <form method="post" enctype="multipart/form-data">
              <div class="form-group">
                  <label for="activityID">Select Activity</label>
                  <select name="activityID" id="activityID" required>
                      <option value="">-- Select Activity --</option>
                      <% for (int i = 0; i < activities.size(); i++) {
                          String[] act = (String[])activities.get(i); %>
                          <option value="<%= act[0] %>"><%= act[1] %></option>
                      <% } %>
                  </select>
              </div>
              <div class="form-group">
                  <label for="reportDate">Report Date</label>
                  <input type="date" name="reportDate" id="reportDate" value="<%= today %>" required>
              </div>
              <div class="form-group">
                  <label for="reportFile">Upload PDF Report</label>
                  <label class="file-label" for="reportFile"><span class="icon-upload">📄</span>Choose PDF</label>
                  <input type="file" name="reportFile" id="reportFile" accept="application/pdf" required onchange="showFileName(this)">
                  <span class="file-name" id="fileName"></span>
              </div>
              <div class="form-group">
                  <label for="remarks">Remarks / Description (optional)</label>
                  <textarea name="remarks" id="remarks" placeholder="Add any remarks or description..."></textarea>
              </div>
              <button type="submit" class="submit-btn">Submit Report</button>
          </form>
          <% } %>
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
        dropdown.style.display = dropdown.style.display === "none" ? "block" : "none";
      });
    </script>
</body>
</html> 