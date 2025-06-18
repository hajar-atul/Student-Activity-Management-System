package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.STUDENT_CLUB;

@WebServlet("/ClubMembershipServlet")
public class ClubMembershipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String studIDStr = (String) session.getAttribute("studID");
        String clubIDStr = request.getParameter("clubID");
        String action = request.getParameter("action");

        // Validate required parameters
        if (studIDStr == null || clubIDStr == null || action == null) {
            response.sendRedirect("studentClub.jsp?error=missing_parameters");
            return;
        }

        try {
            int studID = Integer.parseInt(studIDStr);
            int clubID = Integer.parseInt(clubIDStr);

            if ("join".equals(action)) {
                String result = STUDENT_CLUB.addStudentToClub(studID, clubID);
                if ("success".equals(result)) {
                    response.sendRedirect("studentClub.jsp?message=joined_successfully");
                } else {
                    response.sendRedirect("studentClub.jsp?error=" + result.toLowerCase().replace(" ", "_"));
                }
            } else if ("leave".equals(action)) {
                boolean success = STUDENT_CLUB.removeStudentFromClub(studID, clubID);
                if (success) {
                    response.sendRedirect("studentClub.jsp?message=left_successfully");
                } else {
                    response.sendRedirect("studentClub.jsp?error=failed_to_leave");
                }
            } else {
                response.sendRedirect("studentClub.jsp?error=invalid_action");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("studentClub.jsp?error=invalid_id_format");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
} 