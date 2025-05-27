/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

/**
 *
 * @author USER
 */

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Sample user data (This would typically come from a database)
        String studentId = "2023278754";
        String name = "MUHAMMAD AMINUDDIN BIN HASNAN";
        String dob = "14/02/2003";
        String programme = "BHM";
        String mobileNumber = "0165404975";
        String email = "aminuddinhasnan14@gmail.com";
        int muetStatus = 6;
        String advisor = "DR ANIQ PAWRIS BIN SAMSUDIN";

        // Set attributes to be accessed in JSP
        request.setAttribute("studentId", studentId);
        request.setAttribute("name", name);
        request.setAttribute("dob", dob);
        request.setAttribute("programme", programme);
        request.setAttribute("mobileNumber", mobileNumber);
        request.setAttribute("email", email);
        request.setAttribute("muetStatus", muetStatus);
        request.setAttribute("advisor", advisor);

        // Forward to JSP
        request.getRequestDispatcher("StudentDashboardPage.jsp").forward(request, response);
    }
}

