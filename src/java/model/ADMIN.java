/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.*;

/**
 *
 * @author User
 */
public class ADMIN {
    private int studID;
    private String adminEmail;
    private STUDENT studentInfo;

    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Add a student as admin (MPP)
    public static boolean addAdmin(int studID, String adminEmail) {
        String sql = "INSERT INTO admin (studID, adminEmail) VALUES (?, ?)";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, studID);
            pstmt.setString(2, adminEmail);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if a student is an admin
    public static boolean isAdmin(int studID) {
        String sql = "SELECT* FROM admin WHERE studID = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, studID);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get admin info (with student info) by studID
    public static ADMIN getAdminByStudID(int studID) {
        String sql = "SELECT a.adminEmail, s.* FROM admin a JOIN student s ON a.studID = s.studID WHERE a.studID = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, studID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                ADMIN admin = new ADMIN();
                admin.setStudId(studID);
                admin.setAdminEmail(rs.getString("adminEmail"));
                STUDENT student = new STUDENT();
                student.setStudID(rs.getInt("studID"));
                student.setStudName(rs.getString("studName"));
                student.setStudEmail(rs.getString("studEmail"));
                student.setStudCourse(rs.getString("studCourse"));
                student.setStudSemester(rs.getString("studSemester"));
                student.setStudNoPhone(rs.getString("studNoPhone"));
                student.setStudType(rs.getString("studType"));
                student.setStudPassword(rs.getString("studPassword"));
                student.setDob(rs.getString("dob"));
                student.setMuetStatus(rs.getString("muetStatus"));
                student.setAdvisor(rs.getString("advisor"));
                admin.setStudentInfo(student);
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Check if the student meets the minimum semester requirement (semester 2-4)
    public static boolean minSemRequired(int studID) {
        String sql = "SELECT studSemester FROM student WHERE studID = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, studID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String semStr = rs.getString("studSemester");
                // Try to parse the semester as an integer
                try {
                    int sem = Integer.parseInt(semStr.replaceAll("[^0-9]", ""));
                    return sem >= 2 && sem <= 4;
                } catch (NumberFormatException e) {
                    // If parsing fails, treat as not eligible
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }
    
    public void setAdminEmail(String adminEmail) {
        this.adminEmail = adminEmail;
    }

    public String getAdminEmail() {
        return adminEmail;
    }

    public STUDENT getStudentInfo() {
        return studentInfo;
    }

    public void setStudentInfo(STUDENT studentInfo) {
        this.studentInfo = studentInfo;
    }
}
