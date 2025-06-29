package Controller;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import model.STUDENT;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class UpdateStudentServlet extends HttpServlet {

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
            // Get current student from session
            STUDENT currentStudent = (STUDENT) request.getSession().getAttribute("student");
            if (currentStudent == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            // Get form parameters
            int studID = Integer.parseInt(request.getParameter("studID"));
            String studName = request.getParameter("studName");
            String studEmail = request.getParameter("studEmail");
            String studNoPhone = request.getParameter("studNoPhone");
            String studCourse = request.getParameter("studCourse");
            String studSemester = request.getParameter("studSemester");
            String dob = request.getParameter("dob");
            String muetStatus = request.getParameter("muetStatus");
            String advisor = request.getParameter("advisor");

            // Validate that the student is updating their own profile
            if (studID != currentStudent.getStudID()) {
                response.sendRedirect("SettingsServlet?error=unauthorized_access");
                return;
            }

            // Handle profile picture upload
            byte[] profilePicBlob = null;
            Part filePart = request.getPart("profilePicture");
            if (filePart != null && filePart.getSize() > 0) {
                // Validate file type
                String contentType = filePart.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    // Read the file into a byte array (Java 8 compatible)
                    InputStream inputStream = filePart.getInputStream();
                    profilePicBlob = toByteArray(inputStream);
                    inputStream.close();
                } else {
                    response.sendRedirect("SettingsServlet?error=invalid_file_type");
                    return;
                }
            }

            // Update student information including profile picture
            boolean updateSuccess;
            if (profilePicBlob != null) {
                // Update with new profile picture
                updateSuccess = STUDENT.updateStudentWithProfilePicture(studID, studName, studEmail, 
                        studNoPhone, studCourse, studSemester, dob, muetStatus, advisor, profilePicBlob);
            } else {
                // Update without changing profile picture
                updateSuccess = STUDENT.updateStudentFromSettings(studID, studName, studEmail, 
                        studNoPhone, studCourse, studSemester, dob, muetStatus, advisor);
            }

            if (updateSuccess) {
                // Update session attributes
                HttpSession session = request.getSession();
                session.setAttribute("studName", studName);
                session.setAttribute("studEmail", studEmail);
                session.setAttribute("studCourse", studCourse);
                session.setAttribute("studSemester", studSemester);
                session.setAttribute("studNoPhone", studNoPhone);
                
                // Update the student object in session
                STUDENT updatedStudent = STUDENT.getStudentById(studID);
                if (updatedStudent != null) {
                    session.setAttribute("student", updatedStudent);
                }
                
                String message = profilePicBlob != null ? "profile_and_picture_updated_successfully" : "profile_updated_successfully";
                response.sendRedirect("SettingsServlet?message=" + message);
            } else {
                response.sendRedirect("SettingsServlet?error=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SettingsServlet?error=system_error");
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
        return "Update Student Servlet - Handles student profile updates with image upload";
    }
} 