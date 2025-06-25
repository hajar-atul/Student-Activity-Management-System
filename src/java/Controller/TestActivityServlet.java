package Controller;

import model.ACTIVITY;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/TestActivityServlet")
public class TestActivityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        List<ACTIVITY> activities = ACTIVITY.getAllActivities();
        out.println("Approved Activities:");
        if (activities == null || activities.isEmpty()) {
            out.println("No approved activities found.");
        } else {
            for (ACTIVITY a : activities) {
                out.println(a.getActivityID() + " | " + a.getActivityName() + " | " + a.getActivityStatus());
            }
        }
    }
} 