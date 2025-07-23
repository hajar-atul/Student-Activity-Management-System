<%-- 
    Document   : Clubs
    Created on : Jun 6, 2025, 3:51:43 PM
    Author     : wafa
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB, model.FEEDBACK, model.STUDENT" %>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.Map" %>
<%@ page import="java.sql.DriverManager, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.Collections, java.util.Comparator" %>
<%@ page import="model.STUDENT_CLUB" %>
<%
    CLUB club = (CLUB) session.getAttribute("club");
    List<ACTIVITY> rejectedActivities = new java.util.ArrayList<ACTIVITY>();
    if (club != null) {
        for (ACTIVITY act : ACTIVITY.getActivitiesByClubId(club.getClubId())) {
            if ("Rejected".equalsIgnoreCase(act.getActivityStatus())) {
                rejectedActivities.add(act);
            }
        }
    }

    // --- FEEDBACK BOX LOGIC (reuse from clubFeedback.jsp, limit 3) ---
    Integer clubID = null;
    Object clubIdObj = session.getAttribute("clubID");
    if (clubIdObj != null) {
        if (clubIdObj instanceof Integer) {
            clubID = (Integer) clubIdObj;
        } else if (clubIdObj instanceof String) {
            clubID = Integer.parseInt((String) clubIdObj);
        }
    }
    List<Map<String, String>> recentFeedbacks = new ArrayList<Map<String, String>>();
    if (clubID != null) {
        List<ACTIVITY> activities = ACTIVITY.getActivitiesByClubId(clubID);
        List<Map<String, String>> allFeedbacks = new ArrayList<Map<String, String>>();
        for (ACTIVITY activity : activities) {
            List<FEEDBACK> activityFeedbacks = FEEDBACK.getFeedbacksByActivityId(activity.getActivityID());
            for (FEEDBACK fb : activityFeedbacks) {
                Map<String, String> fbMap = new HashMap<String, String>();
                STUDENT stud = STUDENT.getStudentById(fb.getStudID());
                fbMap.put("studName", stud != null ? stud.getStudName() : "");
                fbMap.put("activityName", activity.getActivityName());
                fbMap.put("feedRating", String.valueOf(fb.getFeedRating()));
                fbMap.put("feedComment", fb.getFeedComment());
                fbMap.put("DateSubmit", fb.getDateSubmit());
                allFeedbacks.add(fbMap);
            }
        }
        // Sort allFeedbacks by DateSubmit descending (Java 1.5/1.6 compatible)
        Collections.sort(allFeedbacks, new Comparator<Map<String, String>>() {
            public int compare(Map<String, String> a, Map<String, String> b) {
                return b.get("DateSubmit").compareTo(a.get("DateSubmit"));
            }
        });
        // Take only the 3 most recent
        for (int i = 0; i < Math.min(3, allFeedbacks.size()); i++) {
            recentFeedbacks.add(allFeedbacks.get(i));
        }
    }

    // Add after club object is retrieved
    List<STUDENT> clubMembers = new ArrayList<STUDENT>();
    if (club != null) {
        clubMembers = STUDENT_CLUB.getStudentsInClub(club.getClubId());
    }
    // Get count of accepted venue bookings for this club
    int acceptedVenueBookings = 0;
    List<model.BOOKING> acceptedVenueBookingsList = new ArrayList<model.BOOKING>();
    if (club != null) {
        java.util.List<model.BOOKING> allVenueBookings = model.BOOKING.getBookingsByType("Venue");
        for (model.BOOKING booking : allVenueBookings) {
            if ("Approved".equalsIgnoreCase(booking.getStatus()) && booking.getClubID() == club.getClubId()) {
                acceptedVenueBookings++;
                acceptedVenueBookingsList.add(booking);
            }
        }
    }
    // Get count of accepted resource bookings for this club
    int acceptedResourceBookings = 0;
    java.util.List<model.BOOKING> acceptedResourceBookingsList = new java.util.ArrayList<model.BOOKING>();
    if (club != null) {
        java.util.List<model.BOOKING> allResourceBookings = model.BOOKING.getBookingsByType("Resource");
        for (model.BOOKING booking : allResourceBookings) {
            if ("Approved".equalsIgnoreCase(booking.getStatus()) && booking.getClubID() == club.getClubId()) {
                acceptedResourceBookings++;
                acceptedResourceBookingsList.add(booking);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Club Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', Arial, sans-serif;
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
        margin-bottom: 10%;
    }
    .activity-btn:hover {
        background-color: #d32f2f;
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
      flex-direction: column;
      align-items: flex-start;
      margin-bottom: 30px;
      gap: 20px;
    }
    .dashboard-btn {
      background: #0a8079;
      color: #fff;
      border: none;
      border-radius: 6px;
      padding: 8px 18px;
      font-size: 15px;
      font-family: 'Poppins', Arial, sans-serif;
      font-weight: 500;
      cursor: pointer;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
      transition: background 0.2s, transform 0.2s, box-shadow 0.2s;
      outline: none;
      margin-bottom: 0;
    }
    .dashboard-btn:hover {
      background: #00796B;
      transform: translateY(-2px) scale(1.05);
      box-shadow: 0 6px 16px rgba(0,0,0,0.13);
    }
    .summary-cards-row {
      display: flex;
      gap: 32px;
      width: 100%;
      justify-content: flex-start;
    }
    .summary-card {
      background: #D0F0EF;
      padding: 32px 32px 24px 32px;
      border-radius: 18px;
      width: 210px;
      min-width: 180px;
      display: flex;
      flex-direction: column;
      align-items: center;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
      cursor: pointer;
      transition: transform 0.18s, box-shadow 0.18s, background 0.18s;
      border: none;
      outline: none;
      text-align: center;
      user-select: none;
    }
    .summary-card.create-activity {
      background: #fffbe7;
    }
    .summary-card.resource {
      background: #E8E6F1;
    }
    .summary-card:hover {
      transform: translateY(-6px) scale(1.04);
      box-shadow: 0 8px 24px rgba(0,0,0,0.13);
      background: #b2f7ef;
    }
    .summary-card.create-activity:hover {
      background: #fff3b0;
    }
    .summary-card.resource:hover {
      background: #d6d3f7;
    }
    .summary-icon {
      margin-bottom: 12px;
    }
    .summary-icon img, .summary-icon svg {
      height: 48px;
      width: 48px;
      display: block;
      margin: 0 auto;
    }
    .summary-text h3 {
      margin: 0;
      font-size: 1.25em;
      font-weight: bold;
      color: #222;
    }
    .summary-text p {
      font-size: 1.3em;
      font-weight: bold;
      margin: 10px 0 0 0;
      color: #222;
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
      flex-direction: row;
      gap: 20px;
      overflow-x: auto;
      overflow-y: hidden;
      padding-bottom: 10px;
      min-width: max-content;
      width: fit-content;
      scrollbar-width: thin;
      scrollbar-color: #008b8b #f0f0f0;
    }
    .rejected-cards-container::-webkit-scrollbar {
      height: 8px;
    }
    .rejected-cards-container::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 4px;
    }
    .rejected-cards-container::-webkit-scrollbar-thumb {
      background: #008b8b;
      border-radius: 4px;
    }
    .rejected-cards-container::-webkit-scrollbar-thumb:hover {
      background: #006d6d;
    }
    .activity-card {
      min-width: 220px;
      max-width: 220px;
      height: 320px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      overflow: hidden;
      display: flex;
      flex-direction: column;
      flex-shrink: 0;
      box-sizing: border-box;
    }
    .activity-card img {
      width: 100%;
      height: 160px;
      object-fit: cover;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
      display: block;
    }
    .activity-info {
      flex: 1;
      padding: 12px 10px 8px 10px;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: flex-start;
      height: auto;
    }
    .card-actions {
      margin-top: auto;
      width: 100%;
      display: flex;
      justify-content: space-between;
      align-items: center;
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

<button class="toggle-btn" onclick="toggleSidebar()">☰</button>

<div class="sidebar" id="sidebar">
  <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Profile Picture" class="profile-pic">
  <h3><%= session.getAttribute("clubName") %></h3>
  <ul>
    <li><a href="clubDashboardPage.jsp" class="active">DASHBOARD</a></li>
    <li><a href="clubActivitiesPage.jsp">ACTIVITIES</a></li>
    <li><a href="venueBooking.jsp">VENUE BOOKING</a></li>
    <li><a href="resourceReq.jsp">RESOURCE BOOKING</a></li>
    <li><a href="clubFeedback.jsp">FEEDBACK</a></li>
    <li><a href="clubReport.jsp">REPORT</a></li>
    <li><a href="clubSettings.jsp">SETTINGS</a></li>
  </ul>
  <div style="position: absolute; bottom: 20px; width: 80%; left: 10%;">
    <form action="index.jsp">
      <button type="submit" class="activity-btn">Logout</button>
    </form>
  </div>
</div>

<div class="main-content" id="mainContent">
  <div class="header">
    <div class="header-title">DASHBOARD</div>
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

  <div class="activity-section">
    <div class="summary-container">
      <div class="summary-cards-row">
        <div class="summary-card create-activity" onclick="location.href='createActivity.jsp'">
          <div class="summary-icon">
            <img src="image/create_icon.png" alt="Create Activity" />
          </div>
          <div class="summary-text"><h3>CREATE ACTIVITY</h3></div>
        </div>
        <div class="summary-card view-members" onclick="document.getElementById('membersModal').style.display='flex'">
          <div class="summary-icon">
            <img src="image/userIcon.png" alt="View Members" />
          </div>
          <div class="summary-text"><h3>VIEW MEMBERS</h3></div>
        </div>
        <div class="summary-card" onclick="document.getElementById('venueModal').style.display='flex'">
          <div class="summary-icon">
            <img src="image/venue_icon.png" alt="Venue" />
          </div>
          <div class="summary-text"><h3>VENUE BOOKED</h3><p><%= acceptedVenueBookings %></p></div>
        </div>
        <div class="summary-card resource" onclick="document.getElementById('resourceModal').style.display='flex'">
          <div class="summary-icon">
            <img src="image/resource_icon.png" alt="Resource" />
          </div>
          <div class="summary-text"><h3>RESOURCE ACCEPTED</h3><p><%= acceptedResourceBookings %></p></div>
        </div>
      </div>
    </div>

    <!-- FEEDBACK BOX: place after summary cards -->
    <div class="feedback-box" style="background:#f7fafc; border-radius:14px; box-shadow:0 2px 10px rgba(0,0,0,0.07); padding:28px 32px; margin:32px 0 24px 0; max-width:700px;">
      <h2 style="font-size:22px; color:#00796B; margin-bottom:18px; font-weight:600; letter-spacing:0.5px;">Recent Student Feedback</h2>
      <% if (!recentFeedbacks.isEmpty()) { %>
        <div style="display:flex; flex-direction:column; gap:18px;">
          <% for (Map<String, String> fb : recentFeedbacks) { %>
            <div style="background:#fff; border-radius:10px; box-shadow:0 1px 4px rgba(0,0,0,0.04); padding:16px 18px; display:flex; flex-direction:column; gap:4px;">
              <div style="display:flex; align-items:center; gap:10px;">
                <span style="font-weight:600; color:#222;"><%= fb.get("studName") %></span>
                <span style="color:#888; font-size:13px;">on <b><%= fb.get("activityName") %></b></span>
                <span style="margin-left:auto; color:#FFD700;">
                  <% for (int i = 0; i < Integer.parseInt(fb.get("feedRating")); i++) { %>
                    &#9733;
                  <% } %>
                </span>
              </div>
              <div style="color:#444; font-size:15px; margin:2px 0 0 0;"><%= fb.get("feedComment") %></div>
              <div style="color:#aaa; font-size:12px; margin-top:2px;">Submitted: <%= fb.get("DateSubmit") %></div>
            </div>
          <% } %>
        </div>
      <% } else { %>
        <div style="color:#888; font-size:15px;">No recent feedback from students.</div>
      <% } %>
    </div>

    <!-- Rejected Activities -->
    <div class="rejected-activities-box">
      <div class="rejected-header">
        <h2>Rejected Activities</h2>
      </div>
      <div class="rejected-cards-container">
        <% if (!rejectedActivities.isEmpty()) {
            for (ACTIVITY act : rejectedActivities) { %>
              <div class="activity-card">
                <img src="ActivityImageServlet?activityID=<%= act.getActivityID() %>&type=poster" alt="Activity Poster" />
                <div class="activity-info">
                  <h4><%= act.getActivityName() %></h4>
                  <p>Date: <%= act.getActivityDate() %></p>
                  <p>Venue: <%= act.getActivityVenue() %></p>
                  <div class="card-actions">
                    <form action="RemoveActivityServlet" method="post" style="display:inline;">
                      <input type="hidden" name="activityID" value="<%= act.getActivityID() %>">
                      <button type="submit" class="rejected-label" style="background:none; border:none; color:red; cursor:pointer;">Remove</button>
                    </form>
                    <form action="AppealActivityServlet" method="post" style="display:inline;" onsubmit="return submitAppealForm(this);">
                      <input type="hidden" name="activityID" value="<%= act.getActivityID() %>">
                      <input type="hidden" name="appealReason" class="appeal-reason-input" value="">
                      <button type="button" class="appeal-btn" onclick="openAppealModal(this, '<%= act.getActivityID() %>')">Appeal</button>
                    </form>
                  </div>
                </div>
              </div>
        <%   }
           } else { %>
          <div style="color: #888; padding: 20px;">No rejected activities.</div>
        <% } %>
      </div>
    </div>



<!-- Appeal Modal -->
<div class="modal" id="appealModal">
  <div class="modal-content">
    <h3>Submit Appeal</h3>
    <input type="hidden" id="appealActivityId" name="activityID" value="" />
    <textarea id="appealReasonTextarea" placeholder="Write your appeal reason here..."></textarea>
    <div class="modal-buttons">
      <button class="btn-cancel" onclick="closeModal()">Cancel</button>
      <button class="btn-submit" onclick="submitAppeal()">Submit</button>
    </div>
  </div>
</div>

<!-- Members Modal -->
<div class="modal" id="membersModal">
  <div class="modal-content" style="max-width: 700px; width: 95%;">
    <h3>Club Members</h3>
    <div style="overflow-x:auto;">
      <table style="width:100%; border-collapse:collapse;">
        <thead>
          <tr style="background:#e0f7fa;">
            <th style="padding:8px; border:1px solid #ccc;">#</th>
            <th style="padding:8px; border:1px solid #ccc;">Student ID</th>
            <th style="padding:8px; border:1px solid #ccc;">Name</th>
            <th style="padding:8px; border:1px solid #ccc;">Email</th>
            <th style="padding:8px; border:1px solid #ccc;">Course</th>
            <th style="padding:8px; border:1px solid #ccc;">Semester</th>
          </tr>
        </thead>
        <tbody>
          <% int idx = 1;
             for (STUDENT stud : clubMembers) { %>
            <tr>
              <td style="padding:8px; border:1px solid #ccc;"><%= idx++ %></td>
              <td style="padding:8px; border:1px solid #ccc;"><%= stud.getStudID() %></td>
              <td style="padding:8px; border:1px solid #ccc;"><%= stud.getStudName() %></td>
              <td style="padding:8px; border:1px solid #ccc;"><%= stud.getStudEmail() %></td>
              <td style="padding:8px; border:1px solid #ccc;"><%= stud.getStudCourse() %></td>
              <td style="padding:8px; border:1px solid #ccc;"><%= stud.getStudSemester() %></td>
            </tr>
          <% } %>
        </tbody>
      </table>
      <% if (clubMembers.isEmpty()) { %>
        <div style="color:#888; text-align:center; margin:20px 0;">No members in this club.</div>
      <% } %>
    </div>
    <div class="modal-buttons">
      <button class="btn-cancel" onclick="document.getElementById('membersModal').style.display='none'">Close</button>
    </div>
  </div>
</div>

<!-- Venue Booked Modal -->
<div id="venueModal" class="modal">
  <div class="modal-content" style="max-width: 500px;">
    <h3>Accepted Venue Bookings</h3>
    <table style="width:100%; border-collapse:collapse;">
      <thead>
        <tr>
          <th style="padding:8px; border:1px solid #ccc;">Venue</th>
          <th style="padding:8px; border:1px solid #ccc;">Activity</th>
          <th style="padding:8px; border:1px solid #ccc;">Date</th>
        </tr>
      </thead>
      <tbody>
        <%
          for (model.BOOKING booking : acceptedVenueBookingsList) {
              // Find the activity for this booking (by venue and club)
              model.ACTIVITY matchedActivity = null;
              java.util.List<model.ACTIVITY> clubActivities = new java.util.ArrayList<model.ACTIVITY>(model.ACTIVITY.getActivitiesByClubId(club.getClubId()));
              for (model.ACTIVITY act : clubActivities) {
                  if (act.getActivityVenue() != null && act.getActivityVenue().equalsIgnoreCase(booking.getItemName())) {
                      matchedActivity = act;
                      break;
                  }
              }
        %>
        <tr>
          <td style="padding:8px; border:1px solid #ccc;"><%= booking.getItemName() %></td>
          <td style="padding:8px; border:1px solid #ccc;"><%= matchedActivity != null ? matchedActivity.getActivityName() : "-" %></td>
          <td style="padding:8px; border:1px solid #ccc;"><%= booking.getBookingDate() %></td>
        </tr>
        <% } %>
        <% if (acceptedVenueBookingsList.isEmpty()) { %>
        <tr>
          <td colspan="3" style="text-align:center; color:#888; padding:12px;">No accepted venue bookings.</td>
        </tr>
        <% } %>
      </tbody>
    </table>
    <div class="modal-buttons" style="text-align:right; margin-top:16px;">
      <button class="btn-cancel" onclick="document.getElementById('venueModal').style.display='none'">Close</button>
    </div>
  </div>
</div>

<!-- Resource Accepted Modal -->
<div id="resourceModal" class="modal">
  <div class="modal-content" style="max-width: 600px;">
    <h3>Accepted Resource Bookings</h3>
    <table style="width:100%; border-collapse:collapse;">
      <thead>
        <tr>
          <th style="padding:8px; border:1px solid #ccc;">Resource</th>
          <th style="padding:8px; border:1px solid #ccc;">Quantity/Details</th>
          <th style="padding:8px; border:1px solid #ccc;">Activity</th>
          <th style="padding:8px; border:1px solid #ccc;">Date</th>
        </tr>
      </thead>
      <tbody>
        <% 
          java.util.List<model.ACTIVITY> clubActivities = new java.util.ArrayList<model.ACTIVITY>(model.ACTIVITY.getActivitiesByClubId(club.getClubId()));
          for (model.BOOKING booking : acceptedResourceBookingsList) {
              model.ACTIVITY matchedActivity = null;
              for (model.ACTIVITY act : clubActivities) {
                  if (act.getActivityDesc() != null && act.getActivityDesc().toLowerCase().contains(booking.getItemName().toLowerCase())) {
                      matchedActivity = act;
                      break;
                  }
              }
        %>
        <tr>
          <td style="padding:8px; border:1px solid #ccc;"><%= booking.getItemName() %></td>
          <td style="padding:8px; border:1px solid #ccc;"><%= booking.getItemDetails() %></td>
          <td style="padding:8px; border:1px solid #ccc;"><%= matchedActivity != null ? matchedActivity.getActivityName() : "-" %></td>
          <td style="padding:8px; border:1px solid #ccc;"><%= booking.getBookingDate() %></td>
        </tr>
        <% } %>
        <% if (acceptedResourceBookingsList.isEmpty()) { %>
        <tr>
          <td colspan="4" style="text-align:center; color:#888; padding:12px;">No accepted resource bookings.</td>
        </tr>
        <% } %>
      </tbody>
    </table>
    <div class="modal-buttons" style="text-align:right; margin-top:16px;">
      <button class="btn-cancel" onclick="document.getElementById('resourceModal').style.display='none'">Close</button>
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
    dropdown.style.display = dropdown.style.display === "none" ? "block" : "none";
  });

  function openModal() {
    document.getElementById("appealModal").style.display = "flex";
  }

  function closeModal() {
    document.getElementById("appealModal").style.display = "none";
  }

  function submitAppeal() {
    alert("Appeal submitted successfully!");
    closeModal();
  }

  let currentAppealForm = null;
  function openAppealModal(btn, activityID) {
    document.getElementById("appealModal").style.display = "flex";
    document.getElementById("appealActivityId").value = activityID;
    document.getElementById("appealReasonTextarea").value = "";
    currentAppealForm = btn.closest('form');
  }
  function submitAppeal() {
    if (currentAppealForm) {
      currentAppealForm.querySelector('.appeal-reason-input').value = document.getElementById("appealReasonTextarea").value;
      currentAppealForm.submit();
      closeModal();
    }
  }
  function submitAppealForm(form) {
    // Prevent default form submission, handled by modal
    return false;
  }
</script>

</body>
</html>
