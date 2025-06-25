package Controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CLUB;

@WebServlet("/AddClubServlet")
@MultipartConfig
public class AddClubServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form input values
        String clubName = request.getParameter("clubName");
        String clubDesc = request.getParameter("clubDesc");
        String clubEstablishedDate = request.getParameter("clubEstablishedDate");
        String clubContact = request.getParameter("clubContact");
        String clubPassword = request.getParameter("clubPassword");

        // Get uploaded file part and use helper
        Part filePart = request.getPart("profilePic");
        byte[] profilePicBytes = uploadFile(filePart);

        // Basic validation to ensure all required fields are present
        if (clubName == null || clubDesc == null || clubEstablishedDate == null || clubContact == null ||
            clubPassword == null || profilePicBytes == null ||
            clubName.trim().isEmpty() || clubDesc.trim().isEmpty() ||
            clubEstablishedDate.trim().isEmpty() || clubContact.trim().isEmpty() || clubPassword.trim().isEmpty()) {

            response.sendRedirect("addClub.jsp?error=Please+fill+in+all+required+fields");
            return;
        }

        try {
            // Create club object and set properties
            CLUB club = new CLUB();
            club.setClubName(clubName);
            club.setClubDesc(clubDesc);
            club.setClubEstablishedDate(clubEstablishedDate);
            club.setClubContact(clubContact);
            club.setClubPassword(clubPassword);
            club.setProfilePic(""); // Not used, but required by model
            club.setProfilePicBlob(profilePicBytes); // Set the BLOB

            // Save to DB and get generated club ID
            int clubID = club.saveAndReturnId();

            if (clubID > 0) {
                response.sendRedirect("addClub.jsp?success=Club+registration+successful!&clubID=" + clubID + "&clubPassword=" + clubPassword);
            } else {
                response.sendRedirect("addClub.jsp?error=Club+registration+failed");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Debug error in server log
            response.sendRedirect("addClub.jsp?error=Error:+" + e.getMessage().replaceAll(" ", "+"));
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
