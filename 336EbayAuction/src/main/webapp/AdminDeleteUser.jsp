<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete User</title>
</head>
<body>
<%
    try {
        // Get the userId from the query parameters
        String userId = request.getParameter("userId");

        // Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Construct the SQL DELETE query
        String deleteUserQuery = "DELETE FROM users WHERE user_id = ?";
        PreparedStatement ps = con.prepareStatement(deleteUserQuery);

        // Set the userId parameter
        ps.setString(1, userId);

        // Execute the query
        ps.executeUpdate();

        // Close the connection
        con.close();
    } catch (SQLException e) {
        out.print(e);
    }
	response.sendRedirect("AdminManageUsers.jsp");
%>
</body>
</html>
