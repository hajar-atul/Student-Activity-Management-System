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
    private int activityID;
    private String regDate;
    
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
    
    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public int getActivityID() {
        return activityID;
    }
    
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getRegDate() {
        return regDate;
    }
    
    public static int getStudentCountForActivity(String activityID) {
        int count = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT COUNT(*) FROM registeration WHERE activityID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, activityID);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public static List<STUDENT> getStudentsByActivityId(String activityID) {
        List<STUDENT> students = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT s.* FROM student s JOIN registeration r ON s.studID = r.studID WHERE r.activityID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, activityID);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    STUDENT student = new STUDENT();
                    student.setStudID(rs.getInt("studID"));
                    student.setStudName(rs.getString("studName"));
                    student.setStudEmail(rs.getString("studEmail"));
                    student.setStudCourse(rs.getString("studCourse"));
                    student.setStudSemester(rs.getString("studSemester"));
                    student.setStudNoPhone(rs.getString("studNoPhone"));
                    students.add(student);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return students;
    }

    public static boolean registerStudentForActivity(int studID,String activityID) {
        String sql = "INSERT INTO registeration (studID, activityID, regDate) VALUES (?, ?, CURDATE())";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, studID);
            pstmt.setString(2, activityID);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
