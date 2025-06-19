package Controller;

import java.io.*;
import java.nio.file.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/CreateActivityServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*15,      // 15MB
                 maxRequestSize=1024*1024*20)   // 20MB
public class CreateActivityServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String activityName = request.getParameter("activityName");
        String description = request.getParameter("description");
        String date = request.getParameter("date");
        String remarks = request.getParameter("remarks");
        Part filePart = request.getPart("attachFile");
        String fileName = null;

        // Handle file upload
        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String appPath = request.getServletContext().getRealPath("");
            String uploadPath = appPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Insert into database
        int activityID = -1;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO activity (activityName, description, date, remarks, fileName) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, activityName);
                pstmt.setString(2, description);
                pstmt.setString(3, date);
                pstmt.setString(4, remarks);
                pstmt.setString(5, fileName);
                int affectedRows = pstmt.executeUpdate();
                if (affectedRows > 0) {
                    try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            activityID = generatedKeys.getInt(1);
                        }
                    }
                }
            }
            if (activityID > 0) {
                response.sendRedirect("clubDashboardPage.jsp?success=Activity+created+successfully!+ID:+" + activityID);
            } else {
                response.sendRedirect("createActivity.jsp?error=Failed+to+create+activity");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("createActivity.jsp?error=Error:+" + e.getMessage().replaceAll(" ", "+"));
        }
    }
} 