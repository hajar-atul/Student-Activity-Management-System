package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.STUDENT;

public class UpdateStudentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Get current student from session
            STUDENT currentStudent = (STUDENT) request.getSession().getAttribute("student");
            if (currentStudent == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            // Get form parameters
            int studID = Integer.parseInt(request.getParameter("studID"));
            String studName = request.getParameter("studName");
            String studEmail = request.getParameter("studEmail");
            String studNoPhone = request.getParameter("studNoPhone");
            String studCourse = request.getParameter("studCourse");
            String studSemester = request.getParameter("studSemester");
            String dob = request.getParameter("dob");
            String muetStatus = request.getParameter("muetStatus");
            String advisor = request.getParameter("advisor");

            // Validate that the student is updating their own profile
            if (studID != currentStudent.getStudID()) {
                response.sendRedirect("settings.jsp?error=unauthorized_access");
                return;
            }

            // Update student information using the new method
            boolean updateSuccess = STUDENT.updateStudentFromSettings(studID, studName, studEmail, 
                    studNoPhone, studCourse, studSemester, dob, muetStatus, advisor);

            if (updateSuccess) {
                // Update session attributes
                HttpSession session = request.getSession();
                session.setAttribute("studName", studName);
                session.setAttribute("studEmail", studEmail);
                session.setAttribute("studCourse", studCourse);
                session.setAttribute("studSemester", studSemester);
                session.setAttribute("studNoPhone", studNoPhone);
                
                // Update the student object in session
                STUDENT updatedStudent = STUDENT.getStudentById(studID);
                if (updatedStudent != null) {
                    session.setAttribute("student", updatedStudent);
                }
                
                response.sendRedirect("settings.jsp?message=profile_updated_successfully");
            } else {
                response.sendRedirect("settings.jsp?error=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("settings.jsp?error=system_error");
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

    @Override
    public String getServletInfo() {
        return "Update Student Servlet - Handles student profile updates";
    }
} 