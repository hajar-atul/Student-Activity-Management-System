package Controller;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class RegisterPageServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String studID = request.getParameter("studID");
        String studName = request.getParameter("studName");
        String studEmail = request.getParameter("studEmail");
        String studPassword = request.getParameter("studPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String studCourse = request.getParameter("studCourse");
        String studSemester = request.getParameter("studSemester");
        String studNoPhone = request.getParameter("studNoPhone");
        String studType = request.getParameter("studType");

        Part filePart = request.getPart("profileImage");

        // File validation
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
        if (!(fileExtension.equals("jpg") || fileExtension.equals("jpeg") || fileExtension.equals("png"))) {
            request.setAttribute("error", "Only JPG and PNG files are allowed for profile picture.");
            request.getRequestDispatcher("registerPage.jsp").forward(request, response);
            return;
        }

        // Password match check
        if (!studPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Password and Confirm Password do not match.");
            request.getRequestDispatcher("registerPage.jsp").forward(request, response);
            return;
        }

        // Save file to /uploads
        String uploadsDir = getServletContext().getRealPath("/") + "uploads";
        File uploadsFolder = new File(uploadsDir);
        if (!uploadsFolder.exists()) uploadsFolder.mkdir();
        String savedFilePath = uploadsDir + File.separator + fileName;
        filePart.write(savedFilePath);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {

                String checkQuery = "SELECT * FROM student WHERE studEmail = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                checkStmt.setString(1, studEmail);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("error", "Email already registered.");
                    request.getRequestDispatcher("registerPage.jsp").forward(request, response);
                    return;
                }

                String insertQuery = "INSERT INTO student (studID, studName, studEmail, studCourse, studSemester, studNoPhone, studType, studPassword) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, studID);
                insertStmt.setString(2, studName);
                insertStmt.setString(3, studEmail);
                insertStmt.setString(4, studCourse);
                insertStmt.setString(5, studSemester);
                insertStmt.setString(6, studNoPhone);
                insertStmt.setString(7, studType);
                insertStmt.setString(8, studPassword);
                int rows = insertStmt.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("index.jsp?message=Registration+successful");
                } else {
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("registerPage.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("registerPage.jsp").forward(request, response);
        }
    }
}
