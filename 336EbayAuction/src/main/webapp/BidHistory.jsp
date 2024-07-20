<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Timestamp, java.time.LocalDateTime, java.time.LocalDate"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Bid History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .no-bids {
            font-style: italic;
            color: #888;
        }
    </style>
</head>
<body>
    <button onclick="window.location.href='BrowseItems.jsp'">Back</button>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String item_id = request.getParameter("item_id");

    // Validate username and password
    ApplicationDB db = new ApplicationDB();
    conn = db.getConnection();
	
    String bidHistoryQuery = "SELECT u.username, b.item_id, b.time, b.bid_amount FROM bid b JOIN users u ON b.user_id = u.user_id WHERE b.item_id = ? ORDER BY b.time DESC";

    try {
        pstmt = conn.prepareStatement(bidHistoryQuery);
        pstmt.setString(1, item_id);
        rs = pstmt.executeQuery();

        // Check if there are any bids
        if (rs.next()) {
%>
            <table>
                <tr>
                    <th>Username</th>
                    <th>Item ID</th>
                    <th>Time</th>
                    <th>Bid Amount</th>
                </tr>
<%
            do {
                String username = rs.getString("username");
                int itemId = rs.getInt("item_id");
                Timestamp time = rs.getTimestamp("time");
                double bidAmount = rs.getDouble("bid_amount");
%>
                <tr>
                    <td><%= username %></td>
                    <td><%= itemId %></td>
                    <td><%= time %></td>
                    <td>$<%= bidAmount %></td>
                </tr>
<%
            } while (rs.next());
%>
            </table>
<%
        } else {
%>
            <p class="no-bids">No bids have been placed for this item yet.</p>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database connection and statements
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
