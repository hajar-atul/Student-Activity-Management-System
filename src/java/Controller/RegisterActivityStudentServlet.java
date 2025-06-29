package Controller;

import model.REGISTERATION;
import model.ACTIVITY;
import model.STUDENT;
import model.CLUB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/RegisterActivityStudentServlet")
public class RegisterActivityStudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String studIDStr = (String) session.getAttribute("studID");
        String activityID = request.getParameter("activityID");

        if (studIDStr == null || activityID == null) {
            response.sendRedirect("AvailableServlet?error=Missing+student+or+activity+ID");
            return;
        }

        try {
            int studID = Integer.parseInt(studIDStr);
            ACTIVITY activity = ACTIVITY.getActivityById(activityID);
            if (activity == null) {
                response.sendRedirect("AvailableServlet?error=Activity+not+found");
                return;
            }
            
            // Check if activity is approved
            if (!"Approved".equalsIgnoreCase(activity.getActivityStatus())) {
                response.sendRedirect("AvailableServlet?error=Activity+is+not+available+for+registration");
                return;
            }
            
            // Check if activity type is Free
            if (!"Free".equals(activity.getActivityType())) {
                response.sendRedirect("AvailableServlet?error=This+is+a+paid+activity.+Please+use+the+payment+page.");
                return;
            }
            
            // Check if student is already registered for this activity
            if (REGISTERATION.isStudentRegistered(studID, activityID)) {
                response.sendRedirect("AvailableServlet?error=You+are+already+registered+for+this+activity.");
                return;
            }
            
            STUDENT student = STUDENT.getStudentById(studID);
            CLUB club = CLUB.getClubById(activity.getClubID());
            request.setAttribute("activity", activity);
            request.setAttribute("student", student);
            request.setAttribute("club", club);
            request.getRequestDispatcher("registerActivity.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AvailableServlet?error=Error+loading+registration+form");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String studIDStr = (String) session.getAttribute("studID");
        String activityID = request.getParameter("activityID");

        if (studIDStr == null || activityID == null) {
            response.sendRedirect("AvailableServlet?error=Missing+student+or+activity+ID");
            return;
        }

        try {
            int studID = Integer.parseInt(studIDStr);
            ACTIVITY activity = ACTIVITY.getActivityById(activityID);
            if (activity == null) {
                response.sendRedirect("AvailableServlet?error=Activity+not+found");
                return;
            }
            
            // Check if activity is approved
            if (!"Approved".equalsIgnoreCase(activity.getActivityStatus())) {
                response.sendRedirect("AvailableServlet?error=Activity+is+not+available+for+registration");
                return;
            }
            
            // Check if activity type is Free
            if (!"Free".equals(activity.getActivityType())) {
                response.sendRedirect("AvailableServlet?error=This+is+a+paid+activity.+Please+use+the+payment+page.");
                return;
            }
            
            // Check if student is already registered for this activity
            if (REGISTERATION.isStudentRegistered(studID, activityID)) {
                response.sendRedirect("AvailableServlet?error=You+are+already+registered+for+this+activity.");
                return;
            }
            
            boolean registered = REGISTERATION.registerStudentForActivity(studID, activityID);
            if (registered) {
                int adabPoint = activity.getAdabPoint();
                STUDENT.incrementAdabPoint(studID, adabPoint);
                session.setAttribute("adabPoint", STUDENT.getAdabPointByStudentId(studID));
                session.setAttribute("registrationMessage", "You have been registered");
                response.sendRedirect("AvailableServlet?success=Registration+successful!+You+have+been+registered+for+the+activity.");
            } else {
                response.sendRedirect("AvailableServlet?error=Registration+failed.+You+may+already+be+registered+for+this+activity.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AvailableServlet?error=Registration+error");
        }
    }
} 