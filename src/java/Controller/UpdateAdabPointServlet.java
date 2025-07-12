package Controller;

import model.STUDENT;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateAdabPointServlet")
public class UpdateAdabPointServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String studID = (String) session.getAttribute("studID");
        
        if (studID != null) {
            try {
                int currentAdabPoints = STUDENT.getAdabPointByStudentId(Integer.parseInt(studID));
                session.setAttribute("adabPoint", currentAdabPoints);
                
                // Redirect back to the referring page or dashboard
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect("studentDashboardPage.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("studentDashboardPage.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 