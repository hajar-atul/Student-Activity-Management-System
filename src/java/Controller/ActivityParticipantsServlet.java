package Controller;

import model.REGISTERATION;
import model.STUDENT;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/activityParticipants")
public class ActivityParticipantsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String activityId = request.getParameter("activityId");
        if (activityId != null) activityId = activityId.trim();

        // --- DIRECT DEBUG QUERY ---
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM registration WHERE TRIM(activityID) = ?")) {
            pstmt.setString(1, activityId);
            try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    System.out.println("DEBUG: DIRECT QUERY: studID=" + rs.getInt("studID") +
                        ", activityID=" + rs.getString("activityID") +
                        ", regDate=" + rs.getString("regDate"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // --- END DIRECT DEBUG QUERY ---

        // --- DEBUG CODE START ---
        try (java.sql.Connection conn = util.DBConnection.getConnection();
             java.sql.Statement stmt = conn.createStatement();
             java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM registration")) {
            while (rs.next()) {
                System.out.println("DEBUG: DB row: studID=" + rs.getInt("studID") +
                    ", activityID=" + rs.getString("activityID") +
                    ", regDate=" + rs.getString("regDate"));
                }
            } catch (Exception e) {
            e.printStackTrace();
        }
        // --- DEBUG CODE END ---

        List<REGISTERATION> registrations = REGISTERATION.getRegistrationsByActivityId(activityId);
        List<STUDENT> students = new ArrayList<>();

        // Debug output
        System.out.println("DEBUG: activityId = " + activityId);
        System.out.println("DEBUG: registrations.size() = " + registrations.size());
        for (REGISTERATION reg : registrations) {
            System.out.println("DEBUG: reg.studID = " + reg.getStudID());
            STUDENT student = STUDENT.getStudentById(reg.getStudID());
            System.out.println("DEBUG: student = " + (student != null ? student.getStudName() : "null"));
            if (student != null) {
                students.add(student);
            }
        }
        System.out.println("DEBUG: students.size() = " + students.size());

        request.setAttribute("students", students);
        request.setAttribute("activityId", activityId);
        RequestDispatcher dispatcher = request.getRequestDispatcher("activityParticipants.jsp");
        dispatcher.forward(request, response);
    }
} 