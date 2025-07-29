package Controller;

import model.ACTIVITY;
import util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/NextEventServlet")
public class NextEventServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String studID = (String) session.getAttribute("studID");
        
        if (studID != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Get the next registered event for this student
                String sql = "SELECT a.activityID, a.activityName, a.activityDate, a.posterImage, " +
                           "DATEDIFF(a.activityDate, CURDATE()) as daysUntil " +
                           "FROM activity a " +
                           "JOIN registration r ON a.activityID = r.activityID " +
                           "WHERE r.studID = ? AND a.activityDate >= CURDATE() " +
                           "ORDER BY a.activityDate ASC " +
                           "LIMIT 5";
                
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, studID);
                ResultSet rs = stmt.executeQuery();
                
                List<ActivityInfo> eventList = new ArrayList<>();
                while (rs.next()) {
                    String id = rs.getString("activityID");
                    String name = rs.getString("activityName");
                    String date = rs.getString("activityDate");
                    int daysUntil = rs.getInt("daysUntil");
                    byte[] posterImage = rs.getBytes("posterImage");
                    boolean hasPoster = posterImage != null && posterImage.length > 0;
                    eventList.add(new ActivityInfo(id, name, date, daysUntil, hasPoster));
                }
                session.setAttribute("upcomingEvents", eventList);
                rs.close();
                stmt.close();
                
            } catch (Exception e) {
                e.printStackTrace();
                // Set default values on error
                session.setAttribute("upcomingEvents", new ArrayList<ActivityInfo>());
            }
        }
        
        // Redirect back to dashboard
        response.sendRedirect("studentDashboardPage.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    public static class ActivityInfo implements java.io.Serializable {
        public String id, name, date;
        public int daysUntil;
        public boolean hasPoster;
        public ActivityInfo(String id, String name, String date, int daysUntil, boolean hasPoster) {
            this.id = id;
            this.name = name;
            this.date = date;
            this.daysUntil = daysUntil;
            this.hasPoster = hasPoster;
        }
    }
} 