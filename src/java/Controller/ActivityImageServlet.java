package Controller;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ACTIVITY;

@WebServlet("/ActivityImageServlet")
public class ActivityImageServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String activityID = request.getParameter("activityID");
        String imageType = request.getParameter("type"); // "qr", "poster", "proposal"
        
        if (activityID == null || imageType == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing activityID or type parameter");
            return;
        }
        
        try {
            ACTIVITY activity = ACTIVITY.getActivityById(activityID);
            if (activity == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Activity not found");
                return;
            }
            
            byte[] imageBytes = null;
            String contentType = "image/jpeg"; // default
            
            switch (imageType.toLowerCase()) {
                case "qr":
                    imageBytes = activity.getQrImage();
                    break;
                case "poster":
                    imageBytes = activity.getPosterImage();
                    break;
                case "proposal":
                    imageBytes = activity.getProposalFile();
                    contentType = "application/octet-stream";
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image type");
                    return;
            }
            
            if (imageBytes == null || imageBytes.length == 0) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                return;
            }
            
            // Set response headers
            response.setContentType(contentType);
            response.setContentLength(imageBytes.length);
            response.setHeader("Cache-Control", "public, max-age=31536000"); // Cache for 1 year
            
            // Write image bytes to response
            try (OutputStream out = response.getOutputStream()) {
                out.write(imageBytes);
                out.flush();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving image");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method not supported");
    }
} 