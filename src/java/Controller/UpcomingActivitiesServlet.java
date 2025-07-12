package Controller;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UpcomingActivitiesServlet")
public class UpcomingActivitiesServlet extends HttpServlet {
    
    public static class ActivityInfo {
        private String activityID;
        private String activityName;
        private String activityDate;
        private int daysUntil;
        private boolean hasPoster;
        private String clubName;
        
        public ActivityInfo(String activityID, String activityName, String activityDate, 
                          int daysUntil, boolean hasPoster, String clubName) {
            this.activityID = activityID;
            this.activityName = activityName;
            this.activityDate = activityDate;
            this.daysUntil = daysUntil;
            this.hasPoster = hasPoster;
            this.clubName = clubName;
        }
        
        // Getters
        public String getActivityID() { return activityID; }
        public String getActivityName() { return activityName; }
        public String getActivityDate() { return activityDate; }
        public int getDaysUntil() { return daysUntil; }
        public boolean getHasPoster() { return hasPoster; }
        public String getClubName() { return clubName; }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String studID = (String) session.getAttribute("studID");
        
        if (studID != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Get the next 4 upcoming registered events for this student
                String sql = "SELECT a.activityID, a.activityName, a.activityDate, a.posterImage, " +
                           "DATEDIFF(a.activityDate, CURDATE()) as daysUntil, c.clubName " +
                           "FROM activity a " +
                           "JOIN registration r ON a.activityID = r.activityID " +
                           "LEFT JOIN club c ON a.clubID = c.clubID " +
                           "WHERE r.studID = ? AND a.activityDate >= CURDATE() " +
                           "ORDER BY a.activityDate ASC " +
                           "LIMIT 4";
                
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, studID);
                ResultSet rs = stmt.executeQuery();
                
                List<ActivityInfo> upcomingActivities = new ArrayList<>();
                
                while (rs.next()) {
                    String activityID = rs.getString("activityID");
                    String activityName = rs.getString("activityName");
                    String activityDate = rs.getString("activityDate");
                    int daysUntil = rs.getInt("daysUntil");
                    String clubName = rs.getString("clubName");
                    
                    // Check if poster image exists
                    byte[] posterImage = rs.getBytes("posterImage");
                    boolean hasPoster = posterImage != null && posterImage.length > 0;
                    
                    ActivityInfo activity = new ActivityInfo(activityID, activityName, activityDate, 
                                                           daysUntil, hasPoster, clubName);
                    upcomingActivities.add(activity);
                }
                
                rs.close();
                stmt.close();
                
                // Store in session
                session.setAttribute("upcomingActivities", upcomingActivities);
                session.setAttribute("upcomingActivitiesCount", upcomingActivities.size());
                
                // Set the next event (first one) for backward compatibility
                if (!upcomingActivities.isEmpty()) {
                    ActivityInfo nextEvent = upcomingActivities.get(0);
                    session.setAttribute("nextEventID", nextEvent.getActivityID());
                    session.setAttribute("nextEventName", nextEvent.getActivityName());
                    session.setAttribute("nextEventDate", nextEvent.getActivityDate());
                    session.setAttribute("daysUntilEvent", nextEvent.getDaysUntil());
                    session.setAttribute("nextEventHasPoster", nextEvent.getHasPoster());
                } else {
                    session.setAttribute("nextEventID", null);
                    session.setAttribute("nextEventName", null);
                    session.setAttribute("nextEventDate", null);
                    session.setAttribute("daysUntilEvent", null);
                    session.setAttribute("nextEventHasPoster", false);
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                // Set default values on error
                session.setAttribute("upcomingActivities", new ArrayList<>());
                session.setAttribute("upcomingActivitiesCount", 0);
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
} 