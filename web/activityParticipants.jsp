<%@ page import="java.util.List" %>
<%@ page import="model.STUDENT" %>
<!DOCTYPE html>
<html>
<head>
  <title>Activity Participants</title>
  <style>
        body { font-family: Arial, sans-serif; background: #f6f6f6; }
        .container { max-width: 800px; margin: 40px auto; background: #fff; border-radius: 10px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        h2 { text-align: center; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px 16px; border: 1px solid #ccc; text-align: center; }
        th { background: #eaf6f6; font-size: 18px; }
        tr:nth-child(even) { background: #f9f9f9; }
        a.back-link { display: inline-block; margin-bottom: 20px; color: #218c8d; text-decoration: none; font-weight: bold; }
        a.back-link:hover { text-decoration: underline; }
  </style>
</head>
<body>
    <div class="container">
        <a href="adminStudentList.jsp" class="back-link">&larr; Back to Student List</a>
        <h2>Participants for Activity ID: <%= request.getAttribute("activityId") %></h2>
        <table>
            <tr>
              <th>Student ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Course</th>
              <th>Semester</th>
            </tr>
            <%
                List<STUDENT> students = (List<STUDENT>)request.getAttribute("students");
                if (students == null || students.isEmpty()) {
            %>
            <tr><td colspan="5">No students registered for this activity.</td></tr>
            <% } else {
                for (STUDENT s : students) { %>
              <tr>
                <td><%= s.getStudID() %></td>
                <td><%= s.getStudName() %></td>
                <td><%= s.getStudEmail() %></td>
                <td><%= s.getStudCourse() %></td>
                <td><%= s.getStudSemester() %></td>
              </tr>
            <% } } %>
        </table>
    </div>
</body>
</html> 
