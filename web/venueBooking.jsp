<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ACTIVITY, model.CLUB" %>
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Venue Booking Form</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', Arial, sans-serif;
      background: #e6f2ff;
      margin: 0;
      padding: 0;
      overflow: hidden;
    }
    .header-bar {
      background: #009688;
      color: #fff;
      padding: 18px 32px 10px 32px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .header-bar h1 {
      font-size: 2.2em;
      font-weight: bold;
      margin: 0;
    }
    .header-icons {
      display: flex;
      align-items: center;
      gap: 18px;
    }
    .header-icons img {
      height: 38px;
      width: 38px;
      border-radius: 50%;
      background: #fff;
      padding: 4px;
    }
    .venue-form-container {
      background: #f4f4f4;
      max-width: 700px;
      margin: 40px auto;
      border-radius: 18px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.10);
      padding: 0 0 32px 0;
      border: 2px solid #ccc;
      height: 400px;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .venue-form-title {
      text-align: center;
      color: #111;
      font-size: 2em;
      font-weight: bold;
      padding: 24px 0 10px 0;
      letter-spacing: 1px;
    }
    form {
      background: #f4f4f4;
      border-radius: 12px;
      margin: 0 24px;
      padding: 18px 0 0 0;
      display: flex;
      flex-wrap: wrap;
      gap: 22px 32px;
      box-sizing: border-box;
      justify-content: space-between;
      align-items: flex-start;
      height: 220px;
    }
    .form-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
      flex: 1 1 45%;
      min-width: 220px;
      max-width: 320px;
    }
    .form-group label {
      font-weight: 600;
      color: #222;
      margin-bottom: 2px;
    }
    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="time"],
    .form-group select {
      padding: 10px 16px;
      border: 1.5px solid #bbb;
      border-radius: 18px;
      font-size: 1em;
      background: #fff;
      font-family: 'Poppins', Arial, sans-serif;
      outline: none;
      transition: border 0.2s;
    }
    .form-group input[type="text"]:focus,
    .form-group input[type="date"]:focus,
    .form-group input[type="time"]:focus,
    .form-group select:focus {
      border: 1.5px solid #009688;
    }
    .submit-btn {
      background: #002aff;
      color: #fff;
      border: none;
      border-radius: 10px;
      font-size: 1.2em;
      font-weight: bold;
      padding: 16px 0;
      margin-top: 18px;
      width: 100%;
      cursor: pointer;
      transition: background 0.2s, transform 0.2s;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      letter-spacing: 1px;
      align-self: flex-end;
      max-width: 320px;
    }
    .submit-btn:hover {
      background: #001a99;
      transform: translateY(-2px) scale(1.03);
    }
    @media (max-width: 600px) {
      .venue-form-container {
        margin: 18px 6px;
        max-width: 98vw;
      }
      form {
        margin: 0 6px;
        padding: 12px 0 0 0;
      }
    }
  </style>
</head>
<body>
  <div class="header-bar">
    <h1>Venue Booking</h1>
    <div class="header-icons">
      <img src="image/umpsa.png" alt="UMPSA" />
      <img src="image/bell.png" alt="Notifications" />
      <img src="ClubImageServlet?clubID=<%= club != null ? club.getClubId() : 0 %>" alt="User Avatar" class="profile-icon" />
    </div>
  </div>
  <div class="venue-form-container">
    <div class="venue-form-title">VENUE BOOKING FORM</div>
    <% if (request.getParameter("message") != null) { %>
      <div class="message" style="text-align:center; padding:10px; margin: 0 24px 15px 24px; border-radius:8px; background: #red; color: #155724; border: 1px solid #c3e6cb;">
          <%= request.getParameter("message") %>
      </div>
    <% } %>
    <form action="VenueBookingServlet" method="post">
      <div class="form-group">
        <label for="date">Date</label>
        <input type="date" id="date" name="date" required />
      </div>
      <div class="form-group">
        <label for="duration">Duration</label>
        <input type="text" id="duration" name="duration" required />
      </div>
      <div class="form-group">
        <label for="time">Time</label>
        <input type="text" id="time" name="time" required />
      </div>
      <div class="form-group">
        <label for="venue">Venue</label>
        <select id="venue" name="venue" required>
          <option value="">Select Venue</option>
          <option value="Dewan Serbaguna">Dewan Serbaguna</option>
          <option value="Dewan Aspirasi">Dewan Aspirasi</option>
          <option value="Dewan Tengku Hassanal">Dewan Tengku Hassanal</option>
          <option value="Dewan Chanselor">Dewan Chanselor</option>
          <option value="Dewan Ibnu Battuta">Dewan Ibnu Battuta</option>
        </select>
      </div>
      <button type="submit" class="submit-btn">Submit</button>
    </form>
  </div>
</body>
</html> 