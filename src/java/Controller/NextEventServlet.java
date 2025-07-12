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
                           "LIMIT 1";
                
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, studID);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    // Store next event info in session
                    session.setAttribute("nextEventID", rs.getString("activityID"));
                    session.setAttribute("nextEventName", rs.getString("activityName"));
                    session.setAttribute("nextEventDate", rs.getString("activityDate"));
                    session.setAttribute("daysUntilEvent", rs.getInt("daysUntil"));
                    
                    // Check if poster image exists
                    byte[] posterImage = rs.getBytes("posterImage");
                    session.setAttribute("nextEventHasPoster", posterImage != null && posterImage.length > 0);
                } else {
                    // No upcoming events
                    session.setAttribute("nextEventID", null);
                    session.setAttribute("nextEventName", null);
                    session.setAttribute("nextEventDate", null);
                    session.setAttribute("daysUntilEvent", null);
                    session.setAttribute("nextEventHasPoster", false);
                }
                
                rs.close();
                stmt.close();
                
            } catch (Exception e) {
                e.printStackTrace();
                // Set default values on error
                session.setAttribute("nextEventID", null);
                session.setAttribute("nextEventName", null);
                session.setAttribute("nextEventDate", null);
                session.setAttribute("daysUntilEvent", null);
                session.setAttribute("nextEventHasPoster", false);
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