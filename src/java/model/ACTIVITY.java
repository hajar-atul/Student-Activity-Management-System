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
       private String proposalFile;
       private String qrImage;
       private int clubID;
       
       // JDBC connection details
       private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
       private static final String DB_USER = "root";
       private static final String DB_PASSWORD = "";
       
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
    
    public void setProposalFile(String proposalFile) {
        this.proposalFile = proposalFile;
    }

    public String getProposalFile() {
        return proposalFile;
    }
    
    public void setQrImage(String qrImage) {
        this.qrImage = qrImage;
    }

    public String getQrImage() {
        return qrImage;
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
            
            // Since we're using a trigger to generate the ID, we don't need RETURN_GENERATED_KEYS
            String sql = "INSERT INTO activity (activityName, activityType, activityDesc, activityDate, activityVenue, activityStatus, activityBudget, proposalFile, qrImage, clubID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            // Set parameters with null checks
            stmt.setString(1, this.activityName != null ? this.activityName.trim() : "");
            stmt.setString(2, this.activityType != null ? this.activityType : "General");
            stmt.setString(3, this.activityDesc != null ? this.activityDesc.trim() : "");
            stmt.setString(4, this.activityDate != null ? this.activityDate : "");
            stmt.setString(5, this.activityVenue != null ? this.activityVenue.trim() : "");
            stmt.setString(6, this.activityStatus != null ? this.activityStatus : "Pending");
            stmt.setDouble(7, this.activityBudget);
            stmt.setString(8, this.proposalFile);
            stmt.setString(9, this.qrImage);
            stmt.setInt(10, this.clubID);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                // Since the trigger generates the ID, we need to get it from the database
                // Get the last inserted ID for this connection
                try (java.sql.Statement idStmt = conn.createStatement();
                     java.sql.ResultSet rs = idStmt.executeQuery("SELECT LAST_INSERT_ID()")) {
                    
                    if (rs.next()) {
                        // This won't work with VARCHAR IDs, so let's get the actual generated ID
                        // Get the maximum activityID which should be our newly inserted one
                        try (java.sql.Statement maxStmt = conn.createStatement();
                             java.sql.ResultSet maxRs = maxStmt.executeQuery("SELECT MAX(activityID) as maxID FROM activity")) {
                            
                            if (maxRs.next()) {
                                generatedId = maxRs.getString("maxID");
                                if (generatedId != null && !generatedId.trim().isEmpty()) {
                                    this.activityID = generatedId;
                                    // Commit the transaction
                                    conn.commit();
                                } else {
                                    // Rollback if no valid ID was found
                                    conn.rollback();
                                    throw new RuntimeException("Failed to retrieve generated activity ID");
                                }
                            } else {
                                // Rollback if no ID was found
                                conn.rollback();
                                throw new RuntimeException("No activity ID found after insertion");
                            }
                        }
                    } else {
                        // Rollback if no last insert ID
                        conn.rollback();
                        throw new RuntimeException("No last insert ID returned");
                    }
                }
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
                    activity.setProposalFile(rs.getString("proposalFile"));
                    activity.setQrImage(rs.getString("qrImage"));
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
        java.util.List<ACTIVITY> activities = new java.util.ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM activity";
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
                    activity.setProposalFile(rs.getString("proposalFile"));
                    activity.setQrImage(rs.getString("qrImage"));
                    activity.setClubID(rs.getInt("clubID"));
                    activities.add(activity);
                }
            }
        } catch (Exception e) {
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
                    activity.setProposalFile(rs.getString("proposalFile"));
                    activity.setQrImage(rs.getString("qrImage"));
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
                           "INNER JOIN registeration r ON s.studID = r.studID " +
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
                String sql = "SELECT COUNT(*) FROM registeration WHERE activityID = ?";
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
            
            // Insert with the generated ID
            String sql = "INSERT INTO activity (activityID, activityName, activityType, activityDesc, activityDate, activityVenue, activityStatus, activityBudget, adabPoint, proposalFile, qrImage, clubID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            stmt.setString(10, this.proposalFile);
            stmt.setString(11, this.qrImage);
            stmt.setInt(12, this.clubID);
            
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
}
