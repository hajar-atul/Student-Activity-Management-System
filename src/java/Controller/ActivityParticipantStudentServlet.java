package Controller;

import model.REGISTERATION;
import model.STUDENT;
import model.ACTIVITY;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ActivityParticipantStudentServlet")
public class ActivityParticipantStudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String activityIdParam = request.getParameter("activityId");
        List<STUDENT> students = new ArrayList<>();
        ACTIVITY activity = null;
        if (activityIdParam != null) {
            activity = ACTIVITY.getActivityById(activityIdParam);
            List<REGISTERATION> registrations = REGISTERATION.getRegistrationsByActivityId(activityIdParam);
            for (REGISTERATION reg : registrations) {
                STUDENT s = STUDENT.getStudentById(reg.getStudID());
                if (s != null) students.add(s);
            }
        }
        request.setAttribute("activity", activity);
        request.setAttribute("students", students);
        request.getRequestDispatcher("activityparticipantstudent.jsp").forward(request, response);
    }
} 