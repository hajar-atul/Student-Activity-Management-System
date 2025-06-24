<%@ page import="java.io.File, java.io.FileInputStream, java.io.OutputStream" %>
<%@ page import="java.sql.*" %>
<%
    String reportIdStr = request.getParameter("reportID");
    int reportId = 0;
    String filePath = null;
    if (reportIdStr != null && !reportIdStr.isEmpty()) {
        reportId = Integer.parseInt(reportIdStr);
    }
    if (reportId > 0) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC", "root", "");
            PreparedStatement stmt = conn.prepareStatement("SELECT filePath FROM report WHERE reportID=?");
            stmt.setInt(1, reportId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                filePath = rs.getString("filePath");
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
    if (filePath != null) {
        String absolutePath = application.getRealPath("/" + filePath);
        File file = new File(absolutePath);
        if (file.exists()) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=report_" + reportId + ".pdf");
            try (FileInputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
            }
            return;
        }
    }
%>
<!DOCTYPE html>
<html><body><h2>File not found.</h2></body></html> 