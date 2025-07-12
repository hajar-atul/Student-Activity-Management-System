<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Create Activity</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      box-sizing: border-box;
    }
    
    body {
      font-family: 'Poppins', Arial, sans-serif;
      background: linear-gradient(135deg, #e0f2f1 0%, #b2dfdb 100%);
      margin: 0;
      padding: 0;
      height: 100vh;
      overflow: hidden;
    }
    
    .header-bar {
      background: linear-gradient(135deg, #009688 0%, #00796b 100%);
      color: #fff;
      padding: 12px 24px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      box-shadow: 0 2px 10px rgba(0, 150, 136, 0.3);
      height: 60px;
    }
    
    .header-bar h1 {
      font-size: 1.6em;
      font-weight: 600;
      margin: 0;
      letter-spacing: -0.5px;
    }
    
    .header-icons {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    
    .header-icons img {
      height: 32px;
      width: 32px;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.2);
      padding: 4px;
      transition: transform 0.2s ease;
    }
    
    .header-icons img:hover {
      transform: scale(1.1);
    }
    
    .main-container {
      display: flex;
      height: calc(100vh - 60px);
      padding: 16px;
      gap: 16px;
    }
    
    .form-section {
      flex: 1;
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }
    
    .form-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, #009688, #00796b, #004d40);
    }
    
    .section-title {
      background: linear-gradient(135deg, #009688 0%, #00796b 100%);
      color: #fff;
      padding: 16px 24px;
      font-size: 1.2em;
      font-weight: 600;
      margin: 0;
      letter-spacing: 0.3px;
    }
    
    .message-container {
      padding: 12px 24px;
    }
    
    .success-message {
      background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
      color: #2e7d32;
      padding: 10px 16px;
      border-radius: 8px;
      font-weight: 500;
      border-left: 3px solid #4caf50;
      font-size: 0.9em;
    }
    
    .error-message {
      background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
      color: #c62828;
      padding: 10px 16px;
      border-radius: 8px;
      font-weight: 500;
      border-left: 3px solid #f44336;
      font-size: 0.9em;
    }
    
    .form-content {
      flex: 1;
      padding: 20px 24px;
      overflow-y: auto;
    }
    
    form {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 16px;
      height: 100%;
    }
    
    .form-group {
      display: flex;
      flex-direction: column;
    }
    
    .form-group.full-width {
      grid-column: 1 / -1;
    }
    
    .form-group label {
      font-weight: 600;
      margin-bottom: 6px;
      color: #263238;
      font-size: 0.9em;
      letter-spacing: 0.2px;
    }
    
    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="number"],
    .form-group select,
    .form-group textarea {
      padding: 10px 12px;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      font-size: 0.9em;
      background: #fafafa;
      font-family: 'Poppins', Arial, sans-serif;
      transition: all 0.3s ease;
      color: #333;
    }
    
    .form-group input[type="text"]:focus,
    .form-group input[type="date"]:focus,
    .form-group input[type="number"]:focus,
    .form-group select:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: #009688;
      background: #fff;
      box-shadow: 0 0 0 3px rgba(0, 150, 136, 0.1);
    }
    
    .form-group select {
      cursor: pointer;
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
      background-position: right 8px center;
      background-repeat: no-repeat;
      background-size: 12px;
      padding-right: 30px;
    }
    
    .form-group textarea {
      min-height: 80px;
      max-height: 120px;
      resize: vertical;
    }
    
    .form-group input[type="file"] {
      padding: 8px;
      border: 2px dashed #bdbdbd;
      border-radius: 8px;
      background: #f8f9fa;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 0.85em;
    }
    
    .form-group input[type="file"]:hover {
      border-color: #009688;
      background: #e0f2f1;
    }
    
    .form-group input[type="file"]:focus {
      outline: none;
      border-color: #009688;
      box-shadow: 0 0 0 3px rgba(0, 150, 136, 0.1);
    }
    
    .file-note {
      color: #666;
      font-size: 0.75em;
      margin-top: 4px;
      font-style: italic;
    }
    
    .required-note {
      color: #f44336;
      font-size: 0.75em;
      margin-top: 4px;
      font-weight: 500;
      display: flex;
      align-items: center;
      gap: 3px;
    }
    
    .required-note::before {
      content: "⚠️";
      font-size: 0.8em;
    }
    
    .help-text {
      color: #666;
      font-size: 0.75em;
      margin-top: 3px;
      opacity: 0.8;
    }
    
    .submit-section {
      grid-column: 1 / -1;
      text-align: center;
      margin-top: 16px;
      padding-top: 16px;
      border-top: 1px solid #e0e0e0;
    }
    
    .submit-btn {
      background: linear-gradient(135deg, #009688 0%, #00796b 100%);
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 1em;
      font-weight: 600;
      padding: 12px 32px;
      cursor: pointer;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(0, 150, 136, 0.3);
      letter-spacing: 0.3px;
      min-width: 160px;
      position: relative;
      overflow: hidden;
    }
    
    .submit-btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s;
    }
    
    .submit-btn:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 20px rgba(0, 150, 136, 0.4);
    }
    
    .submit-btn:hover::before {
      left: 100%;
    }
    
    .submit-btn:active {
      transform: translateY(0);
    }
    
    /* Custom scrollbar for form content */
    .form-content::-webkit-scrollbar {
      width: 6px;
    }
    
    .form-content::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 3px;
    }
    
    .form-content::-webkit-scrollbar-thumb {
      background: #009688;
      border-radius: 3px;
    }
    
    .form-content::-webkit-scrollbar-thumb:hover {
      background: #00796b;
    }
    
    @media (max-width: 1024px) {
      .main-container {
        flex-direction: column;
        height: calc(100vh - 60px);
        padding: 12px;
      }
      
      .form-section {
        flex: none;
        height: auto;
        max-height: calc(100vh - 120px);
      }
      
      form {
        grid-template-columns: 1fr;
        gap: 12px;
      }
      
      .form-content {
        padding: 16px 20px;
      }
    }
    
    @media (max-width: 768px) {
      .header-bar {
        padding: 10px 16px;
        height: 50px;
      }
      
      .header-bar h1 {
        font-size: 1.4em;
      }
      
      .header-icons img {
        height: 28px;
        width: 28px;
      }
      
      .main-container {
        height: calc(100vh - 50px);
        padding: 8px;
      }
      
      .section-title {
        padding: 12px 16px;
        font-size: 1.1em;
      }
      
      .form-content {
        padding: 12px 16px;
      }
      
      .submit-btn {
        width: 100%;
        padding: 12px 24px;
      }
    }
    
    @media (max-width: 480px) {
      .header-icons {
        gap: 8px;
      }
      
      .header-icons img {
        height: 24px;
        width: 24px;
      }
      
      .main-container {
        padding: 6px;
      }
      
      .form-content {
        padding: 10px 12px;
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
  
  <div class="main-container">
    <div class="form-section">
      <div class="section-title">Activity Details</div>
      
      <!-- Success/Error Messages -->
      <div class="message-container">
        <% 
          String successMsg = request.getParameter("success");
          String errorMsg = request.getParameter("error");
          if (successMsg != null) {
        %>
          <div class="success-message">
            <%= successMsg.replace("+", " ") %>
          </div>
        <% } %>
        <% if (errorMsg != null) { %>
          <div class="error-message">
            <%= errorMsg.replace("+", " ") %>
          </div>
        <% } %>
      </div>
      
      <div class="form-content">
        <form action="CreateActivityServlet" method="post" enctype="multipart/form-data">
          <div class="form-group">
            <label for="activityName">Activity Name</label>
            <input type="text" id="activityName" name="activityName" maxlength="500" required placeholder="Enter activity name..." />
            <div class="help-text">Max 500 characters</div>
          </div>
          
          <div class="form-group">
            <label for="activityType">Activity Type</label>
            <select id="activityType" name="activityType" required onchange="toggleQrUpload()">
              <option value="">Select Type</option>
              <option value="Free">Free</option>
              <option value="Paid">Paid</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="venueName">Venue</label>
            <select id="venueName" name="venueName" required>
              <option value="">Select Venue</option>
              <option value="Dewan Serbaguna">Dewan Serbaguna</option>
              <option value="Dewan Aspirasi">Dewan Aspirasi</option>
              <option value="Dewan Tengku Hassanal">Dewan Tengku Hassanal</option>
              <option value="Dewan Chanselor">Dewan Chanselor</option>
              <option value="Dewan Ibnu Battuta">Dewan Ibnu Battuta</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="date">Date</label>
            <input type="date" id="date" name="date" required />
          </div>
          
          <div class="form-group">
            <label for="proposedBudget">Budget (RM)</label>
            <input type="number" id="proposedBudget" name="proposedBudget" step="0.01" min="0" placeholder="0.00" required />
          </div>
          
          <div class="form-group">
            <label for="adabPoint">Adab Points</label>
            <input type="number" id="adabPoint" name="adabPoint" min="0" max="1000" placeholder="0" required />
            <div class="help-text">0-100 points</div>
          </div>
          
          <div class="form-group">
            <label for="posterImage">Poster Image</label>
            <input type="file" id="posterImage" name="posterImage" accept=".jpg,.jpeg,.png" />
            <div class="file-note">JPG, JPEG, PNG only</div>
          </div>
          
          <div class="form-group" id="qrImageGroup" style="display: none;">
            <label for="qrImage">QR/Banking Image</label>
            <input type="file" id="qrImage" name="qrImage" accept=".jpg,.jpeg,.png" />
            <div class="file-note">For paid activities</div>
            <div class="required-note" id="qrRequiredNote" style="display: none;">Required for paid activities</div>
          </div>
          
          <div class="form-group full-width">
            <label for="description">Description</label>
            <textarea id="description" name="description" placeholder="Enter activity description..." maxlength="65535" required></textarea>
            <div class="help-text">Max 65,535 characters</div>
          </div>
          
          <div class="form-group full-width">
            <label for="proposalFile">Proposal File</label>
            <input type="file" id="proposalFile" name="proposalFile" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png" />
            <div class="file-note">Max 15MB</div>
          </div>
          
          <div class="submit-section">
            <button type="submit" class="submit-btn">Create Activity</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  
  <script>
    function toggleQrUpload() {
      const activityType = document.getElementById('activityType').value;
      const qrImageGroup = document.getElementById('qrImageGroup');
      const qrImageInput = document.getElementById('qrImage');
      const qrRequiredNote = document.getElementById('qrRequiredNote');
      
      if (activityType === 'Paid') {
        qrImageGroup.style.display = 'flex';
        qrImageInput.required = true;
        qrRequiredNote.style.display = 'flex';
      } else {
        qrImageGroup.style.display = 'none';
        qrImageInput.required = false;
        qrRequiredNote.style.display = 'none';
        qrImageInput.value = '';
      }
    }
    
    // Add smooth animations for form elements
    document.addEventListener('DOMContentLoaded', function() {
      const formGroups = document.querySelectorAll('.form-group');
      formGroups.forEach((group, index) => {
        group.style.opacity = '0';
        group.style.transform = 'translateY(10px)';
        setTimeout(() => {
          group.style.transition = 'all 0.4s ease';
          group.style.opacity = '1';
          group.style.transform = 'translateY(0)';
        }, index * 50);
      });
    });
  </script>
</body>
</html> 