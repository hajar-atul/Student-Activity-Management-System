package Controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.STUDENT;

public class RegisterPageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Validate that the registration is for a student
        String studType = request.getParameter("studType");
        if (!"student".equals(studType)) {
            response.sendRedirect("registerResult.jsp?status=error&message=Invalid+registration+type");
            return;
        }

        // Create new student object
        STUDENT student = new STUDENT();
        
        try {
            // Set student properties from form data
            student.setStudID(Integer.parseInt(request.getParameter("studID")));
            student.setStudName(request.getParameter("studName"));
            student.setStudEmail(request.getParameter("studEmail"));
            student.setStudPassword(request.getParameter("studPassword"));
            student.setStudCourse(request.getParameter("studCourse"));
            student.setStudSemester(request.getParameter("studSemester"));
            student.setStudNoPhone(request.getParameter("studNoPhone"));
            student.setStudType("student"); // Force student type
            student.setDob(request.getParameter("dob"));
            student.setMuetStatus(request.getParameter("muetStatus"));
            student.setAdvisor(request.getParameter("advisor"));

            // Get confirm password
            String confirmPassword = request.getParameter("confirmPassword");

            // Check if student ID already exists
            if (STUDENT.studentExists(student.getStudID())) {
                response.sendRedirect("registerResult.jsp?status=error&message=Student+ID+already+exists");
                return;
            }

            // Attempt registration
            String result = STUDENT.registerStudent(student, confirmPassword);

            // Handle the result
            if (result.equals("success")) {
                response.sendRedirect("registerResult.jsp?status=success&message=Registration+successful!+You+can+now+login+with+your+credentials");
            } else {
                response.sendRedirect("registerResult.jsp?status=error&message=" + result.replace(" ", "+"));
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("registerResult.jsp?status=error&message=Invalid+Student+ID+format");
        } catch (Exception e) {
            response.sendRedirect("registerResult.jsp?status=error&message=Registration+failed.+Please+try+again");
        }
    }
}
