package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.STAFF;

public class StaffForgotPasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String staffID = request.getParameter("staffID");

        System.out.println("StaffForgotPasswordServlet: Received staff ID: " + staffID); // Debug log

        if (staffID == null || staffID.trim().isEmpty()) {
            System.out.println("StaffForgotPasswordServlet: Staff ID is null or empty"); // Debug log
            response.sendRedirect("staffForgot.jsp?error=invalid_id");
            return;
        }

        try {
            int staffIdInt = Integer.parseInt(staffID);
            System.out.println("StaffForgotPasswordServlet: Parsed staff ID: " + staffIdInt); // Debug log

            // Check if staff exists
            if (STAFF.getStaffById(staffIdInt) != null) {
                System.out.println("StaffForgotPasswordServlet: Staff exists, redirecting to new password page"); // Debug log
                response.sendRedirect("newPassword.jsp?staffID=" + staffIdInt);
            } else {
                System.out.println("StaffForgotPasswordServlet: Staff not found"); // Debug log
                response.sendRedirect("staffForgot.jsp?error=not_found");
            }
        } catch (NumberFormatException e) {
            System.out.println("StaffForgotPasswordServlet: Invalid staff ID format"); // Debug log
            response.sendRedirect("staffForgot.jsp?error=invalid_format");
        } catch (Exception e) {
            System.out.println("StaffForgotPasswordServlet: Unexpected error: " + e.getMessage()); // Debug log
            e.printStackTrace();
            response.sendRedirect("staffForgot.jsp?error=system_error");
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