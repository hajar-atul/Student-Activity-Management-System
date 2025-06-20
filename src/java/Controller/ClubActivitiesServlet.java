package Controller;

import model.CLUB;
import model.ACTIVITY;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Iterator;

@WebServlet(name = "ClubActivitiesServlet", urlPatterns = {"/clubActivitiesPage"})
public class ClubActivitiesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        CLUB club = (CLUB) (session != null ? session.getAttribute("club") : null);
        List<ACTIVITY> activities = new java.util.ArrayList<>();
        String filterStatus = request.getParameter("status");

        if (club != null) {
            int clubId = club.getClubId();
            activities = ACTIVITY.getActivitiesByClubId(clubId);
            if (filterStatus != null && !"All".equalsIgnoreCase(filterStatus)) {
                Iterator<ACTIVITY> it = activities.iterator();
                while (it.hasNext()) {
                    ACTIVITY act = it.next();
                    if (!act.getActivityStatus().equalsIgnoreCase(filterStatus)) {
                        it.remove();
                    }
                }
            }
        }

        request.setAttribute("activities", activities);
        request.setAttribute("filterStatus", filterStatus != null ? filterStatus : "All");
        request.getRequestDispatcher("clubActivitiesPage.jsp").forward(request, response);
    }
} 