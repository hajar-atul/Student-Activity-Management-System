package Controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.STUDENT;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig
public class RegisterPageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Validate that the registration is for a student
        String studType = request.getParameter("studType");
        if (!"student".equals(studType)) {
            response.sendRedirect("registerResult.jsp?status=error&message=Invalid+registration+type");
            return;
        }

        // Create new student object
        STUDENT student = new STUDENT();
        
        try {
            // Set student properties from form data
            student.setStudID(Integer.parseInt(request.getParameter("studID")));
            student.setStudName(request.getParameter("studName"));
            student.setStudEmail(request.getParameter("studEmail"));
            student.setStudPassword(request.getParameter("studPassword"));
            student.setStudCourse(request.getParameter("studCourse"));
            student.setStudSemester(request.getParameter("studSemester"));
            student.setStudNoPhone(request.getParameter("studNoPhone"));
            student.setStudType("student"); // Force student type
            student.setDob(request.getParameter("dob"));
            student.setMuetStatus(request.getParameter("muetStatus"));
            student.setAdvisor(request.getParameter("advisor"));

            // Handle profile picture upload as BLOB
            Part filePart = request.getPart("profilePic");
            byte[] profilePicBytes = uploadFile(filePart);
            System.out.println("profilePicBytes: " + (profilePicBytes != null ? profilePicBytes.length : "null"));
            if (profilePicBytes == null || profilePicBytes.length == 0) {
                response.sendRedirect("registerResult.jsp?status=error&message=Profile+picture+is+required");
                return;
            }
            student.setProfilePic(""); // Not used, but required by model
            student.setProfilePicBlob(profilePicBytes);

            // Get confirm password
            String confirmPassword = request.getParameter("confirmPassword");

            // Check if student ID already exists
            if (STUDENT.studentExists(student.getStudID())) {
                response.sendRedirect("registerResult.jsp?status=error&message=Student+ID+already+exists");
                return;
            }

            // Attempt registration
            String result = STUDENT.registerStudent(student, confirmPassword);

            // Handle the result
            if (result.equals("success")) {
                response.sendRedirect("registerResult.jsp?status=success&message=Registration+successful!+You+can+now+login+with+your+credentials");
            } else {
                response.sendRedirect("registerResult.jsp?status=error&message=" + result.replace(" ", "+"));
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("registerResult.jsp?status=error&message=Invalid+Student+ID+format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registerResult.jsp?status=error&message=Registration+failed.+Please+try+again");
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
