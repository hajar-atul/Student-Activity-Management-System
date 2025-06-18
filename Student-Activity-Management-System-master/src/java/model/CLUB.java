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
    private int studID;
    
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
                    clubs.add(club);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clubs;
    }

    // Save new club
    public boolean save() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "INSERT INTO club (clubName, clubContact, clubDesc, clubStatus, clubEstablishedDate) " +
                             "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, this.clubName);
                stmt.setString(2, this.clubContact);
                stmt.setString(3, this.clubDesc);
                stmt.setString(4, this.clubStatus);
                stmt.setString(5, this.clubEstablishedDate);
                
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update existing club
    public boolean update() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "UPDATE club SET clubName=?, clubContact=?, clubDesc=?, " +
                             "clubStatus=?, clubEstablishedDate=? WHERE clubID=?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, this.clubName);
                stmt.setString(2, this.clubContact);
                stmt.setString(3, this.clubDesc);
                stmt.setString(4, this.clubStatus);
                stmt.setString(5, this.clubEstablishedDate);
                stmt.setInt(6, this.clubID);
                
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
                String query = "SELECT * FROM club WHERE clubID = ? AND clubPassword = ?";
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
                    return club;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

    public String getClubEstablisedDate() {
        return clubEstablishedDate;
    }
     public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }
}
