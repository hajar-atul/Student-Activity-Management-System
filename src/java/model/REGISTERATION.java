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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author User
 */
public class REGISTERATION {
    private int studID;
    private String activityID;
    private String regDate;
    private byte[] receiptFile;
    
    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public void setStudID(int studID) {
        this.studID = studID;
    }

    public int getStudID() {
        return studID;
    }
    
    public void setActivityID(String activityID) {
        this.activityID = activityID;
    }

    public String getActivityID() {
        return activityID;
    }
    
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getRegDate() {
        return regDate;
    }
    
    public void setReceiptFile(byte[] receiptFile) {
        this.receiptFile = receiptFile;
    }

    public byte[] getReceiptFile() {
        return receiptFile;
    }

    // Register student for free activity
    public static boolean registerStudentForActivity(int studID, String activityID) {
        String query = "INSERT INTO registration (studID, activityID, regDate) VALUES (?, ?, CURDATE())";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            pstmt.setString(2, activityID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Register student for paid activity with receipt
    public static boolean registerStudentForPaidActivity(int studID, String activityID, byte[] receiptFile) {
        String query = "INSERT INTO registration (studID, activityID, regDate, receiptFile) VALUES (?, ?, CURDATE(), ?)";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            pstmt.setString(2, activityID);
            pstmt.setBytes(3, receiptFile);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if student is already registered for an activity
    public static boolean isStudentRegistered(int studID, String activityID) {
        String query = "SELECT COUNT(*) FROM registration WHERE studID = ? AND activityID = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            pstmt.setString(2, activityID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get registration by ID
    public static REGISTERATION getRegistrationById(int regID) {
        String query = "SELECT * FROM registration WHERE regID = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, regID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                REGISTERATION registration = new REGISTERATION();
                registration.setStudID(rs.getInt("studID"));
                registration.setActivityID(rs.getString("activityID"));
                registration.setRegDate(rs.getString("regDate"));
                registration.setReceiptFile(rs.getBytes("receiptFile"));
                return registration;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Get all registrations for a student
    public static List<REGISTERATION> getRegistrationsByStudentId(int studID) {
        List<REGISTERATION> registrations = new ArrayList<>();
        String query = "SELECT * FROM registration WHERE studID = ? ORDER BY regDate DESC";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                REGISTERATION registration = new REGISTERATION();
                registration.setStudID(rs.getInt("studID"));
                registration.setActivityID(rs.getString("activityID"));
                registration.setRegDate(rs.getString("regDate"));
                registration.setReceiptFile(rs.getBytes("receiptFile"));
                registrations.add(registration);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return registrations;
    }
    
    // Get all registrations for an activity
    public static List<REGISTERATION> getRegistrationsByActivityId(String activityID) {
        List<REGISTERATION> registrations = new ArrayList<>();
        String query = "SELECT * FROM registration WHERE activityID = ? ORDER BY regDate DESC";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, activityID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                REGISTERATION registration = new REGISTERATION();
                registration.setStudID(rs.getInt("studID"));
                registration.setActivityID(rs.getString("activityID"));
                registration.setRegDate(rs.getString("regDate"));
                registration.setReceiptFile(rs.getBytes("receiptFile"));
                registrations.add(registration);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return registrations;
    }
}
