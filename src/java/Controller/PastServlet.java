package Controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import model.ACTIVITY;
import java.util.List;

@WebServlet("/PastServlet")
public class PastServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?zeroDateTimeBehavior=convertToNull";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String studID = (String) session.getAttribute("studID");
        
        if (studID == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT studName FROM student WHERE studID = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, studID);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String studName = rs.getString("studName");
                    request.setAttribute("studName", studName);
                    request.setAttribute("studID", studID);
                }
            }
            // Fetch joined activities and club count
            List<ACTIVITY> joinedActivities = ACTIVITY.getActivitiesByStudentId(studID);
            int clubCount = ACTIVITY.getClubCountByStudentId(studID);
            request.setAttribute("joinedActivities", joinedActivities);
            request.setAttribute("totalActivities", joinedActivities.size());
            request.setAttribute("clubCount", clubCount);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("pastActivityList.jsp").forward(request, response);
    }
} 