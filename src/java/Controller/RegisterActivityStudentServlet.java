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
            STUDENT student = STUDENT.getStudentById(studID);
            CLUB club = CLUB.getClubById(activity.getClubID());
            request.setAttribute("activity", activity);
            request.setAttribute("student", student);
            request.setAttribute("club", club);
            request.getRequestDispatcher("activityRegisteration.jsp").forward(request, response);
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
            boolean registered = REGISTERATION.registerStudentForActivity(studID, activityID);
            if (registered) {
                int adabPoint = activity.getAdabPoint();
                STUDENT.incrementAdabPoint(studID, adabPoint);
                session.setAttribute("adabPoint", STUDENT.getAdabPointByStudentId(studID));
                session.setAttribute("registrationMessage", "You have been registered");
                response.sendRedirect("AvailableServlet");
            } else {
                response.sendRedirect("AvailableServlet?error=Registration+failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AvailableServlet?error=Registration+error");
        }
    }
} 