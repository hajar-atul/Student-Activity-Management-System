package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.STAFF;

@WebServlet("/AddStaffServlet")
@MultipartConfig
public class AddStaffServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form input values
        String staffIdStr = request.getParameter("staffID");
        String staffName = request.getParameter("staffName");
        String staffEmail = request.getParameter("staffEmail");
        String staffPhone = request.getParameter("staffPhone");
        String staffDep = request.getParameter("staffDep");
        String staffPassword = request.getParameter("staffPassword");

        // Get uploaded file part and use helper
        Part filePart = request.getPart("profilePic");
        byte[] profilePicBytes = uploadFile(filePart);

        // Basic validation to ensure all required fields are present
        if (staffIdStr == null || staffName == null || staffEmail == null || staffPhone == null ||
            staffDep == null || staffPassword == null || profilePicBytes == null ||
            staffIdStr.trim().isEmpty() || staffName.trim().isEmpty() || staffEmail.trim().isEmpty() ||
            staffPhone.trim().isEmpty() || staffDep.trim().isEmpty() || staffPassword.trim().isEmpty()) {

            response.sendRedirect("addStaff.jsp?error=Please+fill+in+all+required+fields");
            return;
        }

        try {
            int staffID = Integer.parseInt(staffIdStr);
            // Save to DB
            boolean success = STAFF.addNewStaffWithBlob(staffID, staffName, staffEmail, staffPhone, staffDep, staffPassword, profilePicBytes);
            if (success) {
                response.sendRedirect("addStaff.jsp?success");
            } else {
                response.sendRedirect("addStaff.jsp?error=Staff+registration+failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addStaff.jsp?error=Error:+" + e.getMessage().replaceAll(" ", "+"));
        }
    }

    // Helper method to read file as byte array (Java 8 compatible)
    private byte[] uploadFile(Part part) throws IOException {
        if (part != null && part.getSize() > 0) {
            try (InputStream input = part.getInputStream();
                 ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
                int nRead;
                byte[] data = new byte[16384];
                while ((nRead = input.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                return buffer.toByteArray();
            }
        }
        return null;
    }
} 