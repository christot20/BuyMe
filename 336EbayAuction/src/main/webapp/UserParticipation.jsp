<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Participation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">User Participation</h1>
    <table>
    <tr>
        <th>Item Name</th>
        <th>Bid Amount</th>
        <th>Bid Time</th>
        <th>Bidder</th> <!-- New header for the username -->
    </tr>
    <% 
    // Retrieve user ID from session
    Integer userId = (Integer)session.getAttribute("user_id");
    if (userId != null) {
        try {
            // Get database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Prepare SQL to fetch bid details
            String sql = "SELECT c.name, b.bid_amount, b.time, u.username FROM bid b JOIN computers c ON b.item_id = c.item_id JOIN users u ON b.user_id = u.user_id WHERE b.user_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            // Execute query
            ResultSet rs = ps.executeQuery();

            // Display results
            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getDouble("bid_amount") %></td>
                    <td><%= rs.getTimestamp("time").toString() %></td>
                    <td><%= rs.getString("username") %></td> <!-- Display the username -->
                </tr>
                <%
            }
            // Close connections
            rs.close();
            ps.close();
            db.closeConnection(con);
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    } else {
        out.println("<p style='text-align:center;'>User not logged in.</p>");
    }
    %>
</table>
    
</body>
</html>
