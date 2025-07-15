package Controller;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ClubPosterServlet", urlPatterns = {"/ClubPosterServlet"})
public class ClubPosterServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String clubID = request.getParameter("clubID");
        
        if (clubID == null || clubID.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Club ID is required");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT posterClub FROM club WHERE clubID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(clubID));
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    byte[] posterData = rs.getBytes("posterClub");
                    
                    if (posterData != null && posterData.length > 0) {
                        // Set content type for image
                        response.setContentType("image/jpeg");
                        response.setContentLength(posterData.length);
                        
                        // Write image data to response
                        try (OutputStream out = response.getOutputStream()) {
                            out.write(posterData);
                            out.flush();
                        }
                    } else {
                        // If no poster image, serve a default image or send 404
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "No poster image found");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Club not found");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving poster image");
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
        return "Club Poster Image Servlet";
    }
} 