package model;

import java.sql.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author User
 */
public class STUDENT {
    private int studID;
    private String studName;
    private String studEmail;
    private String studCourse;
    private String studSemester;
    private String studNoPhone;
    private String studType;
    private String studPassword;
    private String dob;
    private String muetStatus;
    private String advisor;

    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Get student by ID
    public static STUDENT getStudentById(int studID) {
        STUDENT student = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM student WHERE studID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, studID);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    student = new STUDENT();
                    student.setStudId(rs.getInt("studID"));
                    student.setStudName(rs.getString("studName"));
                    student.setStudEmail(rs.getString("studEmail"));
                    student.setStudCourse(rs.getString("studCourse"));
                    student.setStudSemester(rs.getString("studSemester"));
                    student.setStudNoPhone(rs.getString("studNoPhone"));
                    student.setStudType(rs.getString("studType"));
                    student.setStudPassword(rs.getString("studPassword"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return student;
    }

    // Password validation method
    public static boolean validatePassword(int studID, String enteredPassword) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT studPassword FROM student WHERE studID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, studID);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String storedPassword = rs.getString("studPassword");
                    return storedPassword.equals(enteredPassword);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Registration method
    public static String registerStudent(STUDENT student, String confirmPassword) {
        try {
            // Password match check
            if (!student.getStudPassword().equals(confirmPassword)) {
                return "Password and Confirm Password do not match";
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                // Check if email or ID already exists
                String checkQuery = "SELECT * FROM student WHERE studEmail = ? OR studID = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                checkStmt.setString(1, student.getStudEmail());
                checkStmt.setInt(2, student.getStudId());
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    if (rs.getString("studEmail").equals(student.getStudEmail())) {
                        return "Email already registered";
                    } else {
                        return "Student ID already registered";
                    }
                }

                // Insert new student record
                String insertQuery = "INSERT INTO student (studID, studName, studEmail, studCourse, studSemester, " +
                                   "studNoPhone, studType, studPassword, dob, muetStatus, advisor) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setInt(1, student.getStudId());
                insertStmt.setString(2, student.getStudName());
                insertStmt.setString(3, student.getStudEmail());
                insertStmt.setString(4, student.getStudCourse());
                insertStmt.setString(5, student.getStudSemester());
                insertStmt.setString(6, student.getStudNoPhone());
                insertStmt.setString(7, student.getStudType());
                insertStmt.setString(8, student.getStudPassword());
                insertStmt.setString(9, student.getDob());
                insertStmt.setString(10, student.getMuetStatus());
                insertStmt.setString(11, student.getAdvisor());
                
                int rows = insertStmt.executeUpdate();

                if (rows > 0) {
                    return "success";
                } else {
                    return "Registration failed. Please try again";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error during registration: Please try again later";
        }
    }

    // Check if student ID exists
    public static boolean studentExists(int studID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT COUNT(*) FROM student WHERE studID = ?";
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

    // Setter and Getter for studId
    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }

    // Setter and Getter for studName
    public void setStudName(String studName) {
        this.studName = studName;
    }

    public String getStudName() {
        return studName;
    }

    // Setter and Getter for studEmail
    public void setStudEmail(String studEmail) {
        this.studEmail = studEmail;
    }

    public String getStudEmail() {
        return studEmail;
    }

    // Setter and Getter for studProgram
    public void setStudCourse(String studCourse) {
        this.studCourse = studCourse;
    }

    public String getStudCourse() {
        return studCourse;
    }

    // Setter and Getter for studSemester
    public void setStudSemester(String studSemester) {
        this.studSemester = studSemester;
    }

    public String getStudSemester() {
        return studSemester;
    }

    // Setter and Getter for studNoPhone
    public void setStudNoPhone(String studNoPhone) {
        this.studNoPhone = studNoPhone;
    }

    public String getStudNoPhone() {
        return studNoPhone;
    }

    // Setter and Getter for studType
    public void setStudType(String studType) {
        this.studType = studType;
    }

    public String getStudType() {
        return studType;
    }

    // Setter and Getter for studPassword
    public void setStudPassword(String studPassword) {
        this.studPassword = studPassword;
    }

    public String getStudPassword() {
        return studPassword;
    }

    // Additional getters and setters for new fields
    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getMuetStatus() {
        return muetStatus;
    }

    public void setMuetStatus(String muetStatus) {
        this.muetStatus = muetStatus;
    }

    public String getAdvisor() {
        return advisor;
    }

    public void setAdvisor(String advisor) {
        this.advisor = advisor;
    }
}

