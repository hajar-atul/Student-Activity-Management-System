package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BOOKING;

@WebServlet(name = "ResourceBookingServlet", urlPatterns = {"/ResourceBookingServlet"})
public class ResourceBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String date = request.getParameter("date");
        String resourceName = request.getParameter("resourceName");
        String resourceQty = request.getParameter("resourceQty");
        
        // In a real application, clubName would come from the user's session.
        // For this example, we'll hardcode it.
        String clubName = "IT CLUB";
        
        String itemDetails = "Quantity: " + resourceQty;
        
        String message;
        
        try {
            boolean success = BOOKING.addBooking("Resource", resourceName, itemDetails, clubName, date);
            if (success) {
                message = "Resource booking request submitted successfully!";
            } else {
                message = "Failed to submit resource booking request. Please try again.";
            }
        } catch (Exception e) {
            message = "An error occurred while submitting the request: " + e.getMessage();
            e.printStackTrace();
        }
        
        response.sendRedirect("resourceReq.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }
} 