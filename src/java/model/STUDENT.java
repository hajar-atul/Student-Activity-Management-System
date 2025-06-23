package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    // Database connection
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
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

                // Null-safe fallback for fields that might be empty
                student.setDob(rs.getString("dob") != null ? rs.getString("dob") : "N/A");
                student.setMuetStatus(rs.getString("muetStatus") != null ? rs.getString("muetStatus") : "N/A");
                student.setAdvisor(rs.getString("advisor") != null ? rs.getString("advisor") : "N/A");

                // Optional adabPoint
                try {
                    student.setAdabPoint(rs.getInt("adabPoint"));
                } catch (SQLException e) {
                    student.setAdabPoint(0);
                }

                return student;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

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

    public static String registerStudent(STUDENT student, String confirmPassword) {
        try {
            if (!student.getStudPassword().equals(confirmPassword)) {
                return "Password and Confirm Password do not match";
            }

            String query = "INSERT INTO student (studID, studName, studEmail, studCourse, studSemester, " +
                    "studNoPhone, studType, studPassword, dob, muetStatus, advisor) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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

                int rows = pstmt.executeUpdate();
                return rows > 0 ? "success" : "Registration failed. Please try again";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error during registration: Please try again later";
        }
    }

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

    public static List<String> getAllCourses() {
        List<String> courses = new ArrayList<>();
        try {
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

    public static boolean updatePassword(int studID, String newPassword) {
        String query = "UPDATE student SET studPassword = ? WHERE studID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, newPassword);
            pstmt.setInt(2, studID);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

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

    public static boolean updateStudentFromSettings(int studID, String studName, String studEmail,
                                                    String studNoPhone, String studCourse, String studSemester,
                                                    String dob, String muetStatus, String advisor) {
        String sql = "UPDATE student SET studName = ?, studEmail = ?, studNoPhone = ?, " +
                "studCourse = ?, studSemester = ?, dob = ?, muetStatus = ?, advisor = ? WHERE studID = ?";
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

    // Adab Point Automation
    public static int getAdabPointByStudentId(int studID) {
        String query = "SELECT adab_point FROM adab_point WHERE studId = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, studID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("adab_point");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Default if not found
    }
    
    //event countdown automation
    public static int getDaysUntilNextActivity(int studID) {
    String query = "SELECT DATEDIFF(activity.activityDate, CURDATE()) AS days_left " +
                   "FROM activity_registration " +
                   "JOIN activity ON activity_registration.activityID = activity.activityID " +
                   "WHERE activity_registration.studID = ? AND activity.activityDate >= CURDATE() " +
                   "ORDER BY activity.activityDate ASC LIMIT 1";

    try (Connection conn = getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        pstmt.setInt(1, studID);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return rs.getInt("days_left");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1; // return -1 if no upcoming event is found
}


    // ------------------- Getters and Setters -------------------
    public int getStudID() { return studID; }
    public void setStudID(int studID) { this.studID = studID; }

    public String getStudName() { return studName; }
    public void setStudName(String studName) { this.studName = studName; }

    public String getStudEmail() { return studEmail; }
    public void setStudEmail(String studEmail) { this.studEmail = studEmail; }

    public String getStudCourse() { return studCourse; }
    public void setStudCourse(String studCourse) { this.studCourse = studCourse; }

    public String getStudSemester() { return studSemester; }
    public void setStudSemester(String studSemester) { this.studSemester = studSemester; }

    public String getStudNoPhone() { return studNoPhone; }
    public void setStudNoPhone(String studNoPhone) { this.studNoPhone = studNoPhone; }

    public String getStudType() { return studType; }
    public void setStudType(String studType) { this.studType = studType; }

    public String getStudPassword() { return studPassword; }
    public void setStudPassword(String studPassword) { this.studPassword = studPassword; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getMuetStatus() { return muetStatus; }
    public void setMuetStatus(String muetStatus) { this.muetStatus = muetStatus; }

    public String getAdvisor() { return advisor; }
    public void setAdvisor(String advisor) { this.advisor = advisor; }

    public int getAdabPoint() { return adabPoint; }
    public void setAdabPoint(int adabPoint) { this.adabPoint = adabPoint; }

    @Override
    public String toString() {
        return "STUDENT{" +
                "studID=" + studID +
                ", studName='" + studName + '\'' +
                ", studEmail='" + studEmail + '\'' +
                ", studCourse='" + studCourse + '\'' +
                ", studSemester='" + studSemester + '\'' +
                ", studNoPhone='" + studNoPhone + '\'' +
                ", dob='" + dob + '\'' +
                ", muetStatus='" + muetStatus + '\'' +
                ", advisor='" + advisor + '\'' +
                ", adabPoint=" + adabPoint +
                '}';
    }
}
