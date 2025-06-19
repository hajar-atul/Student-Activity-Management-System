package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.STUDENT;
import model.CLUB;
import model.ADMIN;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String role = request.getParameter("role");

        try {
            if ("admin".equals(role)) {
                // Admin login using studID and password
                String adminID = request.getParameter("email"); // This is actually studID
                String password = request.getParameter("password");
                if (adminID == null || password == null || adminID.trim().isEmpty() || password.trim().isEmpty()) {
                    response.sendRedirect("indexAdmin.jsp?error=missing_credentials");
                    return;
                }
                try {
                    int studID = Integer.parseInt(adminID);
                    // Check if this studID is an admin
                    if (!ADMIN.isAdmin(studID)) {
                        response.sendRedirect("indexAdmin.jsp?error=not_admin");
                        return;
                    }
                    // Check password from student table
                    if (!STUDENT.validatePassword(studID, password)) {
                        response.sendRedirect("indexAdmin.jsp?error=wrong_password");
                        return;
                    }
                    // Success: set session and redirect
                    ADMIN admin = ADMIN.getAdminByStudID(studID);
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    session.setAttribute("adminID", adminID);
                    session.setAttribute("role", "admin");
                    session.setAttribute("adminName", admin.getStudentInfo().getStudName());
                    response.sendRedirect("adminDashboardPage.jsp");
                } catch (NumberFormatException e) {
                    response.sendRedirect("indexAdmin.jsp?error=invalid_admin_id");
                }
            } else if ("club".equals(role)) {
                // Club login logic (unchanged)
                String clubID = request.getParameter("email");
                String clubPassword = request.getParameter("password");
                if (clubID == null || clubPassword == null || clubID.trim().isEmpty() || clubPassword.trim().isEmpty()) {
                    response.sendRedirect("indexClub.jsp?error=missing_credentials");
                    return;
                }
                try {
                    CLUB club = CLUB.authenticateClub(Integer.parseInt(clubID), clubPassword);
                    if (club != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("club", club);
                        session.setAttribute("clubID", clubID);
                        session.setAttribute("role", "club");
                        session.setAttribute("clubName", club.getClubName());
                        response.sendRedirect("clubDashboardPage.jsp");
                    } else {
                        response.sendRedirect("indexClub.jsp?error=invalid_credentials");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("indexClub.jsp?error=invalid_club_id");
                }
            } else {
                // Student authentication logic remains unchanged
                String userID = request.getParameter("studID");
                String password = request.getParameter("password");
                int studID = Integer.parseInt(userID);
                if (!STUDENT.studentExists(studID)) {
                    response.sendRedirect("indexStudent.jsp?error=not_registered");
                    return;
                }
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
        return "Login Servlet - Verifies login by Student ID, Club ID, or Admin ID and redirects based on role.";
    }
}
