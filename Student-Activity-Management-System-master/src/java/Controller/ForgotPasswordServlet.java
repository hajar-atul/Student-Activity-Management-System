package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.STUDENT;

public class ForgotPasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String studID = request.getParameter("studID");
        
        System.out.println("ForgotPasswordServlet: Received student ID: " + studID); // Debug log

        if (studID == null || studID.trim().isEmpty()) {
            System.out.println("ForgotPasswordServlet: Student ID is null or empty"); // Debug log
            response.sendRedirect("forgotPassword.jsp?error=invalid_id");
            return;
        }

        try {
            int studentId = Integer.parseInt(studID);
            System.out.println("ForgotPasswordServlet: Parsed student ID: " + studentId); // Debug log
            
            // Check if student exists
            if (STUDENT.studentExists(studentId)) {
                System.out.println("ForgotPasswordServlet: Student exists, redirecting to new password page"); // Debug log
                response.sendRedirect("newPassword.jsp?studID=" + studentId);
            } else {
                System.out.println("ForgotPasswordServlet: Student not found"); // Debug log
                response.sendRedirect("forgotPassword.jsp?error=not_found");
            }
        } catch (NumberFormatException e) {
            System.out.println("ForgotPasswordServlet: Invalid student ID format"); // Debug log
            response.sendRedirect("forgotPassword.jsp?error=invalid_format");
        } catch (Exception e) {
            System.out.println("ForgotPasswordServlet: Unexpected error: " + e.getMessage()); // Debug log
            e.printStackTrace();
            response.sendRedirect("forgotPassword.jsp?error=system_error");
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