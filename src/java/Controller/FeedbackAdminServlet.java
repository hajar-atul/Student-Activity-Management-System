package Controller;

import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/feedbackAdmin")
public class FeedbackAdminServlet extends HttpServlet {
    public static class Feedback {
        public int no;
        public String name, type, summary;
        public Feedback(int no, String name, String type, String summary) {
            this.no = no;
            this.name = name;
            this.type = type;
            this.summary = summary;
        }
    }

    public static List<Feedback> getFeedbacks() {
        List<Feedback> feedbacks = new ArrayList<>();
        feedbacks.add(new Feedback(1, "AHMAD KASSIM", "Complaint", "Low management"));
        feedbacks.add(new Feedback(2, "SITI JENAB", "Complaint", "Food are not enough for participants"));
        feedbacks.add(new Feedback(3, "LAW ANN CHAY", "Suggestion", "Add projector for debate night"));
        feedbacks.add(new Feedback(4, "DARSHAN", "Compliment", "Everything was perfect, the food, the vibe, the people were very friendly."));
        return feedbacks;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("feedbacks", getFeedbacks());
        request.setAttribute("totalFeedback", 125);
        request.setAttribute("resolved", 83);
        request.setAttribute("pending", 29);
        request.setAttribute("newToday", 13);
        request.getRequestDispatcher("FeedbackAdmin.jsp").forward(request, response);
    }
}
