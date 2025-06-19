package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.STUDENT;
import model.ADMIN;

@WebServlet("/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int studID = Integer.parseInt(request.getParameter("studID"));
        String adminEmail = request.getParameter("adminEmail");

        // Check if student exists
        if (!STUDENT.studentExists(studID)) {
            response.sendRedirect("addAdmin.jsp?status=error&message=Student+ID+does+not+exist");
            return;
        }
        // Check if already admin
        if (ADMIN.isAdmin(studID)) {
            response.sendRedirect("addAdmin.jsp?status=error&message=Student+is+already+an+admin");
            return;
        }
        // Check semester requirement
        if (!ADMIN.minSemRequired(studID)) {
            response.sendRedirect("addAdmin.jsp?status=error&message=Only+students+in+semester+2+to+4+can+be+admin");
            return;
        }
        // Overwrite studEmail and studType in student table
        boolean updated = STUDENT.updateEmailAndType(studID, adminEmail, "admin");
        if (!updated) {
            response.sendRedirect("addAdmin.jsp?status=error&message=Failed+to+update+student+email+and+type");
            return;
        }
        // Add to admin table
        boolean success = ADMIN.addAdmin(studID, adminEmail);
        if (success) {
            response.sendRedirect("addAdmin.jsp?status=success");
        } else {
            response.sendRedirect("addAdmin.jsp?status=error&message=Failed+to+add+admin");
        }
    }
} 