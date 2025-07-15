package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/AppealActivityServlet")
public class AppealActivityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String activityID = request.getParameter("activityID");
        String appealReason = request.getParameter("appealReason");
        if (activityID != null && appealReason != null && !appealReason.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC", "root", "")) {
                    String sql = "UPDATE activity SET activityStatus = 'Appeal Pending', appealReason = ? WHERE activityID = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, appealReason);
                    stmt.setString(2, activityID);
                    stmt.executeUpdate();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("clubDashboardPage.jsp");
    }
} 