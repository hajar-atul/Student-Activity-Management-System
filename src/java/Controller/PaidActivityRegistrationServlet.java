package Controller;

import model.REGISTERATION;
import model.ACTIVITY;
import model.STUDENT;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/PaidActivityRegistrationServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class PaidActivityRegistrationServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String studIDStr = (String) session.getAttribute("studID");
        String activityID = request.getParameter("activityID");

        if (studIDStr == null || activityID == null) {
            response.sendRedirect("availableActivityList.jsp?error=Missing+student+or+activity+ID");
            return;
        }

        try {
            int studID = Integer.parseInt(studIDStr);
            ACTIVITY activity = ACTIVITY.getActivityById(activityID);
            if (activity == null) {
                response.sendRedirect("availableActivityList.jsp?error=Activity+not+found");
                return;
            }
            
            // Check if activity is approved
            if (!"Approved".equalsIgnoreCase(activity.getActivityStatus())) {
                response.sendRedirect("availableActivityList.jsp?error=Activity+is+not+available+for+registration");
                return;
            }
            
            // Check if activity type is Paid
            if (!"Paid".equals(activity.getActivityType())) {
                response.sendRedirect("availableActivityList.jsp?error=This+is+a+free+activity.+Please+use+the+free+registration+page.");
                return;
            }
            
            // Check if student is already registered
            if (REGISTERATION.isStudentRegistered(studID, activityID)) {
                response.sendRedirect("availableActivityList.jsp?error=You+are+already+registered+for+this+activity");
                return;
            }
            
            // Handle receipt file upload
            Part receiptPart = request.getPart("receipt");
            if (receiptPart == null || receiptPart.getSize() == 0) {
                response.sendRedirect("qrPaymentTypePage.jsp?activityID=" + activityID + "&error=Receipt+file+is+required");
                return;
            }
            
            byte[] receiptBytes = getFileBytes(receiptPart);
            if (receiptBytes == null || receiptBytes.length == 0) {
                response.sendRedirect("qrPaymentTypePage.jsp?activityID=" + activityID + "&error=Invalid+receipt+file");
                return;
            }
            
            // Register student for paid activity with receipt
            boolean registered = REGISTERATION.registerStudentForPaidActivity(studID, activityID, receiptBytes);
            if (registered) {
                int adabPoint = activity.getAdabPoint();
                STUDENT.incrementAdabPoint(studID, adabPoint);
                session.setAttribute("adabPoint", STUDENT.getAdabPointByStudentId(studID));
                session.setAttribute("registrationMessage", "You have been registered");
                response.sendRedirect("availableActivityList.jsp?success=Registration+successful!+You+have+been+registered+for+the+activity.");
            } else {
                response.sendRedirect("qrPaymentTypePage.jsp?activityID=" + activityID + "&error=Registration+failed.+Please+try+again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("availableActivityList.jsp?error=Registration+error");
        }
    }
    
    // Helper method to convert Part to byte array
    private byte[] getFileBytes(Part part) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }
        
        try (InputStream inputStream = part.getInputStream()) {
            byte[] bytes = new byte[(int) part.getSize()];
            inputStream.read(bytes);
            return bytes;
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("availableActivityList.jsp?error=GET+method+not+supported");
    }
} 