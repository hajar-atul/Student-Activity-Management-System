package Controller;

import model.STUDENT;
import model.ACTIVITY;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/StaffAdabPointServlet")
public class StaffAdabPointServlet extends HttpServlet {
    
    public static class StudentAdabInfo {
        private int studID;
        private String studName;
        private int totalActivities;
        private int adabPoint;
        
        public StudentAdabInfo(int studID, String studName, int totalActivities, int adabPoint) {
            this.studID = studID;
            this.studName = studName;
            this.totalActivities = totalActivities;
            this.adabPoint = adabPoint;
        }
        
        // Getters
        public int getStudID() { return studID; }
        public String getStudName() { return studName; }
        public int getTotalActivities() { return totalActivities; }
        public int getAdabPoint() { return adabPoint; }
        
        // Setters
        public void setStudID(int studID) { this.studID = studID; }
        public void setStudName(String studName) { this.studName = studName; }
        public void setTotalActivities(int totalActivities) { this.totalActivities = totalActivities; }
        public void setAdabPoint(int adabPoint) { this.adabPoint = adabPoint; }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== DEBUG: StaffAdabPointServlet doGet called ===");
        
        try {
            // Fetch students from database
            List<STUDENT> students = STUDENT.getAllForAdabPoint();
            System.out.println("DEBUG: Students fetched from database: " + students.size());
            
            // Debug: Print each student
            for (STUDENT s : students) {
                System.out.println("DEBUG: Student - ID: " + s.getStudID() + 
                                 ", Name: " + s.getStudName() + 
                                 ", Adab Point: " + s.getAdabPoint());
            }
            
            // Create StudentAdabInfo objects
            List<StudentAdabInfo> studentInfos = new ArrayList<>();
            
            for (STUDENT s : students) {
                // Get activity count for this student
                int totalActivities = getTotalActivitiesForStudent(s.getStudID());
                int adabPoint = s.getAdabPoint();
                
                StudentAdabInfo info = new StudentAdabInfo(
                    s.getStudID(), 
                    s.getStudName(), 
                    totalActivities, 
                    adabPoint
                );
                
                studentInfos.add(info);
                
                System.out.println("DEBUG: Added StudentAdabInfo - " + 
                                 s.getStudName() + " with " + totalActivities + 
                                 " activities and " + adabPoint + " points");
            }
            
            System.out.println("DEBUG: Total StudentAdabInfo objects created: " + studentInfos.size());
            
            // Set attribute for JSP
            request.setAttribute("studentInfos", studentInfos);
            
            // Forward to JSP
            request.getRequestDispatcher("staffAdabPoint.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("ERROR in StaffAdabPointServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Send error response
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Error retrieving student data: " + e.getMessage());
        }
    }
    
    /**
     * Get total activities count for a specific student
     */
    private int getTotalActivitiesForStudent(int studentID) {
        try {
            // Use ACTIVITY.getActivitiesByStudentId as in your other JSPs
            List<ACTIVITY> allRegisteredActivities = ACTIVITY.getActivitiesByStudentId(String.valueOf(studentID));
            return allRegisteredActivities != null ? allRegisteredActivities.size() : 0;
        } catch (Exception e) {
            System.err.println("Error getting activity count for student " + studentID + ": " + e.getMessage());
            return 0;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle POST requests if needed
        doGet(request, response);
    }
}