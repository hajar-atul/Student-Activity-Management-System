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
       private int activityID;
       private String activityName;
       private String activityDesc;
       private String activityDate;
       private String activityVenue;
       private String activityStatus;
       private double activityBudget;
       private int clubID;
       
       // JDBC connection details
       private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
       private static final String DB_USER = "root";
       private static final String DB_PASSWORD = "";
       
        public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public int getActivityID() {
        return activityID;
    }
    
     public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public String getActivityName() {
        return activityName;
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

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public int getClubID() {
        return clubID;
    }

    // Save this activity and return generated activityID
    public int saveAndReturnId() {
        int generatedId = -1;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO activity (activityName, activityDesc, activityDate, activityVenue, activityStatus, activityBudget, clubID) VALUES (?, ?, ?, ?, ?, ?, ?)";
                java.sql.PreparedStatement stmt = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
                stmt.setString(1, this.activityName);
                stmt.setString(2, this.activityDesc);
                stmt.setString(3, this.activityDate);
                stmt.setString(4, this.activityVenue);
                stmt.setString(5, this.activityStatus);
                stmt.setDouble(6, this.activityBudget);
                stmt.setInt(7, this.clubID);
                int affectedRows = stmt.executeUpdate();
                if (affectedRows > 0) {
                    try (java.sql.ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            generatedId = generatedKeys.getInt(1);
                            this.activityID = generatedId;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // Get activity by ID
    public static ACTIVITY getActivityById(int id) {
        ACTIVITY activity = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM activity WHERE activityID = ?";
                java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, id);
                java.sql.ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    activity = new ACTIVITY();
                    activity.setActivityID(rs.getInt("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
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
                    activity.setActivityID(rs.getInt("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
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
                    activity.setActivityID(rs.getInt("activityID"));
                    activity.setActivityName(rs.getString("activityName"));
                    activity.setActivityDesc(rs.getString("activityDesc"));
                    activity.setActivityDate(rs.getString("activityDate"));
                    activity.setActivityVenue(rs.getString("activityVenue"));
                    activity.setActivityStatus(rs.getString("activityStatus"));
                    activity.setActivityBudget(rs.getDouble("activityBudget"));
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
