package Controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BOOKING;

@WebServlet(name = "VenueBookingServlet", urlPatterns = {"/VenueBookingServlet"})
public class VenueBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String date = request.getParameter("date");
        String duration = request.getParameter("duration");
        String time = request.getParameter("time");
        String venueName = request.getParameter("venueName");
        
        // In a real application, clubName would come from the user's session.
        // For this example, we'll hardcode it.
        String clubName = "SOCIETY"; 
        
        String itemDetails = "Time: " + time + ", Duration: " + duration;
        
        String message;
        
        try {
            boolean success = BOOKING.addBooking("Venue", venueName, itemDetails, clubName, date);
            if (success) {
                message = "Venue booking request submitted successfully!";
            } else {
                message = "Failed to submit venue booking request. Please try again.";
            }
        } catch (Exception e) {
            message = "An error occurred while submitting the request: " + e.getMessage();
            e.printStackTrace();
        }
        
        response.sendRedirect("venueBooking.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }
} 