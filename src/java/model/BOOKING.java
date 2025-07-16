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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author User
 */
public class BOOKING {
    private int bookingID;
    private String bookingType;
    private String itemName;
    private String itemDetails;
    private String bookingDate;
    private String status;
    private int clubID;
    private String activityID;

    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Load JDBC driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Get database connection
    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    // Getters and Setters
    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }
    public String getBookingType() { return bookingType; }
    public void setBookingType(String bookingType) { this.bookingType = bookingType; }
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public String getItemDetails() { return itemDetails; }
    public void setItemDetails(String itemDetails) { this.itemDetails = itemDetails; }
    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public int getClubID() { return clubID; }
    public void setClubID(int clubID) { this.clubID = clubID; }
    public String getActivityID() { return activityID; }
    public void setActivityID(String activityID) { this.activityID = activityID; }

    // Fetch all bookings
    public static List<BOOKING> getAllBookings() {
        List<BOOKING> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking ORDER BY bookingDate DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                BOOKING booking = new BOOKING();
                booking.setBookingID(rs.getInt("bookingID"));
                booking.setBookingType(rs.getString("bookingType"));
                booking.setItemName(rs.getString("itemName"));
                booking.setItemDetails(rs.getString("itemDetails"));
                booking.setBookingDate(rs.getString("bookingDate"));
                booking.setStatus(rs.getString("status"));
                try { booking.setClubID(rs.getInt("clubID")); } catch(Exception e) { booking.setClubID(0); }
                try { booking.setActivityID(rs.getString("activityID")); } catch(Exception e) { booking.setActivityID(null); }
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    // Fetch bookings by type
    public static List<BOOKING> getBookingsByType(String bookingType) {
        List<BOOKING> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking WHERE bookingType = ? ORDER BY bookingDate DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, bookingType);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    BOOKING booking = new BOOKING();
                    booking.setBookingID(rs.getInt("bookingID"));
                    booking.setBookingType(rs.getString("bookingType"));
                    booking.setItemName(rs.getString("itemName"));
                    booking.setItemDetails(rs.getString("itemDetails"));
                    booking.setBookingDate(rs.getString("bookingDate"));
                    booking.setStatus(rs.getString("status"));
                    try { booking.setClubID(rs.getInt("clubID")); } catch(Exception e) { booking.setClubID(0); }
                    try { booking.setActivityID(rs.getString("activityID")); } catch(Exception e) { booking.setActivityID(null); }
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Update booking status
    public static void updateBookingStatus(int bookingId, String newStatus) throws SQLException {
        String query = "UPDATE booking SET status = ? WHERE bookingID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, bookingId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Update failed, no rows affected. Booking ID not found: " + bookingId);
            }
        }
    }

    // Add new booking
    public static boolean addBooking(String bookingType, String itemName, String itemDetails, String bookingDate, int clubID, String activityID) {
        String query = "INSERT INTO booking (bookingType, itemName, itemDetails, bookingDate, status, clubID, activityID) VALUES (?, ?, ?, ?, 'Pending', ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, bookingType);
            pstmt.setString(2, itemName);
            pstmt.setString(3, itemDetails);
            pstmt.setString(4, bookingDate);
            pstmt.setInt(5, clubID);
            pstmt.setString(6, activityID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get booking count by status
    public static int getBookingCountByStatus(String status) {
        String query = "SELECT COUNT(*) FROM booking WHERE TRIM(status) = ?";
        int count = 0;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}