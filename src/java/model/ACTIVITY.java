package model;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author User
 */
public class ACTIVITY {
       private String activityID;
       private String activityName;
       private String activityType;
       private String activityDesc;
       private String activityDate;
       private String activityVenue;
       private String activityStatus;
       private double activityBudget;
       private int adabPoint;
       private byte[] proposalFile;
       private byte[] qrImage;
       private byte[] posterImage;
       private int clubID;
       
       // JDBC connection details
       private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
       private static final String DB_USER = "root";
       private static final String DB_PASSWORD = "";
       
       private static String lastError = null;
       public static String getLastError() { return lastError; }
       
        public void setActivityID(String activityID) {
        this.activityID = activityID;
    }

    public String getActivityID() {
        return activityID;
    }
    
     public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public String getActivityName() {
        return activityName;
    }
    
    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getActivityType() {
        return activityType;
    }
    
     public void setActivityDesc(String activityDesc) {
        this.activityDesc = activityDesc;
    }

    public String getActivityDesc() {
        return activityDesc;
    }
    
      public void setActivityDate(String activityDate) {
        this.activityDate = activityDate;
    }

    public String getActivityDate() {
        return activityDate;
    }
    
      public void setActivityVenue(String activityVenue) {
        this.activityVenue = activityVenue;
    }

    public String getActivityVenue() {
        return activityVenue;
    }
    
      public void setActivityStatus(String activityStatus) {
        this.activityStatus = activityStatus;
    }

    public String getActivityStatus() {
        return activityStatus;
    }
    
      public void setActivityBudget(double activityBudget) {
        this.activityBudget = activityBudget;
    }

    public double getActivityBudget() {
        return activityBudget;
    }
    
    public void setAdabPoint(int adabPoint) {
        this.adabPoint = adabPoint;
    }

    public int getAdabPoint() {
        return adabPoint;
    }
    
    public void setProposalFile(byte[] proposalFile) {
        this.proposalFile = proposalFile;
    }

    public byte[] getProposalFile() {
        return proposalFile;
    }
    
    public void setQrImage(byte[] qrImage) {
        this.qrImage = qrImage;
    }

    public byte[] getQrImage() {
        return qrImage;
    }
    
    public void setPosterImage(byte[] posterImage) {
        this.posterImage = posterImage;
    }

    public byte[] getPosterImage() {
        return posterImage;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public int getClubID() {
        return clubID;
    }

    // Save this activity and return generated activityID
    public String saveAndReturnId() {
        String generatedId = null;
        java.sql.Connection conn = null;
        java.sql.PreparedStatement stmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            
            // Disable auto-commit to manage transaction manually
            conn.setAutoCommit(false);
            
            // Generate the next ID in Java
            generatedId = generateNextActivityId(conn);
            
            // Insert with the generated ID and BLOB support
            String sql = "INSERT INTO activity (activityID, activityName, activityType, activityDesc, activityDate, activityVenue, activityStatus, activityBudget, adabPoint, proposalFile, qrImage, posterImage, clubID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            // Set parameters with null checks
            stmt.setString(1, generatedId);
            stmt.setString(2, this.activityName != null ? this.activityName.trim() : "");
            stmt.setString(3, this.activityType != null ? this.activityType : "General");
            stmt.setString(4, this.activityDesc != null ? this.activityDesc.trim() : "");
            stmt.setString(5, this.activityDate != null ? this.activityDate : "");
            stmt.setString(6, this.activityVenue != null ? this.activityVenue.trim() : "");
            stmt.setString(7, this.activityStatus != null ? this.activityStatus : "Pending");
            stmt.setDouble(8, this.activityBudget);
            stmt.setInt(9, this.adabPoint);
            stmt.setBytes(10, this.proposalFile);
            stmt.setBytes(11, this.qrImage);
            stmt.setBytes(12, this.posterImage);
            stmt.setInt(13, this.clubID);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                this.activityID = generatedId;
                // Commit the transaction
                conn.commit();
            } else {
                // Rollback if no rows were affected
                conn.rollback();
                throw new RuntimeException("No rows were inserted into the database");
            }
            
        } catch (ClassNotFoundException e) {
            rollbackTransaction(conn);
            throw new RuntimeException("Database driver not found: " + e.getMessage(), e);
        } catch (java.sql.SQLException e) {
            rollbackTransaction(conn);
            throw new RuntimeException("Database error occurred: " + e.getMessage(), e);
        } catch (Exception e) {
            rollbackTransaction(conn);
            throw new RuntimeException("Unexpected error occurred: " + e.getMessage(), e);
        } finally {
            // Close resources in reverse order
            closeResources(null, stmt, conn);
        }
        
        return generatedId;
    }
    
    // Helper method to rollback transaction
    private void rollbackTransaction(java.sql.Connection conn) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (java.sql.SQLException rollbackEx) {
                // Log rollback error but don't throw it
                System.err.println("Error rolling back transaction: " + rollbackEx.getMessage());
            }
        }
    }
    
    // Helper method to close resources
    private void closeResources(java.sql.ResultSet rs, java.sql.PreparedStatement stmt, java.sql.Connection conn) {
        if (rs != null) {
            try {
                rs.close();
            } catch (java.sql.SQLException e) {
                System.err.println("Error closing ResultSet: " + e.getMessage());
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (java.sql.SQLException e) {
                System.err.println("Error closing PreparedStatement: " + e.getMessage());
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (java.sql.SQLException e) {
                System.err.println("Error closing Connection: " + e.getMessage());
            }
        }
    }

    // Get activity by ID
    public static ACTIVITY getActivityById(String id) {
        ACTIVITY activity = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM activity WHERE activityID = ?";
                java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, id);
                java.sql.ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    activity = new ACTIVITY();
                    activity.setActivityID(rs.getString("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityType(rs.getString("activityType"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
                    activity.setAdabPoint(rs.getInt("adabPoint"));
                    activity.setProposalFile(rs.getBytes("proposalFile"));
                    activity.setQrImage(rs.getBytes("qrImage"));
                    activity.setPosterImage(rs.getBytes("posterImage"));
                    activity.setClubID(rs.getInt("clubID"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activity;
    }

    // Get all activities
    public static java.util.List<ACTIVITY> getAllActivities() {
        lastError = null;
        java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM activity WHERE activityStatus = 'Approved'";
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    ACTIVITY activity = new ACTIVITY();
                    activity.setActivityID(rs.getString("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityType(rs.getString("activityType"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
                    activity.setAdabPoint(rs.getInt("adabPoint"));
                    activity.setProposalFile(rs.getBytes("proposalFile"));
                    activity.setQrImage(rs.getBytes("qrImage"));
                    activity.setPosterImage(rs.getBytes("posterImage"));
                    activity.setClubID(rs.getInt("clubID"));
                    activities.add(activity);
                }
            }
        } catch (Exception e) {
            lastError = e.toString();
            e.printStackTrace();
        }
        return activities;
    }

    // Get all activities for a specific club
    public static java.util.List<ACTIVITY> getActivitiesByClubId(int clubId) {
        java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM activity WHERE clubID = ?";
                java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, clubId);
                java.sql.ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    ACTIVITY activity = new ACTIVITY();
                    activity.setActivityID(rs.getString("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityType(rs.getString("activityType"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
                    activity.setAdabPoint(rs.getInt("adabPoint"));
                    activity.setProposalFile(rs.getBytes("proposalFile"));
                    activity.setQrImage(rs.getBytes("qrImage"));
                    activity.setPosterImage(rs.getBytes("posterImage"));
                    activity.setClubID(rs.getInt("clubID"));
                    activities.add(activity);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activities;
    }

    // Get participants for a specific activity
    public static java.util.List<STUDENT> getParticipantsByActivityId(String activityId) {
        java.util.List<STUDENT> participants = new java.util.ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT s.* FROM student s " +
                           "INNER JOIN registration r ON s.studID = r.studID " +
                           "WHERE r.activityID = ?";
                java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, activityId);
                java.sql.ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    STUDENT student = new STUDENT();
                    student.setStudID(rs.getInt("studID"));
                    student.setStudName(rs.getString("studName"));
                    student.setStudEmail(rs.getString("studEmail"));
                    student.setStudCourse(rs.getString("studCourse"));
                    student.setStudSemester(rs.getString("studSemester"));
                    student.setStudNoPhone(rs.getString("studNoPhone"));
                    student.setStudType(rs.getString("studType"));
                    student.setDob(rs.getString("dob"));
                    student.setMuetStatus(rs.getString("muetStatus"));
                    student.setAdvisor(rs.getString("advisor"));
                    participants.add(student);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return participants;
    }

    // Get participant count for a specific activity
    public static int getParticipantCount(String activityId) {
        int count = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT COUNT(*) FROM registration WHERE activityID = ?";
                java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, activityId);
                java.sql.ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Alternative method: Generate ID in Java instead of using trigger
    public String saveAndReturnIdSimple() {
        String generatedId = null;
        java.sql.Connection conn = null;
        java.sql.PreparedStatement stmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            
            // Disable auto-commit to manage transaction manually
            conn.setAutoCommit(false);
            
            // Generate the next ID in Java
            generatedId = generateNextActivityId(conn);
            
            // Insert with the generated ID and BLOB support
            String sql = "INSERT INTO activity (activityID, activityName, activityType, activityDesc, activityDate, activityVenue, activityStatus, activityBudget, adabPoint, proposalFile, qrImage, posterImage, clubID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            // Set parameters with null checks
            stmt.setString(1, generatedId);
            stmt.setString(2, this.activityName != null ? this.activityName.trim() : "");
            stmt.setString(3, this.activityType != null ? this.activityType : "General");
            stmt.setString(4, this.activityDesc != null ? this.activityDesc.trim() : "");
            stmt.setString(5, this.activityDate != null ? this.activityDate : "");
            stmt.setString(6, this.activityVenue != null ? this.activityVenue.trim() : "");
            stmt.setString(7, this.activityStatus != null ? this.activityStatus : "Pending");
            stmt.setDouble(8, this.activityBudget);
            stmt.setInt(9, this.adabPoint);
            stmt.setBytes(10, this.proposalFile);
            stmt.setBytes(11, this.qrImage);
            stmt.setBytes(12, this.posterImage);
            stmt.setInt(13, this.clubID);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                this.activityID = generatedId;
                // Commit the transaction
                conn.commit();
            } else {
                // Rollback if no rows were affected
                conn.rollback();
                throw new RuntimeException("No rows were inserted into the database");
            }
            
        } catch (ClassNotFoundException e) {
            rollbackTransaction(conn);
            throw new RuntimeException("Database driver not found: " + e.getMessage(), e);
        } catch (java.sql.SQLException e) {
            rollbackTransaction(conn);
            throw new RuntimeException("Database error occurred: " + e.getMessage(), e);
        } catch (Exception e) {
            rollbackTransaction(conn);
            throw new RuntimeException("Unexpected error occurred: " + e.getMessage(), e);
        } finally {
            // Close resources in reverse order
            closeResources(null, stmt, conn);
        }
        
        return generatedId;
    }
    
    // Helper method to generate next activity ID
    private String generateNextActivityId(java.sql.Connection conn) throws java.sql.SQLException {
        String maxId = null;
        
        try (java.sql.Statement stmt = conn.createStatement();
             java.sql.ResultSet rs = stmt.executeQuery("SELECT MAX(activityID) as maxID FROM activity")) {
            
            if (rs.next()) {
                maxId = rs.getString("maxID");
            }
        }
        
        int nextNum;
        if (maxId == null || maxId.trim().isEmpty()) {
            nextNum = 1;
        } else {
            // Extract numeric part from 'A001' → 1
            String numPart = maxId.substring(1); // Remove 'A' prefix
            nextNum = Integer.parseInt(numPart) + 1;
        }
        
        // Format as 'A001', 'A002', etc.
        return String.format("A%03d", nextNum);
    }
    
    // Get only available activities (e.g., activityStatus = 'Available')
public static java.util.List<ACTIVITY> getAvailableActivities() {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM activity WHERE activityStatus = 'Available'";
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            java.sql.ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ACTIVITY activity = new ACTIVITY();
                activity.setActivityID(rs.getString("activityID"));
                activity.setActivityName(rs.getString("activityName"));
                activity.setActivityType(rs.getString("activityType"));
                activity.setActivityDesc(rs.getString("activityDesc"));
                activity.setActivityDate(rs.getString("activityDate"));
                activity.setActivityVenue(rs.getString("activityVenue"));
                activity.setActivityStatus(rs.getString("activityStatus"));
                activity.setActivityBudget(rs.getDouble("activityBudget"));
                activity.setAdabPoint(rs.getInt("adabPoint"));
                activity.setProposalFile(rs.getBytes("proposalFile"));
                activity.setQrImage(rs.getBytes("qrImage"));
                activity.setPosterImage(rs.getBytes("posterImage"));
                activity.setClubID(rs.getInt("clubID"));
                activities.add(activity);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

// Get available upcoming activities that the student hasn't registered for yet
public static java.util.List<ACTIVITY> getAvailableUpcomingActivitiesForStudent(String studID) {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT a.* FROM activity a " +
                        "WHERE LOWER(TRIM(a.activityStatus)) = 'approved' " +
                        "AND a.activityDate >= CURDATE() " +
                        "AND a.activityID NOT IN (SELECT r.activityID FROM registration r WHERE r.studID = ?) " +
                        "ORDER BY a.activityDate ASC";
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, studID);
                try (java.sql.ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ACTIVITY activity = new ACTIVITY();
                        activity.setActivityID(rs.getString("activityID"));
                        activity.setActivityName(rs.getString("activityName"));
                        activity.setActivityType(rs.getString("activityType"));
                        activity.setActivityDesc(rs.getString("activityDesc"));
                        activity.setActivityDate(rs.getString("activityDate"));
                        activity.setActivityVenue(rs.getString("activityVenue"));
                        activity.setActivityStatus(rs.getString("activityStatus"));
                        activity.setActivityBudget(rs.getDouble("activityBudget"));
                        activity.setAdabPoint(rs.getInt("adabPoint"));
                        activity.setProposalFile(rs.getBytes("proposalFile"));
                        activity.setQrImage(rs.getBytes("qrImage"));
                        activity.setPosterImage(rs.getBytes("posterImage"));
                        activity.setClubID(rs.getInt("clubID"));
                        activities.add(activity);
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

// Get available future activities (status = 'approved' AND date >= today) - for backward compatibility
public static java.util.List<ACTIVITY> getAvailableUpcomingActivities() {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM activity WHERE LOWER(TRIM(activityStatus)) = 'approved' AND activityDate >= CURDATE() ORDER BY activityDate ASC";
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
                 java.sql.ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    ACTIVITY activity = new ACTIVITY();
                    activity.setActivityID(rs.getString("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityType(rs.getString("activityType"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
                    activity.setAdabPoint(rs.getInt("adabPoint"));
                    activity.setProposalFile(rs.getBytes("proposalFile"));
                    activity.setQrImage(rs.getBytes("qrImage"));
                    activity.setPosterImage(rs.getBytes("posterImage"));
                    activity.setClubID(rs.getInt("clubID"));
                    activities.add(activity);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

// Get activities held today or in the last 3 days
public static java.util.List<ACTIVITY> getCurrentActivities() {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM activity WHERE activityDate BETWEEN DATE_SUB(CURDATE(), INTERVAL 3 DAY) AND CURDATE() ORDER BY activityDate DESC";
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
                 java.sql.ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ACTIVITY activity = new ACTIVITY();
                    activity.setActivityID(rs.getString("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityType(rs.getString("activityType"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
                    activity.setAdabPoint(rs.getInt("adabPoint"));
                    activity.setProposalFile(rs.getBytes("proposalFile"));
                    activity.setQrImage(rs.getBytes("qrImage"));
                    activity.setPosterImage(rs.getBytes("posterImage"));
                    activity.setClubID(rs.getInt("clubID"));
                    activities.add(activity);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

// Get all activities a student has joined
public static java.util.List<ACTIVITY> getActivitiesByStudentId(String studID) {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT a.* FROM activity a INNER JOIN registration r ON a.activityID = r.activityID WHERE r.studID = ?";
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, studID);
                try (java.sql.ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ACTIVITY activity = new ACTIVITY();
                        activity.setActivityID(rs.getString("activityID"));
                        activity.setActivityName(rs.getString("activityName"));
                        activity.setActivityType(rs.getString("activityType"));
                        activity.setActivityDesc(rs.getString("activityDesc"));
                        activity.setActivityDate(rs.getString("activityDate"));
                        activity.setActivityVenue(rs.getString("activityVenue"));
                        activity.setActivityStatus(rs.getString("activityStatus"));
                        activity.setActivityBudget(rs.getDouble("activityBudget"));
                        activity.setAdabPoint(rs.getInt("adabPoint"));
                        activity.setProposalFile(rs.getBytes("proposalFile"));
                        activity.setQrImage(rs.getBytes("qrImage"));
                        activity.setPosterImage(rs.getBytes("posterImage"));
                        activity.setClubID(rs.getInt("clubID"));
                        activities.add(activity);
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

// Get registered activities for a student that are upcoming (current and future)
public static java.util.List<ACTIVITY> getRegisteredUpcomingActivities(String studID) {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT a.* FROM activity a INNER JOIN registration r ON a.activityID = r.activityID " +
                        "WHERE r.studID = ? AND a.activityDate >= CURDATE() " +
                        "ORDER BY a.activityDate ASC";
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, studID);
                try (java.sql.ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ACTIVITY activity = new ACTIVITY();
                        activity.setActivityID(rs.getString("activityID"));
                        activity.setActivityName(rs.getString("activityName"));
                        activity.setActivityType(rs.getString("activityType"));
                        activity.setActivityDesc(rs.getString("activityDesc"));
                        activity.setActivityDate(rs.getString("activityDate"));
                        activity.setActivityVenue(rs.getString("activityVenue"));
                        activity.setActivityStatus(rs.getString("activityStatus"));
                        activity.setActivityBudget(rs.getDouble("activityBudget"));
                        activity.setAdabPoint(rs.getInt("adabPoint"));
                        activity.setProposalFile(rs.getBytes("proposalFile"));
                        activity.setQrImage(rs.getBytes("qrImage"));
                        activity.setPosterImage(rs.getBytes("posterImage"));
                        activity.setClubID(rs.getInt("clubID"));
                        activities.add(activity);
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

// Get registered activities for a student that are past (completed)
public static java.util.List<ACTIVITY> getRegisteredPastActivities(String studID) {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT a.* FROM activity a INNER JOIN registration r ON a.activityID = r.activityID " +
                        "WHERE r.studID = ? AND a.activityDate < CURDATE() " +
                        "ORDER BY a.activityDate DESC";
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, studID);
                try (java.sql.ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ACTIVITY activity = new ACTIVITY();
                        activity.setActivityID(rs.getString("activityID"));
                        activity.setActivityName(rs.getString("activityName"));
                        activity.setActivityType(rs.getString("activityType"));
                        activity.setActivityDesc(rs.getString("activityDesc"));
                        activity.setActivityDate(rs.getString("activityDate"));
                        activity.setActivityVenue(rs.getString("activityVenue"));
                        activity.setActivityStatus(rs.getString("activityStatus"));
                        activity.setActivityBudget(rs.getDouble("activityBudget"));
                        activity.setAdabPoint(rs.getInt("adabPoint"));
                        activity.setProposalFile(rs.getBytes("proposalFile"));
                        activity.setQrImage(rs.getBytes("qrImage"));
                        activity.setPosterImage(rs.getBytes("posterImage"));
                        activity.setClubID(rs.getInt("clubID"));
                        activities.add(activity);
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

// Get the count of unique clubs a student has joined
public static int getClubCountByStudentId(String studID) {
    int count = 0;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT COUNT(DISTINCT a.clubID) FROM activity a INNER JOIN registration r ON a.activityID = r.activityID WHERE r.studID = ?";
            try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, studID);
                try (java.sql.ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

public static int getAdabPointByActivityId(int activityID) {
    int adabPoint = 0;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT adabPoint FROM activity WHERE activityID = ?";
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, activityID);
            java.sql.ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                adabPoint = rs.getInt("adabPoint");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return adabPoint;
}

public static void updateActivityStatus(String activityID, String newStatus) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE activity SET activityStatus = ? WHERE activityID = ?";
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newStatus);
            stmt.setString(2, activityID);
            stmt.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public static java.util.List<ACTIVITY> getActivitiesByStatus(String status) {
    java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM activity WHERE TRIM(LOWER(activityStatus)) = ?";
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status.trim().toLowerCase());
            java.sql.ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ACTIVITY activity = new ACTIVITY();
                activity.setActivityID(rs.getString("activityID"));
                activity.setActivityName(rs.getString("activityName"));
                activity.setActivityType(rs.getString("activityType"));
                activity.setActivityDesc(rs.getString("activityDesc"));
                activity.setActivityDate(rs.getString("activityDate"));
                activity.setActivityVenue(rs.getString("activityVenue"));
                activity.setActivityStatus(rs.getString("activityStatus"));
                activity.setActivityBudget(rs.getDouble("activityBudget"));
                activity.setAdabPoint(rs.getInt("adabPoint"));
                activity.setProposalFile(rs.getBytes("proposalFile"));
                activity.setQrImage(rs.getBytes("qrImage"));
                activity.setPosterImage(rs.getBytes("posterImage"));
                activity.setClubID(rs.getInt("clubID"));
                activities.add(activity);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return activities;
}

}
