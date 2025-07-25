/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;

/**
 *
 * @author User
 */
public class STAFF {
    private int staffID;
    private String staffName;
    private String staffEmail;
    private String staffPhone;
    private String staffDepartment;
    private String staffPassword;
    private String profilePic;
    private byte[] profilePicBlob;
    
    // Database connection details
    // private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    // private static final String DB_USER = "root";
    // private static final String DB_PASSWORD = "";

    // Load JDBC driver
    // static {
    //     try {
    //         Class.forName("com.mysql.cj.jdbc.Driver");
    //     } catch (ClassNotFoundException e) {
    //         e.printStackTrace();
    //     }
    // }

    // Get database connection
    private static Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    // Setter and Getter for staffID
    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }
    public int getStaffID() {
        return staffID;
    }

    // Setter and Getter for staffName
    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }
    public String getStaffName() {
        return staffName;
    }

    // Setter and Getter for staffEmail
    public void setStaffEmail(String staffEmail) {
        this.staffEmail = staffEmail;
    }
    public String getStaffEmail() {
        return staffEmail;
    }

    // Setter and Getter for staffPhone
    public void setStaffPhone(String staffPhone) {
        this.staffPhone = staffPhone;
    }
    public String getStaffPhone() {
        return staffPhone;
    }

    // Setter and Getter for staffDepartment
    public void setStaffDepartment(String staffDepartment) {
        this.staffDepartment = staffDepartment;
    }
    public String getStaffDepartment() {
        return staffDepartment;
    }

    // Setter and Getter for staffPassword
    public void setStaffPassword(String staffPassword) {
        this.staffPassword = staffPassword;
    }
    public String getStaffPassword() {
        return staffPassword;
    }

    // Setter and Getter for profilePic
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

    // Get staff by ID
    public static STAFF getStaffById(int staffId) {
        String query = "SELECT * FROM staff WHERE staffID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, staffId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                STAFF staff = new STAFF();
                staff.setStaffID(rs.getInt("staffID"));
                staff.setStaffName(rs.getString("staffName"));
                staff.setStaffEmail(rs.getString("staffEmail"));
                staff.setStaffPhone(rs.getString("staffPhone"));
                staff.setStaffDepartment(rs.getString("staffDep"));
                staff.setStaffPassword(rs.getString("staffPassword"));
                try {
                    staff.setProfilePic(rs.getString("profilePic"));
                } catch (SQLException e) {
                    staff.setProfilePic(null);
                }
                try {
                    staff.setProfilePicBlob(rs.getBytes("profilePicBlob"));
                } catch (SQLException e) {
                    staff.setProfilePicBlob(null);
                }
                return staff;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Password validation method
    public static boolean validatePassword(int staffId, String password) {
        String query = "SELECT staffPassword FROM staff WHERE staffID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, staffId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("staffPassword");
                return storedPassword != null && storedPassword.equals(password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Add new staff method
    public static boolean addNewStaff(int staffID, String staffName, String staffEmail, String staffPhone, String staffDep, String staffPassword, String profilePic) {
        String query = "INSERT INTO staff (staffID, staffName, staffEmail, staffPhone, staffDep, staffPassword, profilePic) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, staffID);
            pstmt.setString(2, staffName);
            pstmt.setString(3, staffEmail);
            pstmt.setString(4, staffPhone);
            pstmt.setString(5, staffDep);
            pstmt.setString(6, staffPassword);
            pstmt.setString(7, profilePic);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Add new staff with BLOB profile picture
    public static boolean addNewStaffWithBlob(int staffID, String staffName, String staffEmail, String staffPhone, String staffDep, String staffPassword, byte[] profilePicBlob) {
        String query = "INSERT INTO staff (staffID, staffName, staffEmail, staffPhone, staffDep, staffPassword, profilePicBlob) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, staffID);
            pstmt.setString(2, staffName);
            pstmt.setString(3, staffEmail);
            pstmt.setString(4, staffPhone);
            pstmt.setString(5, staffDep);
            pstmt.setString(6, staffPassword);
            pstmt.setBytes(7, profilePicBlob);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update staff information including profile picture
    public static boolean updateStaffWithProfilePicture(int staffID, String staffName, String staffEmail, String staffPhone, String staffDep, byte[] profilePicBlob) {
        String sql = "UPDATE staff SET staffName=?, staffEmail=?, staffPhone=?, staffDep=?, profilePicBlob=? WHERE staffID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, staffName);
            pstmt.setString(2, staffEmail);
            pstmt.setString(3, staffPhone);
            pstmt.setString(4, staffDep);
            pstmt.setBytes(5, profilePicBlob);
            pstmt.setInt(6, staffID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update staff information without changing profile picture
    public static boolean updateStaffFromSettings(int staffID, String staffName, String staffEmail, String staffPhone, String staffDep) {
        String sql = "UPDATE staff SET staffName=?, staffEmail=?, staffPhone=?, staffDep=? WHERE staffID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, staffName);
            pstmt.setString(2, staffEmail);
            pstmt.setString(3, staffPhone);
            pstmt.setString(4, staffDep);
            pstmt.setInt(5, staffID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}