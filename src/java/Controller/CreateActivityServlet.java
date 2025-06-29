package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.ACTIVITY;
import model.CLUB;
import java.io.InputStream;

@WebServlet("/CreateActivityServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 15,  // 15 MB
    maxRequestSize = 1024 * 1024 * 20 // 20 MB
)
public class CreateActivityServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the current club from session
        CLUB club = (CLUB) request.getSession().getAttribute("club");
        if (club == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String activityName = request.getParameter("activityName");
            String activityType = request.getParameter("activityType");
            String description = request.getParameter("description");
            String date = request.getParameter("date");
            String venueName = request.getParameter("venueName");
            String proposedBudgetStr = request.getParameter("proposedBudget");
            String adabPointStr = request.getParameter("adabPoint");
            
            // Validate required fields with detailed error messages
            if (activityName == null || activityName.trim().isEmpty()) {
                response.sendRedirect("createActivity.jsp?error=Activity+name+is+required");
                return;
            }
            if (activityName.trim().length() > 500) {
                response.sendRedirect("createActivity.jsp?error=Activity+name+is+too+long.+Maximum+500+characters+allowed.");
                return;
            }
            if (activityType == null || activityType.trim().isEmpty()) {
                response.sendRedirect("createActivity.jsp?error=Activity+type+is+required");
                return;
            }
            if (description == null || description.trim().isEmpty()) {
                response.sendRedirect("createActivity.jsp?error=Description+is+required");
                return;
            }
            if (description.trim().length() > 65535) { // TEXT field limit
                response.sendRedirect("createActivity.jsp?error=Description+is+too+long.+Maximum+65535+characters+allowed.");
                return;
            }
            if (date == null || date.trim().isEmpty()) {
                response.sendRedirect("createActivity.jsp?error=Date+is+required");
                return;
            }
            if (venueName == null || venueName.trim().isEmpty()) {
                response.sendRedirect("createActivity.jsp?error=Venue+is+required");
                return;
            }
            if (venueName.trim().length() > 500) {
                response.sendRedirect("createActivity.jsp?error=Venue+name+is+too+long.+Maximum+500+characters+allowed.");
                return;
            }
            if (proposedBudgetStr == null || proposedBudgetStr.trim().isEmpty()) {
                response.sendRedirect("createActivity.jsp?error=Budget+is+required");
                return;
            }
            if (adabPointStr == null || adabPointStr.trim().isEmpty()) {
                response.sendRedirect("createActivity.jsp?error=Adab+points+are+required");
                return;
            }
            
            // Validate activity type
            if (!activityType.equals("Free") && !activityType.equals("Paid")) {
                response.sendRedirect("createActivity.jsp?error=Invalid+activity+type");
                return;
            }
            
            // Parse budget
            double proposedBudget;
            try {
                proposedBudget = Double.parseDouble(proposedBudgetStr);
                if (proposedBudget < 0) {
                    response.sendRedirect("createActivity.jsp?error=Budget+cannot+be+negative");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("createActivity.jsp?error=Invalid+budget+amount");
                return;
            }
            
            // Parse adab points
            int adabPoint;
            try {
                adabPoint = Integer.parseInt(adabPointStr);
                if (adabPoint < 0) {
                    response.sendRedirect("createActivity.jsp?error=Adab+points+cannot+be+negative");
                    return;
                }
                if (adabPoint > 1000) {
                    response.sendRedirect("createActivity.jsp?error=Adab+points+cannot+exceed+1000");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("createActivity.jsp?error=Invalid+adab+points+amount");
                return;
            }
            
            // Handle proposal file upload (BLOB)
            Part proposalFilePart = request.getPart("proposalFile");
            byte[] proposalFileBytes = null;
            if (proposalFilePart != null && proposalFilePart.getSize() > 0) {
                proposalFileBytes = getFileBytes(proposalFilePart);
            }
            
            // Handle poster image upload (BLOB)
            Part posterImagePart = request.getPart("posterImage");
            byte[] posterImageBytes = null;
            if (posterImagePart != null && posterImagePart.getSize() > 0) {
                posterImageBytes = getFileBytes(posterImagePart);
            }
            
            // Handle QR image upload (BLOB) - only for paid activities
            Part qrImagePart = request.getPart("qrImage");
            byte[] qrImageBytes = null;
            if (activityType.equals("Paid")) {
                if (qrImagePart == null || qrImagePart.getSize() == 0) {
                    response.sendRedirect("createActivity.jsp?error=QR+image+is+required+for+paid+activities");
                    return;
                }
                qrImageBytes = getFileBytes(qrImagePart);
            }
            
            // Create activity object
            ACTIVITY activity = new ACTIVITY();
            activity.setActivityName(activityName.trim());
            activity.setActivityType(activityType);
            activity.setActivityDesc(description.trim());
            activity.setActivityDate(date);
            activity.setActivityVenue(venueName.trim());
            activity.setActivityBudget(proposedBudget);
            activity.setAdabPoint(adabPoint);
            activity.setProposalFile(proposalFileBytes);
            activity.setQrImage(qrImageBytes);
            activity.setPosterImage(posterImageBytes);
            activity.setActivityStatus("Pending"); // Default status for admin approval
            activity.setClubID(club.getClubId());
            
            // Save to database using the BLOB method
            String generatedActivityId = activity.saveAndReturnId();
            
            if (generatedActivityId != null && !generatedActivityId.isEmpty()) {
                // Success - redirect to activities page with success message
                response.sendRedirect("clubActivitiesPage.jsp?success=Activity+created+successfully.+Waiting+for+admin+approval.");
            } else {
                // Failed to save
                response.sendRedirect("createActivity.jsp?error=Failed+to+create+activity.+Please+try+again.");
            }
            
        } catch (RuntimeException e) {
            // Handle specific runtime exceptions from saveAndReturnId
            e.printStackTrace();
            response.sendRedirect("createActivity.jsp?error=Database+error:+%20" + e.getMessage().replace(" ", "+"));
        } catch (Exception e) {
            // Handle other unexpected exceptions
            e.printStackTrace();
            response.sendRedirect("createActivity.jsp?error=An+unexpected+error+occurred.+Please+try+again.");
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
    
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the create activity page
        response.sendRedirect("createActivity.jsp");
    }
} 