package Controller;

import com.itextpdf.text.*;
import com.
itextpdf.text.pdf.PdfWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/CertificateServlet")
public class CertificateServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?zeroDateTimeBehavior=convertToNull";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String activityID = request.getParameter("activityID");
        String studID = request.getParameter("studID");
        String studName = "";
        String studEmail = "";
        String studProgram = "";
        String activityName = "";
        String activityDate = "";
        String activityVenue = "";
        String activityDesc = "";
        String clubName = "";

        // Fetch student and activity details
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                // Get student details (studID is int in DB)
                PreparedStatement ps1 = conn.prepareStatement("SELECT studName, studEmail, studCourse FROM student WHERE studID = ?");
                ps1.setInt(1, Integer.parseInt(studID));
                ResultSet rs1 = ps1.executeQuery();
                if (rs1.next()) {
                    studName = rs1.getString("studName");
                    studEmail = rs1.getString("studEmail");
                    studProgram = rs1.getString("studCourse"); // use studCourse for program
                }
                // Get activity details
                PreparedStatement ps2 = conn.prepareStatement("SELECT activityName, activityDate, activityVenue, activityDesc, clubID FROM activity WHERE activityID = ?");
                ps2.setString(1, activityID);
                ResultSet rs2 = ps2.executeQuery();
                String clubID = "";
                if (rs2.next()) {
                    activityName = rs2.getString("activityName");
                    activityDate = rs2.getString("activityDate");
                    activityVenue = rs2.getString("activityVenue");
                    activityDesc = rs2.getString("activityDesc");
                    clubID = rs2.getString("clubID");
                }
                // Get club/organizer name
                if (clubID != null && !clubID.isEmpty()) {
                    PreparedStatement ps3 = conn.prepareStatement("SELECT clubName FROM club WHERE clubID = ?");
                    ps3.setInt(1, Integer.parseInt(clubID));
                    ResultSet rs3 = ps3.executeQuery();
                    if (rs3.next()) {
                        clubName = rs3.getString("clubName");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set response headers
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Certificate_" + studID + "_" + activityID + ".pdf");

        // Generate PDF
        try {
            OutputStream out = response.getOutputStream();
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            Font titleFont = new Font(Font.FontFamily.HELVETICA, 24, Font.BOLD);
            Font normalFont = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL);
            Font boldFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);

            Paragraph title = new Paragraph("Certificate of Participation", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph(" "));

            // Student Details
            document.add(new Paragraph("Student Details:", boldFont));
            document.add(new Paragraph("Name: " + studName, normalFont));
            document.add(new Paragraph("Student ID: " + studID, normalFont));
            if (studEmail != null && !studEmail.isEmpty()) document.add(new Paragraph("Email: " + studEmail, normalFont));
            if (studProgram != null && !studProgram.isEmpty()) document.add(new Paragraph("Program: " + studProgram, normalFont));
            document.add(new Paragraph(" "));

            // Activity Details
            document.add(new Paragraph("Activity Details:", boldFont));
            document.add(new Paragraph("Activity Name: " + activityName, normalFont));
            document.add(new Paragraph("Date: " + activityDate, normalFont));
            if (activityVenue != null && !activityVenue.isEmpty()) document.add(new Paragraph("Venue: " + activityVenue, normalFont));
            if (activityDesc != null && !activityDesc.isEmpty()) document.add(new Paragraph("Description: " + activityDesc, normalFont));
            if (clubName != null && !clubName.isEmpty()) document.add(new Paragraph("Organizer: " + clubName, normalFont));
            document.add(new Paragraph(" "));

            document.add(new Paragraph("Congratulations!", normalFont));

            document.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
} 