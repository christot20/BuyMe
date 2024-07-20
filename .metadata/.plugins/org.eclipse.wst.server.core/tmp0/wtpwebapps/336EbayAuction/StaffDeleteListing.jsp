<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Item</title>
</head>
<body>
<%
    try {
        // Get the itemId from the query parameters
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        // Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Construct the SQL DELETE query
        String deleteItemQuery = "DELETE FROM Computers WHERE item_id = ?";
        PreparedStatement ps = con.prepareStatement(deleteItemQuery);

        // Set the itemId parameter
        ps.setInt(1, itemId);

        // Execute the query
        int rowsAffected = ps.executeUpdate();

        // Close the connection
        con.close();

        if (rowsAffected > 0) {
            out.print("Item deleted successfully.");
        } else {
            out.print("No item found with the provided ID.");
        }
    } catch (SQLException e) {
        out.print("Database error: " + e.getMessage());
    }

    // Redirect back to AdminManageListings.jsp
    response.sendRedirect("StaffManageListings.jsp");
%>
</body>
</html>
