<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Timestamp, java.time.LocalDateTime, java.time.LocalDate"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>User Messages</title>
    <style>
        table {
            border-collapse: collapse;
            width: 50%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String item_id = request.getParameter("item_id");
    
    // Validate username and password
    ApplicationDB db = new ApplicationDB();
    conn = db.getConnection();
    
    int user_id = (Integer) session.getAttribute("user_id");

    String getMessages = "SELECT message, time FROM Messages WHERE user_id = ?";
    
    try {
        pstmt = conn.prepareStatement(getMessages);
        pstmt.setInt(1, user_id);
        rs = pstmt.executeQuery();
%>

    <h1>User Messages</h1>
    <table>
        <tr>
            <th>Message</th>
            <th>Date</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getString("message") %></td>
            <td><%= rs.getTimestamp("time") %></td>
        </tr>
        <% } %>
    </table>

<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>

</body>
</html>
