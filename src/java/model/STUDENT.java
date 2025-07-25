package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

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
    private int adabPoint;
    private String profilePic;
    private byte[] profilePicBlob;

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
        return DBConnection.getConnection();
    }

    // Get student by ID
    public static STUDENT getStudentById(int studId) {
        String query = "SELECT * FROM student WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, studId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
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
                
                // Try to get adabPoint, but don't fail if column doesn't exist
                try {
                    student.setAdabPoint(rs.getInt("adabPoint"));
                } catch (SQLException e) {
                    // If adabPoint column doesn't exist, set default value
                    student.setAdabPoint(0);
                }
                
                try {
                    student.setProfilePic(rs.getString("profilePic"));
                } catch (SQLException e) {
                    student.setProfilePic(null);
                }
                
                try {
                    student.setProfilePicBlob(rs.getBytes("profilePicBlob"));
                } catch (SQLException e) {
                    student.setProfilePicBlob(null);
                }
                
                return student;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Password validation method
    public static boolean validatePassword(int studId, String password) {
        String query = "SELECT studPassword FROM student WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, studId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("studPassword");
                return storedPassword != null && storedPassword.equals(password);
            }
        } catch (SQLException e) {
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

            String query = "INSERT INTO student (studID, studName, studEmail, studCourse, studSemester, studNoPhone, studType, studPassword, dob, muetStatus, advisor, adabPoint, profilePicBlob) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            try (Connection conn = getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, student.getStudID());
                pstmt.setString(2, student.getStudName());
                pstmt.setString(3, student.getStudEmail());
                pstmt.setString(4, student.getStudCourse());
                pstmt.setString(5, student.getStudSemester());
                pstmt.setString(6, student.getStudNoPhone());
                pstmt.setString(7, student.getStudType());
                pstmt.setString(8, student.getStudPassword());
                pstmt.setString(9, student.getDob());
                pstmt.setString(10, student.getMuetStatus());
                pstmt.setString(11, student.getAdvisor());
                pstmt.setInt(12, student.getAdabPoint());
                pstmt.setBytes(13, student.getProfilePicBlob());
                int rows = pstmt.executeUpdate();

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
    public static boolean studentExists(int studId) {
        String query = "SELECT COUNT(*) FROM student WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, studId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get total number of students
    public static int getTotalStudents() {
        String query = "SELECT COUNT(*) FROM student";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get all unique courses
    public static List<String> getAllCourses() {
        List<String> courses = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT DISTINCT studCourse FROM student WHERE studCourse IS NOT NULL AND studCourse != '' ORDER BY studCourse";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    courses.add(rs.getString("studCourse"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return courses;
    }

    // Setter and Getter for studId
    public void setStudID(int studID) {
        this.studID = studID;
    }

    public int getStudID() {
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

    public void setAdabPoint(int adabPoint) {
        this.adabPoint = adabPoint;
    }

    public int getAdabPoint() {
        return adabPoint;
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

    // Update password
    public static boolean updatePassword(int studID, String newPassword) {
        String query = "UPDATE student SET studPassword = ? WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, studID);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update email and type for a student
    public static boolean updateEmailAndType(int studID, String newEmail, String newType) {
        String sql = "UPDATE student SET studEmail = ?, studType = ? WHERE studID = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newEmail);
            pstmt.setString(2, newType);
            pstmt.setInt(3, studID);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update student information from settings page
    public static boolean updateStudentFromSettings(int studID, String studName, String studEmail, 
            String studNoPhone, String studCourse, String studSemester, String dob, 
            String muetStatus, String advisor) {
        String sql = "UPDATE student SET studName = ?, studEmail = ?, studNoPhone = ?, " +
                    "studCourse = ?, studSemester = ?, dob = ?, muetStatus = ?, " +
                    "advisor = ? WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studName);
            pstmt.setString(2, studEmail);
            pstmt.setString(3, studNoPhone);
            pstmt.setString(4, studCourse);
            pstmt.setString(5, studSemester);
            pstmt.setString(6, dob);
            pstmt.setString(7, muetStatus);
            pstmt.setString(8, advisor);
            pstmt.setInt(9, studID);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update student information including profile picture
    public static boolean updateStudentWithProfilePicture(int studID, String studName, String studEmail, 
            String studNoPhone, String studCourse, String studSemester, String dob, 
            String muetStatus, String advisor, byte[] profilePicBlob) {
        String sql = "UPDATE student SET studName = ?, studEmail = ?, studNoPhone = ?, " +
                    "studCourse = ?, studSemester = ?, dob = ?, muetStatus = ?, " +
                    "advisor = ?, profilePicBlob = ? WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studName);
            pstmt.setString(2, studEmail);
            pstmt.setString(3, studNoPhone);
            pstmt.setString(4, studCourse);
            pstmt.setString(5, studSemester);
            pstmt.setString(6, dob);
            pstmt.setString(7, muetStatus);
            pstmt.setString(8, advisor);
            pstmt.setBytes(9, profilePicBlob);
            pstmt.setInt(10, studID);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get adabPoint by student ID
    public static int getAdabPointByStudentId(int studID) {
        String query = "SELECT adabPoint FROM student WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("adabPoint");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Increment adabPoint for a student
    public static void incrementAdabPoint(int studID, int adabPoint) {
        String query = "UPDATE student SET adabPoint = adabPoint + ? WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, adabPoint);
            pstmt.setInt(2, studID);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get days until next registered activity for a student
    public static int getDaysUntilNextActivity(int studID) {
        String query = "SELECT MIN(DATEDIFF(a.activityDate, CURDATE())) AS daysUntil " +
                       "FROM activity a " +
                       "JOIN registration r ON a.activityID = r.activityID " +
                       "WHERE r.studID = ? AND a.activityDate >= CURDATE()";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, studID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int days = rs.getInt("daysUntil");
                if (!rs.wasNull()) {
                    return days;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // No upcoming events
    }

    public static List<STUDENT> getAllStudents() {
        List<STUDENT> students = new ArrayList<>();
        String query = "SELECT * FROM student";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
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
                try { student.setAdabPoint(rs.getInt("adabPoint")); } catch (Exception e) { student.setAdabPoint(0); }
                try { student.setProfilePic(rs.getString("profilePic")); } catch (Exception e) { student.setProfilePic(null); }
                try { student.setProfilePicBlob(rs.getBytes("profilePicBlob")); } catch (Exception e) { student.setProfilePicBlob(null); }
                students.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return students;
    }

    public static List<STUDENT> getAllForAdabPoint() {
        List<STUDENT> students = new ArrayList<>();
        String query = "SELECT studID, studName, adabPoint FROM student";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                STUDENT student = new STUDENT();
                student.setStudID(rs.getInt("studID"));
                student.setStudName(rs.getString("studName"));
                student.setAdabPoint(rs.getInt("adabPoint"));
                students.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return students;
    }
}

