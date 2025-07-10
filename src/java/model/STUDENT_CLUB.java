package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class STUDENT_CLUB {
    private int studID;
    private int clubID;
    private Date joinDate;
    
    // Constructor
    public STUDENT_CLUB() {
    }

    public STUDENT_CLUB(int studID, int clubID) {
        this.studID = studID;
        this.clubID = clubID;
    }

    // Get student's club membership
    public static STUDENT_CLUB getStudentClub(int studID) {
        try (
            java.sql.Connection conn = DBConnection.getConnection()
        ) {
            String query = "SELECT * FROM student_club WHERE studID = ?";
            java.sql.PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, studID);
            java.sql.ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                STUDENT_CLUB studentClub = new STUDENT_CLUB();
                studentClub.setStudID(rs.getInt("studID"));
                studentClub.setClubID(rs.getInt("clubID"));
                studentClub.setJoinDate(rs.getDate("joinDate"));
                return studentClub;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Add student to club
    public static String addStudentToClub(int studID, int clubID) {
        try {
            // First check if student is already in any club
            if (isStudentInAnyClub(studID)) {
                return "Student is already a member of a club";
            }

            // Check if club exists and is active
            CLUB club = CLUB.getClubById(clubID);
            if (club == null) {
                return "Club does not exist";
            }
            if (!"active".equalsIgnoreCase(club.getClubStatus())) {
                return "Club is not active";
            }

            try (java.sql.Connection conn = DBConnection.getConnection()) {
                String query = "INSERT INTO student_club (studID, clubID, joinDate) VALUES (?, ?, CURDATE())";
                java.sql.PreparedStatement stmt = conn.prepareStatement(query);
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
        try (
            java.sql.Connection conn = DBConnection.getConnection()
        ) {
            String query = "DELETE FROM student_club WHERE studID = ? AND clubID = ?";
            java.sql.PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, studID);
            stmt.setInt(2, clubID);
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if student is in any club
    public static boolean isStudentInAnyClub(int studID) {
        try (
            java.sql.Connection conn = DBConnection.getConnection()
        ) {
            String query = "SELECT COUNT(*) FROM student_club WHERE studID = ?";
            java.sql.PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, studID);
            java.sql.ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all students in a club
    public static java.util.List<STUDENT> getStudentsInClub(int clubID) {
        java.util.List<STUDENT> students = new java.util.ArrayList<>();
        try (
            java.sql.Connection conn = DBConnection.getConnection()
        ) {
            String query = "SELECT s.* FROM student s " +
                         "INNER JOIN student_club sc ON s.studID = sc.studID " +
                         "WHERE sc.clubID = ?";
            java.sql.PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, clubID);
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
                students.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return students;
    }

    // Getters and Setters
    public int getStudID() {
        return studID;
    }

    public void setStudID(int studID) {
        this.studID = studID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }
} 