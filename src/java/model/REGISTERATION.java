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
import util.DBConnection;

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
    // Remove JDBC_URL, DB_USER, DB_PASSWORD

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
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
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
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
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
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            pstmt.setString(2, activityID);
            java.sql.ResultSet rs = pstmt.executeQuery();
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
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, regID);
            java.sql.ResultSet rs = pstmt.executeQuery();
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
    public static java.util.List<REGISTERATION> getRegistrationsByStudentID(int studID) {
        java.util.List<REGISTERATION> registrations = new java.util.ArrayList<>();
        String query = "SELECT * FROM registration WHERE studID = ? ORDER BY regDate DESC";
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            java.sql.ResultSet rs = pstmt.executeQuery();
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
    public static java.util.List<REGISTERATION> getRegistrationsByActivityId(String activityID) {
        System.out.println("DEBUG: ENTERED getRegistrationsByActivityId with activityID=" + activityID);
        // Print all rows in the registration table from within the method
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.Statement stmt = conn.createStatement();
             java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM registration")) {
            while (rs.next()) {
                System.out.println("DEBUG: ALL ROWS IN METHOD: studID=" + rs.getInt("studID") +
                    ", activityID=" + rs.getString("activityID") +
                    ", regDate=" + rs.getString("regDate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        java.util.List<REGISTERATION> registrations = new java.util.ArrayList<>();
        String query = "SELECT * FROM registration WHERE TRIM(activityID) = ? ORDER BY regDate DESC";
        System.out.println("DEBUG: About to execute query: " + query + " with activityID=" + activityID);
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, activityID);
            java.sql.ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                REGISTERATION registration = new REGISTERATION();
                registration.setStudID(rs.getInt("studID"));
                registration.setActivityID(rs.getString("activityID"));
                registration.setRegDate(rs.getString("regDate"));
                // registration.setReceiptFile(rs.getBytes("receiptFile")); // Column does not exist
                System.out.println("DEBUG: getRegistrationsByActivityId found studID=" + registration.getStudID() + ", activityID=" + registration.getActivityID());
                registrations.add(registration);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return registrations;
    }

    public static int getStudentCountForActivity(String activityID) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM registration WHERE activityID = ?";
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, activityID);
            java.sql.ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
