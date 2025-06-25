package Controller;

import model.CLUB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ClubImageServlet")
public class ClubImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clubIdParam = request.getParameter("clubID");
        if (clubIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing clubID parameter");
            return;
        }
        int clubId;
        try {
            clubId = Integer.parseInt(clubIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid clubID parameter");
            return;
        }
        CLUB club = CLUB.getClubById(clubId);
        if (club == null || club.getProfilePicBlob() == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Club or image not found");
            return;
        }
        response.setContentType("image/jpeg");
        response.getOutputStream().write(club.getProfilePicBlob());
    }
} 