package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.FEEDBACK;

@WebServlet(name = "FeedbackServlet", urlPatterns = {"/FeedbackServlet"})
public class FeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String studIDStr = (String) session.getAttribute("studID");
        String activityID = request.getParameter("activityID");
        String clubID = request.getParameter("clubID");
        String ratingStr = request.getParameter("rating");
        String comments = request.getParameter("comments");
        int rating = 0;
        int studID = 0;
        try { rating = Integer.parseInt(ratingStr); } catch (Exception e) { rating = 0; }
        try { studID = Integer.parseInt(studIDStr); } catch (Exception e) { studID = 0; }
        String message = null;
        String error = null;
        if (studID == 0 || activityID == null || rating == 0 || comments == null || comments.trim().isEmpty()) {
            error = "Please fill in all required fields and select a rating.";
        } else {
            FEEDBACK feedback = new FEEDBACK();
            feedback.setFeedComment(comments);
            feedback.setFeedRating(rating);
            feedback.setStudId(studID);
            feedback.setActivityID(activityID);
            boolean success = FEEDBACK.insertFeedback(comments, rating, studID, activityID);
            if (success) {
                message = "Thank you for your feedback!";
            } else {
                error = "Failed to submit feedback. Please try again.";
            }
        }
        String redirectUrl = "feedback.jsp?activityID=" + activityID;
        if (message != null) {
            redirectUrl += "&message=" + java.net.URLEncoder.encode(message, "UTF-8");
        }
        if (error != null) {
            redirectUrl += "&error=" + java.net.URLEncoder.encode(error, "UTF-8");
        }
        response.sendRedirect(redirectUrl);
    }
} 