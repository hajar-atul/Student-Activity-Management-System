package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Get form input
            String email = request.getParameter("email");
            String password = request.getParameter("password"); // assuming password used later
            String role = request.getParameter("role");

            // Create session and store attributes
            HttpSession session = request.getSession();
            session.setAttribute("user", email);
            session.setAttribute("role", role);
            session.setAttribute("name", "Nama Pengguna Demo"); // placeholder, can customize later

            // Redirect based on role
            String redirectPage = "";
            switch (role) {
                case "student":
                    redirectPage = "/studentDashboardPage.jsp";
                    break;
                case "staff":
                    redirectPage = "/staffDashboardPage.jsp";
                    break;
                case "club":
                    redirectPage = "/clubDashboardPage.jsp";
                    break;
                case "admin":
                    redirectPage = "/adminDashboard.jsp";
                    break;
                default:
                    // If role is not selected or unrecognized, send back to login with error
                    redirectPage = "/index.jsp?error=invalid_role";
                    break;
            }

            response.sendRedirect(request.getContextPath() + redirectPage);
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
        return "Handles user login and redirects based on role";
    }
}
