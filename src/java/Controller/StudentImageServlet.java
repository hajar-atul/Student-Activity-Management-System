package Controller;

import model.STUDENT;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/StudentImageServlet")
public class StudentImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studIdParam = request.getParameter("studID");
        if (studIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing studID parameter");
            return;
        }
        int studId;
        try {
            studId = Integer.parseInt(studIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid studID parameter");
            return;
        }
        STUDENT student = STUDENT.getStudentById(studId);
        if (student == null || student.getProfilePicBlob() == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Student or image not found");
            return;
        }
        response.setContentType("image/jpeg");
        response.getOutputStream().write(student.getProfilePicBlob());
    }
} 