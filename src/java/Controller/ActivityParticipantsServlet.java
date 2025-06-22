package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ACTIVITY;
import model.STUDENT;

@WebServlet("/ActivityParticipantsServlet")
public class ActivityParticipantsServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String activityIdStr = request.getParameter("activityId");
        
        if (activityIdStr != null && !activityIdStr.trim().isEmpty()) {
            try {
                // No need to parse as integer since we're using String IDs
                String activityId = activityIdStr.trim();
                
                // Get the activity details
                ACTIVITY activity = ACTIVITY.getActivityById(activityId);
                
                if (activity != null) {
                    // Get participants for this activity
                    List<STUDENT> participants = ACTIVITY.getParticipantsByActivityId(activityId);
                    
                    // Set attributes for the JSP
                    request.setAttribute("activity", activity);
                    request.setAttribute("participants", participants);
                    request.setAttribute("participantCount", participants.size());
                    
                    // Forward to the participants list page
                    request.getRequestDispatcher("activityParticipants.jsp").forward(request, response);
                } else {
                    response.sendRedirect("clubActivitiesPage.jsp?error=Activity+not+found");
                }
                
            } catch (Exception e) {
                response.sendRedirect("clubActivitiesPage.jsp?error=Invalid+activity+ID");
            }
        } else {
            response.sendRedirect("clubActivitiesPage.jsp?error=Activity+ID+required");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 