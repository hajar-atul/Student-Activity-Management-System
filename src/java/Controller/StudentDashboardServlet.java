package Controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import model.STUDENT;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String studID = (String) session.getAttribute("studID");

        if (studID == null) {
            response.sendRedirect("indexStudent.jsp"); // Redirect if not logged in
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student", "root", "");

            // SQL Query
            String sql = "SELECT * FROM student WHERE studID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, studID);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Set session attributes
                session.setAttribute("studName", rs.getString("studName"));
                session.setAttribute("studEmail", rs.getString("studEmail"));
                session.setAttribute("studCourse", rs.getString("studCourse"));
                session.setAttribute("studSemester", rs.getString("studSemester"));
                session.setAttribute("studNoPhone", rs.getString("studNoPhone"));
                session.setAttribute("dob", rs.getString("dob"));
                session.setAttribute("muetStatus", rs.getString("muetStatus"));
                session.setAttribute("advisor", rs.getString("advisor"));

                // Get adab point
                int adabPoint = STUDENT.getAdabPointByStudentId(Integer.parseInt(studID));
                session.setAttribute("adabPoint", adabPoint);

                // Get days until next registered event
                int daysUntilEvent = STUDENT.getDaysUntilNextActivity(Integer.parseInt(studID));
                session.setAttribute("eventCountdown", daysUntilEvent >= 0 ? daysUntilEvent : "No upcoming events");

                // Optional logs
                System.out.println("DOB: " + rs.getString("dob"));
                System.out.println("ADAB POINT: " + adabPoint);
                System.out.println("Event Countdown: " + daysUntilEvent);
            }

            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("studentDashboardPage.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorStudent.jsp");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
