<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Create Activity</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', Arial, sans-serif;
      background: #e6f2ff;
      margin: 0;
      padding: 0;
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
    .activity-form-container {
      background: #009688;
      max-width: 900px;
      margin: 32px auto;
      border-radius: 18px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.10);
      padding: 0 0 32px 0;
    }
    .activity-form-title {
      text-align: center;
      color: #fff;
      font-size: 2em;
      font-weight: bold;
      padding: 24px 0 10px 0;
      letter-spacing: 1px;
    }
    form {
      background: #fff;
      border-radius: 12px;
      margin: 0 24px;
      padding: 32px 24px 24px 24px;
      display: flex;
      flex-wrap: wrap;
      gap: 24px 32px;
      box-sizing: border-box;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }
    .form-group {
      display: flex;
      flex-direction: column;
      flex: 1 1 320px;
      min-width: 260px;
      max-width: 400px;
    }
    .form-group label {
      font-weight: 600;
      margin-bottom: 8px;
      color: #009688;
    }
    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group textarea {
      padding: 10px;
      border: 1px solid #b2dfdb;
      border-radius: 6px;
      font-size: 1em;
      background: #e0ffff;
      font-family: 'Poppins', Arial, sans-serif;
      resize: none;
    }
    .form-group textarea {
      min-height: 80px;
      max-height: 180px;
    }
    .form-group input[type="file"] {
      margin-top: 4px;
    }
    .file-note {
      color: #e57373;
      font-size: 0.95em;
      margin-left: 8px;
    }
    .remarks-group {
      flex: 1 1 100%;
      max-width: 100%;
      display: flex;
      flex-direction: column;
    }
    .remarks-group textarea {
      min-height: 80px;
      max-height: 180px;
      width: 100%;
    }
    .submit-btn {
      background: #009688;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 1.2em;
      font-weight: bold;
      padding: 16px 0;
      margin-top: 18px;
      width: 100%;
      cursor: pointer;
      transition: background 0.2s, transform 0.2s;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      letter-spacing: 1px;
    }
    .submit-btn:hover {
      background: #00796B;
      transform: translateY(-2px) scale(1.03);
    }
    @media (max-width: 900px) {
      .activity-form-container {
        margin: 18px 6px;
      }
      form {
        margin: 0 6px;
        padding: 18px 6px 18px 6px;
        gap: 18px 0;
      }
    }
  </style>
</head>
<body>
  <div class="header-bar">
    <h1>Create Activity</h1>
    <div class="header-icons">
      <img src="image/umpsa.png" alt="UMPSA" />
      <img src="image/bell.png" alt="Notifications" />
      <img src="image/Raccoon.gif" alt="Profile" />
    </div>
  </div>
  <div class="activity-form-container">
    <div class="activity-form-title">Activity</div>
    <form action="CreateActivityServlet" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="activityName">Activity Name</label>
        <input type="text" id="activityName" name="activityName" required />
      </div>
      <div class="form-group">
        <label for="attachFile">Attach File:</label>
        <input type="file" id="attachFile" name="attachFile" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png" />
        <span class="file-note">*THE FILE MUST NOT EXCEED 15MB</span>
      </div>
      <div class="form-group">
        <label for="description">Description</label>
        <textarea id="description" name="description" placeholder="Enter a description.." required></textarea>
      </div>
      <div class="form-group">
        <label for="date">Date</label>
        <input type="date" id="date" name="date" required />
      </div>
      <div class="remarks-group">
        <label for="remarks">Remarks</label>
        <textarea id="remarks" name="remarks" placeholder="Your Comments..."></textarea>
      </div>
      <button type="submit" class="submit-btn">Submit</button>
    </form>
  </div>
</body>
</html> 