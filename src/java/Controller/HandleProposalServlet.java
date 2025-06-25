package Controller;

import model.ACTIVITY;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/handleProposal")
public class HandleProposalServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String activityID = request.getParameter("activityID");
        String action = request.getParameter("action"); // 'approve' or 'reject'
        String message = "";
        try {
            if (activityID != null && action != null) {
                String newStatus = null;
                if ("approve".equalsIgnoreCase(action)) {
                    newStatus = "Approved";
                } else if ("reject".equalsIgnoreCase(action)) {
                    newStatus = "Rejected";
                }
                if (newStatus != null) {
                    ACTIVITY.updateActivityStatus(activityID, newStatus);
                    message = "Activity proposal " + newStatus.toLowerCase() + " successfully.";
                }
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
        response.sendRedirect("adminDashboardPage.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }
} 