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
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?zeroDateTimeBehavior=convertToNull&useSSL=false&requireSSL=false";
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

        // Debug: print incoming parameters
        System.out.println("DEBUG: CertificateServlet studID param = " + studID + ", activityID param = " + activityID);

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
                } else {
                    System.out.println("DEBUG: No student found for studID=" + studID);
                }
                System.out.println("DEBUG: Fetched student: " + studName + ", email: " + studEmail + ", program: " + studProgram);
                // Get activity details (use TRIM)
                PreparedStatement ps2 = conn.prepareStatement("SELECT activityName, activityDate, activityVenue, activityDesc, clubID FROM activity WHERE TRIM(activityID) = ?");
                ps2.setString(1, activityID.trim());
                ResultSet rs2 = ps2.executeQuery();
                String clubID = "";
                if (rs2.next()) {
                    activityName = rs2.getString("activityName");
                    activityDate = rs2.getString("activityDate");
                    activityVenue = rs2.getString("activityVenue");
                    activityDesc = rs2.getString("activityDesc");
                    clubID = rs2.getString("clubID");
                } else {
                    System.out.println("DEBUG: No activity found for activityID=" + activityID);
                }
                System.out.println("DEBUG: Fetched activity: " + activityName + ", date: " + activityDate + ", venue: " + activityVenue + ", desc: " + activityDesc + ", clubID: " + clubID);
                // Get club/organizer name
                if (clubID != null && !clubID.isEmpty()) {
                    PreparedStatement ps3 = conn.prepareStatement("SELECT clubName FROM club WHERE clubID = ?");
                    ps3.setInt(1, Integer.parseInt(clubID));
                    ResultSet rs3 = ps3.executeQuery();
                    if (rs3.next()) {
                        clubName = rs3.getString("clubName");
                    } else {
                        System.out.println("DEBUG: No club found for clubID=" + clubID);
                    }
                }
                System.out.println("DEBUG: Fetched club: " + clubName);
                // Print all variables before generating PDF
                System.out.println("DEBUG: FINAL VALUES - studName=" + studName + ", studID=" + studID + ", studEmail=" + studEmail + ", studProgram=" + studProgram + ", activityName=" + activityName + ", activityDate=" + activityDate + ", activityVenue=" + activityVenue + ", activityDesc=" + activityDesc + ", clubName=" + clubName);
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

            // Add UMP logo at the top center (already present)
            try {
                String logoPath = getServletContext().getRealPath("/image/logoUMP.jpg");
                Image logo = Image.getInstance(logoPath);
                logo.scaleToFit(100, 100);
                logo.setAlignment(Element.ALIGN_CENTER);
                document.add(logo);
            } catch (Exception e) {
                System.out.println("DEBUG: Could not add logo image: " + e.getMessage());
            }

            // Elegant fonts
            Font scriptFont = new Font(Font.FontFamily.TIMES_ROMAN, 32, Font.BOLDITALIC, BaseColor.RED);
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 28, Font.BOLD);
            Font nameFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD);
            Font idFont = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL);
            Font labelFont = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL);
            Font activityFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Font dateFont = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL);
            Font smallFont = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL);

            // Title in script font (English)
            Paragraph certTitle = new Paragraph("Certificate of Participation", scriptFont);
            certTitle.setAlignment(Element.ALIGN_CENTER);
            certTitle.setSpacingAfter(10f);
            document.add(certTitle);

            // Appreciation line (English)
            Paragraph appreciation = new Paragraph("This certificate is proudly presented to", labelFont);
            appreciation.setAlignment(Element.ALIGN_CENTER);
            appreciation.setSpacingAfter(18f);
            document.add(appreciation);

            // Student name
            Paragraph name = new Paragraph(studName, nameFont);
            name.setAlignment(Element.ALIGN_CENTER);
            name.setSpacingAfter(5f);
            document.add(name);

            // Student ID
            Paragraph id = new Paragraph("Student ID: " + studID, idFont);
            id.setAlignment(Element.ALIGN_CENTER);
            id.setSpacingAfter(15f);
            document.add(id);

            // Participation line (English)
            Paragraph join = new Paragraph("for participating in the following activity:", labelFont);
            join.setAlignment(Element.ALIGN_CENTER);
            join.setSpacingAfter(15f);
            document.add(join);

            // Activity name
            Paragraph activity = new Paragraph(activityName, activityFont);
            activity.setAlignment(Element.ALIGN_CENTER);
            activity.setSpacingAfter(5f);
            document.add(activity);

            // Activity date
            Paragraph date = new Paragraph("Date: " + activityDate, dateFont);
            date.setAlignment(Element.ALIGN_CENTER);
            date.setSpacingAfter(10f);
            document.add(date);

            // Venue and organizer (optional)
            if (activityVenue != null && !activityVenue.isEmpty()) {
                Paragraph venue = new Paragraph("Venue: " + activityVenue, smallFont);
                venue.setAlignment(Element.ALIGN_CENTER);
                venue.setSpacingAfter(5f);
                document.add(venue);
            }
            if (clubName != null && !clubName.isEmpty()) {
                Paragraph organizer = new Paragraph("Organizer: " + clubName, smallFont);
                organizer.setAlignment(Element.ALIGN_CENTER);
                organizer.setSpacingAfter(15f);
                document.add(organizer);
            }

            // Signature/confirmation line
            Paragraph confirm = new Paragraph("Congratulations!", labelFont);
            confirm.setAlignment(Element.ALIGN_CENTER);
            confirm.setSpacingBefore(40f);
            document.add(confirm);

            document.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
} 