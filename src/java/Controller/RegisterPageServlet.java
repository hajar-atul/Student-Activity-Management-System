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

        // Create new student object
        STUDENT student = new STUDENT();
        
        // Set student properties from form data
        student.setStudID(Integer.parseInt(request.getParameter("studID")));
        student.setStudName(request.getParameter("studName"));
        student.setStudEmail(request.getParameter("studEmail"));
        student.setStudPassword(request.getParameter("studPassword"));
        student.setStudCourse(request.getParameter("studCourse"));
        student.setStudSemester(request.getParameter("studSemester"));
        student.setStudNoPhone(request.getParameter("studNoPhone"));
        student.setStudType(request.getParameter("studType"));
        student.setDob(request.getParameter("dob"));
        student.setMuetStatus(request.getParameter("muetStatus"));
        student.setAdvisor(request.getParameter("advisor"));

        // Get confirm password
        String confirmPassword = request.getParameter("confirmPassword");

        // Attempt registration
        String result = STUDENT.registerStudent(student, confirmPassword);

        // Handle the result
        if (result.equals("success")) {
            response.sendRedirect("registerResult.jsp?status=success&message=Registration+successful!+You+can+now+login+with+your+credentials");
        } else {
            response.sendRedirect("registerResult.jsp?status=error&message=" + result.replace(" ", "+"));
        }
    }
}
