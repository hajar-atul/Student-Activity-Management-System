package Controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegisterPageServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?zeroDateTimeBehavior=convertToNull";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Get all form parameters
        String studID = request.getParameter("studID");
        String studName = request.getParameter("studName");
        String studEmail = request.getParameter("studEmail");
        String studPassword = request.getParameter("studPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String studCourse = request.getParameter("studCourse");
        String studSemester = request.getParameter("studSemester");
        String studNoPhone = request.getParameter("studNoPhone");
        String studType = request.getParameter("studType");
        String dob = request.getParameter("dob");
        String muetStatus = request.getParameter("muetStatus");
        String advisor = request.getParameter("advisor");

        // Password match check
        if (!studPassword.equals(confirmPassword)) {
            response.sendRedirect("registerResult.jsp?status=error&message=Password+and+Confirm+Password+do+not+match");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {

                // Check if email already exists
                String checkQuery = "SELECT * FROM student WHERE studEmail = ? OR studID = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                checkStmt.setString(1, studEmail);
                checkStmt.setString(2, studID);
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    String errorMessage;
                    if (rs.getString("studEmail").equals(studEmail)) {
                        errorMessage = "Email+already+registered";
                    } else {
                        errorMessage = "Student+ID+already+registered";
                    }
                    response.sendRedirect("registerResult.jsp?status=error&message=" + errorMessage);
                    return;
                }

                // Insert new student record with all fields
                String insertQuery = "INSERT INTO student (studID, studName, studEmail, studCourse, studSemester, " +
                                   "studNoPhone, studType, studPassword, dob, muetStatus, advisor) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, studID);
                insertStmt.setString(2, studName);
                insertStmt.setString(3, studEmail);
                insertStmt.setString(4, studCourse);
                insertStmt.setString(5, studSemester);
                insertStmt.setString(6, studNoPhone);
                insertStmt.setString(7, studType);
                insertStmt.setString(8, studPassword);
                insertStmt.setString(9, dob);
                insertStmt.setString(10, muetStatus);
                insertStmt.setString(11, advisor);
                
                int rows = insertStmt.executeUpdate();

                if (rows > 0) {
                    // Registration successful
                    response.sendRedirect("registerResult.jsp?status=success&message=Registration+successful!+You+can+now+login+with+your+credentials");
                } else {
                    response.sendRedirect("registerResult.jsp?status=error&message=Registration+failed.+Please+try+again");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registerResult.jsp?status=error&message=Error+during+registration:+Please+try+again+later");
        }
    }
}
