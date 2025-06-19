package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CLUB;

@WebServlet("/AddClubServlet")
public class AddClubServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String clubName = request.getParameter("clubName");
        String clubDesc = request.getParameter("clubDesc");
        String clubEstablishedDate = request.getParameter("clubEstablishedDate");
        String clubContact = request.getParameter("clubContact");
        String clubPassword = request.getParameter("clubPassword");

        if (clubName == null || clubDesc == null || clubEstablishedDate == null || clubContact == null || clubPassword == null ||
            clubName.trim().isEmpty() || clubDesc.trim().isEmpty() || clubEstablishedDate.trim().isEmpty() || clubContact.trim().isEmpty() || clubPassword.trim().isEmpty()) {
            response.sendRedirect("addClub.jsp?error=Please+fill+in+all+required+fields");
            return;
        }

        try {
            CLUB club = new CLUB();
            club.setClubName(clubName);
            club.setClubDesc(clubDesc);
            club.setClubEstablishedDate(clubEstablishedDate);
            club.setClubContact(clubContact);
            club.setClubPassword(clubPassword);
            int clubID = club.saveAndReturnId();
            if (clubID > 0) {
                response.sendRedirect("addClub.jsp?success=Club+registration+successful!&clubID=" + clubID + "&clubPassword=" + clubPassword);
            } else {
                response.sendRedirect("addClub.jsp?error=Club+registration+failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addClub.jsp?error=Error:+" + e.getMessage().replaceAll(" ", "+"));
        }
    }
} 