package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.STUDENT;

public class UpdatePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String studID = request.getParameter("studID");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
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
                // Password updated successfully
                response.sendRedirect("indexStudent.jsp?success=password_updated");
            } else {
                // Failed to update password
                response.sendRedirect("newPassword.jsp?studID=" + studentId + "&error=update_failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("forgotPassword.jsp?error=not_found");
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