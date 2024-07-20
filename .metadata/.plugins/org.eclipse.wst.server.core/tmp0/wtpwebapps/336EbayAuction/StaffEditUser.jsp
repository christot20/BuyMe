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
            String userId = request.getParameter("userId");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Construct the SQL query
            String updateUser = "UPDATE users SET username = ?, password = ? WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(updateUser);

            // Set parameters
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, userId);

            // Execute the query
            ps.executeUpdate();

            // Close the connection
            con.close();
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        // Redirect back to AdminManageUsers.jsp
        response.sendRedirect("StaffManageUsers.jsp");
%>
</body>
</html>
