package Controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BOOKING;
import model.STAFF;

@WebServlet(name = "StaffDashboardServlet", urlPatterns = {"/StaffDashboardServlet"})
public class StaffDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Fetch counts from the models
            int pendingBookings = BOOKING.getBookingCountByStatus("Pending");
            int approvedBookings = BOOKING.getBookingCountByStatus("Approved");
            
            // Set counts as request attributes
            request.setAttribute("bookingRequests", pendingBookings);
            request.setAttribute("approvedBookings", approvedBookings);

            // Fetch staff object for profile image
            Integer staffId = (Integer) request.getSession().getAttribute("staffID");
            if (staffId != null) {
                STAFF staff = STAFF.getStaffById(staffId);
                request.setAttribute("staffObj", staff);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dashboardError", "Error fetching dashboard data: " + e.getMessage());
        }
        
        // Forward to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("staffDashboardPage.jsp");
        dispatcher.forward(request, response);
    }
}