package Controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import model.STUDENT;
import model.ACTIVITY;
import java.util.List;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String studID = (String) session.getAttribute("studID");

        if (studID == null) {
            response.sendRedirect("indexStudent.jsp"); // Redirect if not logged in
            return;
        }

        try {
            // Get complete student object including profile picture
            STUDENT student = STUDENT.getStudentById(Integer.parseInt(studID));
            
            if (student != null) {
                // Set session attributes
                session.setAttribute("studName", student.getStudName());
                session.setAttribute("studEmail", student.getStudEmail());
                session.setAttribute("studCourse", student.getStudCourse());
                session.setAttribute("studSemester", student.getStudSemester());
                session.setAttribute("studNoPhone", student.getStudNoPhone());
                session.setAttribute("dob", student.getDob());
                session.setAttribute("muetStatus", student.getMuetStatus());
                session.setAttribute("advisor", student.getAdvisor());
                session.setAttribute("adabPoint", student.getAdabPoint());

                // Set the complete student object in session
                session.setAttribute("student", student);

                // Set profile image URL for BLOB
                session.setAttribute("profilePicUrl", "StudentImageServlet?studID=" + studID);

                // Get days until next registered event
                int daysUntilEvent = STUDENT.getDaysUntilNextActivity(Integer.parseInt(studID));
                session.setAttribute("daysUntilEvent", daysUntilEvent >= 0 ? daysUntilEvent : null);

                // Get registered activities count for dashboard
                List<ACTIVITY> registeredActivities = ACTIVITY.getActivitiesByStudentId(studID);
                int totalActivities = registeredActivities != null ? registeredActivities.size() : 0;
                session.setAttribute("totalActivities", totalActivities);

                // Get unique clubs count
                int clubCount = ACTIVITY.getClubCountByStudentId(studID);
                session.setAttribute("clubCount", clubCount);

                // Optional logs
                System.out.println("DOB: " + student.getDob());
                System.out.println("ADAB POINT: " + student.getAdabPoint());
                System.out.println("Event Countdown: " + daysUntilEvent);
                System.out.println("Total Activities: " + totalActivities);
                System.out.println("Club Count: " + clubCount);
            } else {
                response.sendRedirect("errorStudent.jsp");
                return;
            }

            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("studentDashboardPage.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorStudent.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
