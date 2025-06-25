package Controller;

import model.BOOKING;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/BookingListServlet")
public class BookingListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        List<BOOKING> bookings = null;
        String jsp = "staffBooking.jsp"; // fallback

        if ("venue".equalsIgnoreCase(type)) {
            bookings = BOOKING.getBookingsByType("Venue");
            jsp = "staffVenueBooking.jsp";
        } else if ("resource".equalsIgnoreCase(type)) {
            bookings = BOOKING.getBookingsByType("Resource");
            jsp = "staffResourceBooking.jsp";
        } else {
            bookings = BOOKING.getAllBookings();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher(jsp).forward(request, response);
    }
} 