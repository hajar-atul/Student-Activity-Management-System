package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CLUB;

@WebServlet(name = "ClubSettingsServlet", urlPatterns = {"/clubSettings"})
public class ClubSettingsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        CLUB club = (CLUB) session.getAttribute("club");
        
        if (club == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String clubName = request.getParameter("clubName");
            String clubContact = request.getParameter("clubContact");
            String clubDesc = request.getParameter("clubDesc");
            String clubPassword = request.getParameter("clubPassword");
            
            // Check if the new password is the same as the current password
            if (clubPassword.equals(club.getClubPassword())) {
                response.sendRedirect("clubSettings.jsp?error=Password cannot be the same as before. Please choose a different password.");
                return;
            }
            
            // Update club object with new values
            club.setClubName(clubName);
            club.setClubContact(clubContact);
            club.setClubDesc(clubDesc);
            club.setClubPassword(clubPassword);
            
            // Update in database
            boolean updateSuccess = club.update();
            
            if (updateSuccess) {
                // Update session with new club data
                session.setAttribute("club", club);
                
                // Redirect back to settings page with success message
                response.sendRedirect("clubSettings.jsp?message=Club settings updated successfully!");
            } else {
                // Redirect back to settings page with error message
                response.sendRedirect("clubSettings.jsp?error=Failed to update club settings. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("clubSettings.jsp?error=An error occurred while updating club settings.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Club Settings Update Servlet";
    }
} 