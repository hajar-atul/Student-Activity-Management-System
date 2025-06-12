package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String studID = request.getParameter("studID");
        String password = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                
                // Check if Student ID exists
                String query = "SELECT * FROM student WHERE studID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, studID);
                ResultSet rs = stmt.executeQuery();
                
                if (!rs.next()) {
                    // ID not found
                    response.sendRedirect("registerPage.jsp?message=First+time+here%3F+Sign+Up+now");
                } else {
                    String dbPassword = rs.getString("studPassword");
                    if (dbPassword.equals(password)) {
                        // Successful login
                        String role = rs.getString("studType");
                        String name = rs.getString("studName");

                        HttpSession session = request.getSession();
                        session.setAttribute("user", studID);
                        session.setAttribute("role", role);
                        session.setAttribute("name", name);

                        // Redirect based on role
                        switch (role) {
                            case "student":
                                response.sendRedirect(request.getContextPath() + "/studentDashboardPage.jsp");
                                break;
                            case "staff":
                                response.sendRedirect(request.getContextPath() + "/staffDashboardPage.jsp");
                                break;
                            case "club":
                                response.sendRedirect(request.getContextPath() + "/clubDashboardPage.jsp");
                                break;
                            case "admin":
                                response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
                                break;
                            default:
                                response.sendRedirect("index.jsp?error=Invalid+role");
                                break;
                        }
                    } else {
                        response.sendRedirect("index.jsp?error=Invalid+password");
                    }
                }
            }
        } catch (Exception e) {
            response.getWriter().println("<h3>Database Error: " + e.getMessage() + "</h3>");
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
        return "Login Servlet - Verifies login by Student ID";
    }
}
