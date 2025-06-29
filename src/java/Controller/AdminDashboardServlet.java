package Controller;

import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    public static class Proposal {
        public String activity, club, date;
        public Proposal(String activity, String club, String date) {
            this.activity = activity;
            this.club = club;
            this.date = date;
        }
    }

    public static List<Proposal> getProposals() {
        List<Proposal> proposals = new ArrayList<>();
        proposals.add(new Proposal("TECH EXPO", "IT CLUB", "26 JUNE 2025"));
        proposals.add(new Proposal("CHARITY RUN", "EACC CLUB", "12 JULY 2025"));
        proposals.add(new Proposal("DEBATE NIGHT", "SOCIETY", "15 JULY 2025"));
        return proposals;
    }

    public static int getStudentCount() {
        return 17925;
    }

    public static int getClubCount() {
        return 25;
    }

    // Your methods here (doGet, doPost, etc.)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch pending activities from the database
        java.util.List<model.ACTIVITY> pendingActivities = model.ADMIN.getPendingActivities();
        request.setAttribute("pendingActivities", pendingActivities);
        // Forward to JSP
        request.getRequestDispatcher("adminDashboardPage.jsp").forward(request, response);
    }
}
