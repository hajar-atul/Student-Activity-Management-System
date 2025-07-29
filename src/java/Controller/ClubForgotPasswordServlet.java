package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.CLUB;

public class ClubForgotPasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String clubID = request.getParameter("clubID");

        System.out.println("ClubForgotPasswordServlet: Received club ID: " + clubID); // Debug log

        if (clubID == null || clubID.trim().isEmpty()) {
            System.out.println("ClubForgotPasswordServlet: Club ID is null or empty"); // Debug log
            response.sendRedirect("clubForgot.jsp?error=invalid_id");
            return;
        }

        try {
            int clubIdInt = Integer.parseInt(clubID);
            System.out.println("ClubForgotPasswordServlet: Parsed club ID: " + clubIdInt); // Debug log

            // Check if club exists
            if (CLUB.getClubById(clubIdInt) != null) {
                System.out.println("ClubForgotPasswordServlet: Club exists, redirecting to new password page"); // Debug log
                response.sendRedirect("newPassword.jsp?clubID=" + clubIdInt);
            } else {
                System.out.println("ClubForgotPasswordServlet: Club not found"); // Debug log
                response.sendRedirect("clubForgot.jsp?error=not_found");
            }
        } catch (NumberFormatException e) {
            System.out.println("ClubForgotPasswordServlet: Invalid club ID format"); // Debug log
            response.sendRedirect("clubForgot.jsp?error=invalid_format");
        } catch (Exception e) {
            System.out.println("ClubForgotPasswordServlet: Unexpected error: " + e.getMessage()); // Debug log
            e.printStackTrace();
            response.sendRedirect("clubForgot.jsp?error=system_error");
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
} 