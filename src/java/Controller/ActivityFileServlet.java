package Controller;

import model.ACTIVITY;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ActivityFileServlet")
public class ActivityFileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String activityId = request.getParameter("activityID");
        String fileType = request.getParameter("type"); // "proposal", "qr", "poster"
        ACTIVITY activity = null;
        byte[] fileBytes = null;
        String contentType = "application/octet-stream";
        String fileName = "file";

        if (activityId != null) {
            activity = ACTIVITY.getActivityById(activityId);
        }

        if (activity != null && fileType != null) {
            switch (fileType) {
                case "proposal":
                    fileBytes = activity.getProposalFile();
                    contentType = "application/pdf"; // adjust if needed
                    fileName = "proposal.pdf";
                    break;
                case "qr":
                    fileBytes = activity.getQrImage();
                    contentType = "image/png";
                    fileName = "qr.png";
                    break;
                case "poster":
                    fileBytes = activity.getPosterImage();
                    contentType = "image/jpeg";
                    fileName = "poster.jpg";
                    break;
            }
        }

        if (fileBytes != null) {
            response.setContentType(contentType);
            if (!fileType.equals("qr") && !fileType.equals("poster")) {
                response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            }
            response.setContentLength(fileBytes.length);
            response.getOutputStream().write(fileBytes);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
} 