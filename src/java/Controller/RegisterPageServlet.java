package Controller;

 import java.sql.*;
 import java.io.IOException;
 import java.io.PrintWriter;
 import java.sql.Connection;
 import java.sql.DriverManager;
 import java.sql.ResultSet;
 import java.sql.Statement;
 import javax.servlet.ServletException;
 import javax.servlet.annotation.WebServlet;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;

 import java.sql.PreparedStatement;
import javax.servlet.annotation.MultipartConfig;

 /**
 * Servlet implementation class ResgisterPageCustomerServlet
 */
 @WebServlet("/register")
 @MultipartConfig
 public class RegisterPageServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;
        
 /**
 * @see HttpServlet#HttpServlet()
 */
 public RegisterPageServlet() {
    super();
    // TODO Auto-generated constructor stub
 }
 
 /**
 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
 response)
 */
 protected void doGet(HttpServletRequest request, HttpServletResponse response)
 throws ServletException, IOException {
 // TODO Auto-generated method stub
 response.getWriter().append("Served at: ").append(request.getContextPath());
 }
 
  /**
 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
 response)
 */
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
 throws ServletException, IOException {
        // TODO Auto-generated method stub
        //doGet(request, response);
        
        response.setContentType("text/html");
        
        String studID = request.getPart("userId").getInputStream().toString(); 
        String studName = request.getParameter("fullName");
        String studPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String studEmail = request.getParameter("email");
        String studCourse = request.getParameter("course");
        String studSemester = request.getParameter("sem");
        String studNoPhone = request.getParameter("umobile");
        String studType = request.getParameter("userRole");

        PrintWriter out=response.getWriter();
        out.print(studID);
        /*out.print(studPassword);
        out.print(studEmail);
        out.print(studCourse);
        out.print(studSemester);
        out.print(studNoPhone);
        out.print(studType);*/
        
        /*int studID=2001;
        
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con =
            DriverManager.getConnection("jdbc:mysql://localhost:3306/student?zeroDateTimeBehavior=convertToNull","root","");
            Statement stmt=con.createStatement();
            String sql="select studID from student order by studID";
            ResultSet rs=stmt.executeQuery(sql);
            
        while(rs.next())
        {
            studID=rs.getInt("studID");
        }
        studID= studID + 1;
        
        
        boolean check = false;
        if(studPassword.equalsIgnoreCase(confirmPassword))
            check = true;
        
         if(check==true)
        {
            PreparedStatement ps = (PreparedStatement)
con.prepareStatement("INSERT INTO student VALUES (?,?,?,?,?,?,?,?)");
                ps.setInt(1, studID);
                ps.setString(2, studName);
                ps.setString(3, studEmail);
                ps.setString(4, studCourse);
                ps.setString(5, studSemester);
                ps.setString(6, studNoPhone);
                ps.setString(7, studType);
                ps.setString(8, studPassword);
                
                ps.executeUpdate();
                ps.close();
                
            out.println("<html>");
            out.println("<head>");
            out.println(" <title>Registration Success</title>");
            out.println(" <style>");
            out.println(" body {");
            out.println("background-color: #f7f7f7;");
            out.println("font-family: Arial, sans-serif;");
            out.println(" }");
            out.println("");
            out.println(" .container {");
            out.println("max-width: 400px;");
            out.println("margin: 50px auto;");
            out.println("padding: 20px;");
            out.println("background-color: #fff;");
            out.println("box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);");
            out.println("border-radius: 4px;");
            out.println(" }");
            out.println("");
            out.println(" h1 {");
            out.println("font-size: 24px;");
            out.println("margin-bottom: 20px;");
            out.println("text-align: center;");
            out.println(" }");
            out.println("");
            out.println(" p {");
            out.println("margin-bottom: 20px;");
            out.println(" }");
            out.println("");
            out.println(" .message {");
            out.println("text-align: center;");
            out.println("font-size: 18px;");
            out.println("color: #4caf50;");
            out.println(" }");
            out.println("");
            out.println(" .button-container {");
            out.println("text-align: center;");
            out.println(" }");
            out.println("");
            out.println(" .button {");
            out.println("display: inline-block;");
            out.println("padding: 10px 20px;");
            out.println("background-color: #4caf50;");
            out.println("color: #fff;");
            out.println("text-decoration: none;");
            out.println("border-radius: 4px;");
            out.println("transition: background-color 0.3s ease;");
            out.println(" }");
            out.println("");
            out.println(" .button:hover {");
            out.println("background-color: #45a049;");
            out.println(" }");
            out.println(" </style>");
            out.println("</head>");
            out.println("<body>");
            out.println(" <div class=\"container\">");
            out.println(" <h1>Registration Successful</h1>");
            out.println(" <p class=\"message\">Congratulations! You have successfully registered.</p>");
            out.println(" <div class=\"button-container\">");
            out.println("<a href=\"index.jsp\"class=\"button\">Continue</a>");
            out.println(" </div>");
            out.println(" </div>");
            out.println("</body>");
            out.println("</html>");
        }
        else
        {
            out.println("<html>");
            out.println("<head>");
            out.println(" <title>Registration Failed</title>");
            out.println(" <style>");
            out.println(" body {");
            out.println("background-color: #f7f7f7;");
            out.println("font-family: Arial, sans-serif;");
            out.println(" }");
            out.println("");
            out.println(" .container {");
            out.println("max-width: 400px;");
            out.println("margin: 50px auto;");
            out.println("padding: 20px;");
            out.println("background-color: #fff;");
            out.println("box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);");
            out.println("border-radius: 4px;");
            out.println(" }");
            out.println("");
            out.println(" h1 {");
            out.println("font-size: 24px;");
            out.println("margin-bottom: 20px;");
            out.println("text-align: center;");
            out.println(" }");
            out.println("");
            out.println(" p {");
            out.println("margin-bottom: 20px;");
            out.println(" }");
            out.println("");
            out.println(" .message {");
            out.println("text-align: center;");
            out.println("margin-bottom: 20px;");
            out.println("color: #ff4d4d;");
            out.println(" }");
            out.println("");
            out.println(" .button-container {");
            out.println("text-align: center;");
            out.println(" }");
            out.println("");
            out.println(" .button {");
            out.println("display: inline-block;");
            out.println("padding: 10px 20px;");
            out.println("background-color: #ff4d4d;");
            out.println("color: #fff;");
            out.println("text-decoration: none;");
            out.println("border-radius: 4px;");
            out.println("transition: background-color 0.3s ease;");
            out.println(" }");
            out.println("");
            out.println(" .button:hover {");
            out.println("background-color: #ff3333;");
            out.println(" }");
            out.println(" </style>");
            out.println("</head>");
            out.println("<body>");
            out.println(" <div class=\"container\">");
            out.println(" <h1>Registration Failed</h1>");
            out.println(" <p class=\"message\">Oops! Something went wrong during the registration process.</p>");
            out.println(" <div class=\"button-container\">");
            out.println("<a href=\"RegisterPage.jsp\"class=\"button\">Go Back</a>");
            out.println(" </div>");
            out.println(" </div>");
            out.println("</body>");
            out.println("</html>");
        }
        stmt.close();
        con.close();
    }
    catch(Exception e2)
    {
        System.out.println(e2);
        e2.printStackTrace();
    }
    out.close();*/
 }
        
 }