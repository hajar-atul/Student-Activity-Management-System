package Controller;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.STAFF;

@WebServlet("/UpdateStaffServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class UpdateStaffServlet extends HttpServlet {

    // Utility method for Java 8 compatibility
    private static byte[] toByteArray(InputStream in) throws IOException {
        java.io.ByteArrayOutputStream buffer = new java.io.ByteArrayOutputStream();
        int nRead;
        byte[] data = new byte[4096];
        while ((nRead = in.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }
        buffer.flush();
        return buffer.toByteArray();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try {
            // Get current staff from session
            HttpSession session = request.getSession();
            Object staffIdObj = session.getAttribute("staffID");
            if (staffIdObj == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            int staffID = Integer.parseInt(staffIdObj.toString());

            // Get form parameters
            String staffName = request.getParameter("staffName");
            String staffEmail = request.getParameter("staffEmail");
            String staffPhone = request.getParameter("staffNoPhone");
            String staffDep = request.getParameter("staffDepartment");

            // Handle profile picture upload
            byte[] profilePicBlob = null;
            Part filePart = request.getPart("profilePicture");
            if (filePart != null && filePart.getSize() > 0) {
                String contentType = filePart.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    InputStream inputStream = filePart.getInputStream();
                    profilePicBlob = toByteArray(inputStream);
                    inputStream.close();
                } else {
                    response.sendRedirect("staffSettings.jsp?error=invalid_file_type");
                    return;
                }
            }

            boolean updateSuccess;
            if (profilePicBlob != null) {
                updateSuccess = STAFF.updateStaffWithProfilePicture(staffID, staffName, staffEmail, staffPhone, staffDep, profilePicBlob);
            } else {
                updateSuccess = STAFF.updateStaffFromSettings(staffID, staffName, staffEmail, staffPhone, staffDep);
            }

            if (updateSuccess) {
                // Update session attributes
                session.setAttribute("staffName", staffName);
                session.setAttribute("staffEmail", staffEmail);
                session.setAttribute("staffNoPhone", staffPhone);
                session.setAttribute("staffDepartment", staffDep);
                response.sendRedirect("staffSettings.jsp?message=profile_updated_successfully");
            } else {
                response.sendRedirect("staffSettings.jsp?error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staffSettings.jsp?error=system_error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Update Staff Servlet - Handles staff profile updates with image upload";
    }
} 