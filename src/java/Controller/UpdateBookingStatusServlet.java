package Controller;

import model.BOOKING;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        String status = request.getParameter("status");
        String redirectPage = request.getParameter("redirectPage");

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            BOOKING.updateBookingStatus(bookingId, status);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the page (venue/resource/all)
        response.sendRedirect(redirectPage);
    }
} 