/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author User
 */
public class CLUB {
    private int clubID;
    private String clubName;
    private String clubContact;
    private String clubDesc;
    private String clubStatus;
    private String clubEstablishedDate;
    private String clubPassword;
    private int studID;
    private String profilePic;
    private byte[] profilePicBlob;
    
    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Get club by ID
    public static CLUB getClubById(int clubID) {
        CLUB club = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM club WHERE clubID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, clubID);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    club = new CLUB();
                    club.setClubId(rs.getInt("clubID"));
                    club.setClubName(rs.getString("clubName"));
                    club.setClubContact(rs.getString("clubContact"));
                    club.setClubDesc(rs.getString("clubDesc"));
                    club.setClubStatus(rs.getString("clubStatus"));
                    club.setClubEstablishedDate(rs.getString("clubEstablishedDate"));
                    club.setClubPassword(rs.getString("clubPassword"));
                    try {
                        club.setProfilePic(rs.getString("profilePic"));
                    } catch (SQLException e) {
                        club.setProfilePic(null);
                    }
                    try {
                        club.setProfilePicBlob(rs.getBytes("profilePicBlob"));
                    } catch (SQLException e) {
                        club.setProfilePicBlob(null);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return club;
    }

    // Get all clubs
    public static List<CLUB> getAllClubs() {
        List<CLUB> clubs = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM club";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    CLUB club = new CLUB();
                    club.setClubId(rs.getInt("clubID"));
                    club.setClubName(rs.getString("clubName"));
                    club.setClubContact(rs.getString("clubContact"));
                    club.setClubDesc(rs.getString("clubDesc"));
                    club.setClubStatus(rs.getString("clubStatus"));
                    club.setClubEstablishedDate(rs.getString("clubEstablishedDate"));
                    club.setClubPassword(rs.getString("clubPassword"));
                    clubs.add(club);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clubs;
    }

    // Get total number of clubs
    public static int getTotalClubs() {
        int totalClubs = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT COUNT(*) FROM club";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                if (rs.next()) {
                    totalClubs = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalClubs;
    }

    // Save new club and return generated clubID
    public int saveAndReturnId() {
        int generatedId = -1;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "INSERT INTO club (clubName, clubContact, clubDesc, clubStatus, clubEstablishedDate, clubPassword, profilePic, profilePicBlob) " +
                             "VALUES (?, ?, ?, 'active', ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                stmt.setString(1, this.clubName);
                stmt.setString(2, this.clubContact);
                stmt.setString(3, this.clubDesc);
                stmt.setString(4, this.clubEstablishedDate);
                stmt.setString(5, this.clubPassword);
                stmt.setString(6, this.profilePic);
                stmt.setBytes(7, this.profilePicBlob);
                int affectedRows = stmt.executeUpdate();
                if (affectedRows > 0) {
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            generatedId = generatedKeys.getInt(1);
                            this.clubID = generatedId;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // Update existing club
    public boolean update() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                StringBuilder query = new StringBuilder("UPDATE club SET clubName=?, clubContact=?, clubDesc=?, clubStatus=?, clubEstablishedDate=?, clubPassword=?");
                if (this.profilePic != null && this.profilePicBlob != null) {
                    query.append(", profilePic=?, profilePicBlob=?");
                }
                query.append(" WHERE clubID=?");
                PreparedStatement stmt = conn.prepareStatement(query.toString());
                stmt.setString(1, this.clubName);
                stmt.setString(2, this.clubContact);
                stmt.setString(3, this.clubDesc);
                stmt.setString(4, this.clubStatus);
                stmt.setString(5, this.clubEstablishedDate);
                stmt.setString(6, this.clubPassword);
                int paramIndex = 7;
                if (this.profilePic != null && this.profilePicBlob != null) {
                    stmt.setString(paramIndex++, this.profilePic);
                    stmt.setBytes(paramIndex++, this.profilePicBlob);
                }
                stmt.setInt(paramIndex, this.clubID);
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete club
    public static boolean delete(int clubID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "DELETE FROM club WHERE clubID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, clubID);
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get active clubs
    public static List<CLUB> getActiveClubs() {
        List<CLUB> clubs = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM club WHERE clubStatus = 'active'";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    CLUB club = new CLUB();
                    club.setClubId(rs.getInt("clubID"));
                    club.setClubName(rs.getString("clubName"));
                    club.setClubContact(rs.getString("clubContact"));
                    club.setClubDesc(rs.getString("clubDesc"));
                    club.setClubStatus(rs.getString("clubStatus"));
                    club.setClubEstablishedDate(rs.getString("clubEstablishedDate"));
                    club.setClubPassword(rs.getString("clubPassword"));
                    clubs.add(club);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clubs;
    }

    // Club authentication method
    public static CLUB authenticateClub(int clubID, String password) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM club WHERE clubID = ? AND clubPassword = ? AND clubStatus = 'active'";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, clubID);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    CLUB club = new CLUB();
                    club.setClubId(rs.getInt("clubID"));
                    club.setClubName(rs.getString("clubName"));
                    club.setClubContact(rs.getString("clubContact"));
                    club.setClubDesc(rs.getString("clubDesc"));
                    club.setClubStatus(rs.getString("clubStatus"));
                    club.setClubEstablishedDate(rs.getString("clubEstablishedDate"));
                    club.setClubPassword(rs.getString("clubPassword"));
                    return club;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get clubs by student ID
    public static List<CLUB> getClubsByStudentId(int studID) {
        List<CLUB> clubs = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT c.* FROM club c " +
                             "INNER JOIN student_club sc ON c.clubID = sc.clubID " +
                             "WHERE sc.studID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, studID);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    CLUB club = new CLUB();
                    club.setClubId(rs.getInt("clubID"));
                    club.setClubName(rs.getString("clubName"));
                    club.setClubContact(rs.getString("clubContact"));
                    club.setClubDesc(rs.getString("clubDesc"));
                    club.setClubStatus(rs.getString("clubStatus"));
                    club.setClubEstablishedDate(rs.getString("clubEstablishedDate"));
                    clubs.add(club);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clubs;
    }

    // Check if student is already a member of any club
    public static boolean isStudentInAnyClub(int studID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT COUNT(*) FROM student_club WHERE studID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, studID);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Add student to club with one-club restriction
    public static String addStudentToClub(int studID, int clubID) {
        try {
            // First check if student is already in any club
            if (isStudentInAnyClub(studID)) {
                return "Student is already a member of a club";
            }

            // Check if club exists and is active
            CLUB club = getClubById(clubID);
            if (club == null) {
                return "Club does not exist";
            }
            if (!"active".equalsIgnoreCase(club.getClubStatus())) {
                return "Club is not active";
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "INSERT INTO student_club (studID, clubID) VALUES (?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, studID);
                stmt.setInt(2, clubID);
                
                int result = stmt.executeUpdate();
                if (result > 0) {
                    return "success";
                } else {
                    return "Failed to add student to club";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }

    // Remove student from club
    public static boolean removeStudentFromClub(int studID, int clubID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "DELETE FROM student_club WHERE studID = ? AND clubID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, studID);
                stmt.setInt(2, clubID);
                
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void setClubId(int clubID) {
        this.clubID = clubID;
    }

    public int getClubId() {
        return clubID;
    }
    
    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getClubName() {
        return clubName;
    }
    
    public void setClubContact(String clubContact) {
        this.clubContact = clubContact;
    }

    public String getClubContact() {
        return clubContact;
    }
    
    public void setClubDesc(String clubDesc) {
        this.clubDesc = clubDesc;
    }

    public String getClubDesc() {
        return clubDesc;
    }
    
    public void setClubStatus(String clubStatus) {
        this.clubStatus = clubStatus;
    }

    public String getClubStatus() {
        return clubStatus;
    }
    
    public void setClubEstablishedDate(String clubEstablishedDate) {
        this.clubEstablishedDate = clubEstablishedDate;
    }

    public String getClubEstablishedDate() {
        return clubEstablishedDate;
    }
    
    public void setClubPassword(String clubPassword) {
        this.clubPassword = clubPassword;
    }

    public String getClubPassword() {
        return clubPassword;
    }
    
    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    public byte[] getProfilePicBlob() {
        return profilePicBlob;
    }

    public void setProfilePicBlob(byte[] profilePicBlob) {
        this.profilePicBlob = profilePicBlob;
    }
}
