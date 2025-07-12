package Controller;

import model.ACTIVITY;
import model.STUDENT;
import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/RegisterActivityStudentServlet")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max
public class RegisterActivityStudentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String activityID = request.getParameter("activityID");
        String studID = request.getParameter("studID");
        String studName = request.getParameter("studName");
        String message = "";
        boolean isPaid = false;
        double activityFee = 0;
        InputStream paymentProofStream = null;

        try (Connection conn = DBConnection.getConnection()) {
            // Check for duplicate registration
            PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM registration WHERE activityID = ? AND studID = ?");
            checkStmt.setString(1, activityID);
            checkStmt.setString(2, studID);
            ResultSet checkRs = checkStmt.executeQuery();
            if (checkRs.next() && checkRs.getInt(1) > 0) {
                message = "You already registered";
                response.sendRedirect("registerActivity.jsp?activityID=" + activityID + "&error=" + java.net.URLEncoder.encode(message, "UTF-8"));
                return;
            }
            checkRs.close();
            checkStmt.close();

            // Get activity info to check if paid
            PreparedStatement actStmt = conn.prepareStatement("SELECT activityFee FROM activity WHERE activityID = ?");
            actStmt.setString(1, activityID);
            ResultSet actRs = actStmt.executeQuery();
            if (actRs.next()) {
                activityFee = actRs.getDouble("activityFee");
                isPaid = activityFee > 0;
            }
            actRs.close();
            actStmt.close();

            // If paid, handle file upload
            if (isPaid) {
                Part paymentProofPart = request.getPart("paymentProof");
                if (paymentProofPart != null && paymentProofPart.getSize() > 0) {
                    paymentProofStream = paymentProofPart.getInputStream();
                } else {
                    message = "Payment proof is required for paid activities.";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("registerActivity.jsp?activityID=" + activityID).forward(request, response);
                    return;
                }
            }

            // Insert registration (and payment if paid)
            String regSql = isPaid
                ? "INSERT INTO registration (activityID, studID, paymentProof) VALUES (?, ?, ?)"
                : "INSERT INTO registration (activityID, studID) VALUES (?, ?)";
            PreparedStatement regStmt = conn.prepareStatement(regSql);
            regStmt.setString(1, activityID);
            regStmt.setString(2, studID);
            if (isPaid) {
                regStmt.setBlob(3, paymentProofStream);
            }
            int rows = regStmt.executeUpdate();
            regStmt.close();

            if (rows > 0) {
                // Get the adab points for this activity
                int activityAdabPoints = 0;
                PreparedStatement adabStmt = conn.prepareStatement("SELECT adabPoint FROM activity WHERE activityID = ?");
                adabStmt.setString(1, activityID);
                ResultSet adabRs = adabStmt.executeQuery();
                if (adabRs.next()) {
                    activityAdabPoints = adabRs.getInt("adabPoint");
                }
                adabRs.close();
                adabStmt.close();
                
                // Update student's adab points
                if (activityAdabPoints > 0) {
                    PreparedStatement updateStmt = conn.prepareStatement("UPDATE student SET adabPoint = adabPoint + ? WHERE studID = ?");
                    updateStmt.setInt(1, activityAdabPoints);
                    updateStmt.setString(2, studID);
                    updateStmt.executeUpdate();
                    updateStmt.close();
                }
                
                message = "Registration successful! You have been registered for this activity and earned " + activityAdabPoints + " adab points.";
                
                // Clear upcoming activities cache so it refreshes on dashboard
                HttpSession session = request.getSession();
                session.setAttribute("upcomingActivities", null);
                session.setAttribute("nextEventID", null);
                
                response.sendRedirect("registerActivity.jsp?activityID=" + activityID + "&success=" + java.net.URLEncoder.encode(message, "UTF-8"));
            } else {
                message = "Registration failed. Please try again.";
                response.sendRedirect("registerActivity.jsp?activityID=" + activityID + "&error=" + java.net.URLEncoder.encode(message, "UTF-8"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
            response.sendRedirect("registerActivity.jsp?activityID=" + activityID + "&error=" + java.net.URLEncoder.encode(message, "UTF-8"));
        }
    }
} 