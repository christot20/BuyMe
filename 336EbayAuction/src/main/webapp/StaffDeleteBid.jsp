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
        String bidId = request.getParameter("bidId");

        // Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Construct the SQL DELETE query
        String deleteBidQuery = "DELETE FROM bid WHERE bid_id = ?";
        PreparedStatement ps = con.prepareStatement(deleteBidQuery);

        // Set the userId parameter
        ps.setString(1, bidId);

        // Execute the query
        ps.executeUpdate();

        // Close the connection
        con.close();
    } catch (SQLException e) {
        out.print(e);
    }
	response.sendRedirect("StaffManageBids.jsp");
%>
</body>
</html>
