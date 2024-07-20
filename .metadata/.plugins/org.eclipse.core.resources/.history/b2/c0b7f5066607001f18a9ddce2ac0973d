<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try {
            // Get form data
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            int permissions = Integer.parseInt(request.getParameter("permissions"));

            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Construct the SQL query
            String insertUser = "INSERT INTO users (username, password, permissions) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertUser);

            // Set parameters
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, permissions);

            // Execute the query
            ps.executeUpdate();

            // Close the connection
            con.close();
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        // Redirect back to AdminManageUsers.jsp
        response.sendRedirect("AdminManageUsers.jsp");
%>
</body>
</html>