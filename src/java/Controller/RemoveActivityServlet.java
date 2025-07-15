package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ACTIVITY;

@WebServlet("/RemoveActivityServlet")
public class RemoveActivityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String activityID = request.getParameter("activityID");
        if (activityID != null && !activityID.isEmpty()) {
            ACTIVITY.deleteActivityById(activityID);
        }
        response.sendRedirect("clubDashboardPage.jsp");
    }
} 