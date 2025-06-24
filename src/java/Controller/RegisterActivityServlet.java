package Controller;

import model.REGISTERATION;
import model.ACTIVITY;
import model.STUDENT;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/RegisterActivityServlet")
public class RegisterActivityServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String studIDStr = (String) session.getAttribute("studID");
        String activityIDStr = request.getParameter("activityID");

        if (studIDStr == null || activityIDStr == null) {
            response.sendRedirect("availableActivityList.jsp?error=Missing+student+or+activity+ID");
            return;
        }

        try {
            int studID = Integer.parseInt(studIDStr);
            int activityID = Integer.parseInt(activityIDStr);

            // Register the student for the activity
            boolean registered = REGISTERATION.registerStudentForActivity(studID, activityID);
            if (registered) {
                // Get adabPoint for the activity
                int adabPoint = ACTIVITY.getAdabPointByActivityId(activityID);
                // Increment student's adabPoint
                STUDENT.incrementAdabPoint(studID, adabPoint);
                // Optionally, update session value for immediate feedback
                session.setAttribute("adabPoint", STUDENT.getAdabPointByStudentId(studID));
                // Redirect to dashboard
                response.sendRedirect("StudentDashboardServlet");
            } else {
                response.sendRedirect("availableActivityList.jsp?error=Registration+failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("availableActivityList.jsp?error=Registration+error");
        }
    }
} 