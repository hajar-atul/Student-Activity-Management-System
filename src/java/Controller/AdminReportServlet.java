package Controller;

import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/adminReport")
public class AdminReportServlet extends HttpServlet {
    public static class ReportRow {
        public String club, proposal, date, status;
        public ReportRow(String club, String proposal, String date, String status) {
            this.club = club;
            this.proposal = proposal;
            this.date = date;
            this.status = status;
        }
    }

    public static List<ReportRow> getReports() {
        List<ReportRow> reports = new ArrayList<>();
        reports.add(new ReportRow("EACC", "KIMONO PAINTING", "23 FEB 2025", "Checked"));
        reports.add(new ReportRow("RELEX", "HIKING", "4 APR 2025", "Checked"));
        reports.add(new ReportRow("BADMINTON", "FRIENDLY LEAGUE", "10 MAY 2025", "Checked"));
        reports.add(new ReportRow("PINGPONG", "SPORTS FEST", "28 JUNE 2025", "Checked"));
        reports.add(new ReportRow("RELEX", "KAYAKING", "12 JUNE 2026", "Checked"));
        return reports;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("reports", getReports());
        request.getRequestDispatcher("adminReport.jsp").forward(request, response);
    }
}
