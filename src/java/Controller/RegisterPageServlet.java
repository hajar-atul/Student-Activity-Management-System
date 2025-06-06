package Controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/PageRegisterServlet")
@MultipartConfig
public class RegisterPageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String id = request.getParameter("id");
        String userType = request.getParameter("userType");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        Part profilePic = request.getPart("profilePic");

        // Simple password match check
        if (!password.equals(confirmPassword)) {
            response.getWriter().println("Passwords do not match!");
            return;
        }

        // Save image (e.g., to a folder on server)
        String fileName = profilePic.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        profilePic.write(uploadPath + File.separator + fileName);

        // Here, add code to insert into database
        response.getWriter().println("Registered successfully!");
        
        // Forward to JSP
        request.getRequestDispatcher("RegisterPage.jsp").forward(request, response);
    }
}
