package Controller;

import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/studentList")
public class StudentListServlet extends HttpServlet {
    public static class Activity {
        public String activity, club;
        public int studentCount;
        public Activity(String activity, String club, int studentCount) {
            this.activity = activity;
            this.club = club;
            this.studentCount = studentCount;
        }
    }

    public static List<Activity> getActivities() {
        List<Activity> activities = new ArrayList<>();
        activities.add(new Activity("TECH EXPO", "IT CLUB", 25));
        activities.add(new Activity("ROTU SOLO NIGHT", "ROTU CLUB", 30));
        activities.add(new Activity("DEBATE NIGHT", "SOCIETY", 15));
        return activities;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activities", getActivities());
        request.getRequestDispatcher("StudentList.jsp").forward(request, response);
    }
}
