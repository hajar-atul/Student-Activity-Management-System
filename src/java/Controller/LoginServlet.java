package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.STUDENT;
import model.CLUB;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String userID = request.getParameter("studID");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            if ("club".equals(role)) {
                // Club authentication
                CLUB club = CLUB.authenticateClub(Integer.parseInt(userID), password);
                
                if (club != null) {
                    // Club authentication successful
                    HttpSession session = request.getSession();
                    session.setAttribute("club", club);
                    session.setAttribute("user", userID);
                    session.setAttribute("role", "club");
                    session.setAttribute("name", club.getClubName());
                    
                    response.sendRedirect("clubDashboardPage.jsp");
                } else {
                    // Club not found or invalid credentials
                    response.sendRedirect("indexClub.jsp?error=club_not_registered");
                }
            } else {
                // Check if student exists first
                int studID = Integer.parseInt(userID);
                if (!STUDENT.studentExists(studID)) {
                    response.sendRedirect("indexStudent.jsp?error=not_registered");
                    return;
                }

                // Proceed with password validation if student exists
                if (STUDENT.validatePassword(studID, password)) {
                    STUDENT student = STUDENT.getStudentById(studID);
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("student", student);
                    session.setAttribute("user", userID);
                    session.setAttribute("role", student.getStudType());
                    session.setAttribute("name", student.getStudName());
                    session.setAttribute("studID", userID);
                    session.setAttribute("studName", student.getStudName());
                    session.setAttribute("studEmail", student.getStudEmail());
                    session.setAttribute("studCourse", student.getStudCourse());
                    session.setAttribute("studSemester", student.getStudSemester());
                    session.setAttribute("studNoPhone", student.getStudNoPhone());

                    switch (student.getStudType()) {
                        case "student":
                            response.sendRedirect("studentDashboardPage.jsp");
                            break;
                        case "staff":
                            response.sendRedirect("staffDashboardPage.jsp");
                            break;
                        case "admin":
                            response.sendRedirect("adminDashboard.jsp");
                            break;
                        default:
                            response.sendRedirect("index.jsp?error=Invalid+role");
                            break;
                    }
                } else {
                    response.sendRedirect("indexStudent.jsp?error=wrong_password");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorStudent.jsp");
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
        return "Login Servlet - Verifies login by Student ID and redirects based on role.";
    }
}
