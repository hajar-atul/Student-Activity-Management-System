package Controller;

import model.STAFF;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/StaffImageServlet")
public class StaffImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffIdParam = request.getParameter("staffID");
        if (staffIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing staffID parameter");
            return;
        }
        int staffId;
        try {
            staffId = Integer.parseInt(staffIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid staffID parameter");
            return;
        }
        STAFF staff = STAFF.getStaffById(staffId);
        if (staff == null || staff.getProfilePicBlob() == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Staff or image not found");
            return;
        }
        response.setContentType("image/jpeg");
        response.getOutputStream().write(staff.getProfilePicBlob());
    }
} 