package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.STUDENT;
import model.CLUB;
import model.STAFF;
import util.DBConnection;

public class UpdatePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String studID = request.getParameter("studID");
        String clubID = request.getParameter("clubID");
        String staffID = request.getParameter("staffID");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            if (studID != null) {
                int studentId = Integer.parseInt(studID);
                // Validate password length
                if (newPassword.length() < 6) {
                    response.sendRedirect("newPassword.jsp?studID=" + studentId + "&error=invalid");
                    return;
                }
                // Check if passwords match
                if (!newPassword.equals(confirmPassword)) {
                    response.sendRedirect("newPassword.jsp?studID=" + studentId + "&error=mismatch");
                    return;
                }
                // Update password in database
                if (STUDENT.updatePassword(studentId, newPassword)) {
                    response.sendRedirect("indexStudent.jsp?success=password_updated");
                } else {
                    response.sendRedirect("newPassword.jsp?studID=" + studentId + "&error=update_failed");
                }
            } else if (clubID != null) {
                int clubIdInt = Integer.parseInt(clubID);
                // Validate password length
                if (newPassword.length() < 6) {
                    response.sendRedirect("newPassword.jsp?clubID=" + clubIdInt + "&error=invalid");
                    return;
                }
                // Check if passwords match
                if (!newPassword.equals(confirmPassword)) {
                    response.sendRedirect("newPassword.jsp?clubID=" + clubIdInt + "&error=mismatch");
                    return;
                }
                CLUB club = CLUB.getClubById(clubIdInt);
                if (club != null) {
                    club.setClubPassword(newPassword);
                    if (club.update()) {
                        response.sendRedirect("indexClub.jsp?success=password_updated");
                    } else {
                        response.sendRedirect("newPassword.jsp?clubID=" + clubIdInt + "&error=update_failed");
                    }
                } else {
                    response.sendRedirect("clubForgot.jsp?error=not_found");
                }
            } else if (staffID != null) {
                int staffIdInt = Integer.parseInt(staffID);
                // Validate password length
                if (newPassword.length() < 6) {
                    response.sendRedirect("newPassword.jsp?staffID=" + staffIdInt + "&error=invalid");
                    return;
                }
                // Check if passwords match
                if (!newPassword.equals(confirmPassword)) {
                    response.sendRedirect("newPassword.jsp?staffID=" + staffIdInt + "&error=mismatch");
                    return;
                }
                STAFF staff = STAFF.getStaffById(staffIdInt);
                if (staff != null) {
                    staff.setStaffPassword(newPassword);
                    // You may need to add a staff.update() method if not present
                    // For now, let's update via SQL here
                    try {
                        java.sql.Connection conn = DBConnection.getConnection();
                        java.sql.PreparedStatement stmt = conn.prepareStatement("UPDATE staff SET staffPassword=? WHERE staffID=?");
                        stmt.setString(1, newPassword);
                        stmt.setInt(2, staffIdInt);
                        int updated = stmt.executeUpdate();
                        if (updated > 0) {
                            response.sendRedirect("indexStaff.jsp?success=password_updated");
                        } else {
                            response.sendRedirect("newPassword.jsp?staffID=" + staffIdInt + "&error=update_failed");
                        }
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendRedirect("newPassword.jsp?staffID=" + staffIdInt + "&error=update_failed");
                    }
                } else {
                    response.sendRedirect("staffForgot.jsp?error=not_found");
                }
            } else {
                // No valid ID provided
                response.sendRedirect("newPassword.jsp?error=invalid");
            }
        } catch (NumberFormatException e) {
            if (studID != null) {
                response.sendRedirect("forgotPassword.jsp?error=not_found");
            } else if (clubID != null) {
                response.sendRedirect("clubForgot.jsp?error=not_found");
            } else if (staffID != null) {
                response.sendRedirect("staffForgot.jsp?error=not_found");
            } else {
                response.sendRedirect("newPassword.jsp?error=invalid");
            }
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