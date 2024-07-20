<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sales Reports</title>
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
    
    <button onclick="window.location.href='AdminMode.jsp'">Back</button>
    
    <h1 style="text-align: center;">Sales Reports</h1>
    
    <!-- Database connection setup -->
    <% 
    ApplicationDB db = new ApplicationDB(); 
    Connection con = db.getConnection();
    Statement stmt = null;
    ResultSet rs = null;
    try {
        stmt = con.createStatement();

        // Total Earnings
        %>
        <h2>Total Earnings</h2>
        <table>
            <tr>
                <th>Total Earnings</th>
            </tr>
            <% 
            String totalEarningsQuery = "SELECT SUM(current_bid) AS total FROM computers WHERE isFinished = 1";
            rs = stmt.executeQuery(totalEarningsQuery);
            if (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getDouble("total") %></td>
                </tr>
                <%
            }
            %>
        </table>

        
        <h2>Earnings Per Item</h2>
        <table>
            <tr>
                <th>Item Name</th>
                <th>Earnings</th>
            </tr>
            <% 
            String earningsPerItemQuery = "SELECT name, current_bid FROM computers WHERE isFinished = 1";
            rs = stmt.executeQuery(earningsPerItemQuery);
            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getDouble("current_bid") %></td>
                </tr>
                <%
            }
            %>
        </table>

        
        <h2>Earnings Per Item Type</h2>
        <table>
            <tr>
                <th>Item Type</th>
                <th>Earnings</th>
            </tr>
            <% 
            String earningsPerItemTypeQuery = "SELECT computer_type, SUM(current_bid) AS earnings FROM computers WHERE isFinished = 1 GROUP BY computer_type";
            rs = stmt.executeQuery(earningsPerItemTypeQuery);
            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("computer_type") %></td>
                    <td><%= rs.getDouble("earnings") %></td>
                </tr>
                <%
            }
            %>
        </table>

        
        <h2>Earnings Per End-User</h2>
        <table>
            <tr>
                <th>User</th>
                <th>Total Spent</th>
            </tr>
            <% 
            String earningsPerUserQuery = "SELECT u.username, SUM(b.bid_amount) AS total_spent FROM users u JOIN bid b ON u.user_id = b.user_id JOIN computers c ON b.item_id = c.item_id WHERE c.isFinished = 1 GROUP BY u.username";
            rs = stmt.executeQuery(earningsPerUserQuery);
            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getDouble("total_spent") %></td>
                </tr>
                <%
            }
            %>
        </table>

        
        <h2>Best-Selling Items</h2>
        <table>
            <tr>
                <th>Item Name</th>
                <th>Earnings</th>
            </tr>
            <% 
            String bestSellingItemsQuery = "SELECT name, current_bid FROM computers WHERE isFinished = 1 ORDER BY current_bid DESC LIMIT 5";
            rs = stmt.executeQuery(bestSellingItemsQuery);
            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getDouble("current_bid") %></td>
                </tr>
                <%
            }
            %>
        </table>

        
        <h2>Best Buyers</h2>
        <table>
            <tr>
                <th>User</th>
                <th>Total Spent</th>
            </tr>
            <% 
            String bestBuyersQuery = "SELECT u.username, SUM(b.bid_amount) AS total_spent FROM users u JOIN bid b ON u.user_id = b.user_id JOIN computers c ON b.item_id = c.item_id WHERE c.isFinished = 1 GROUP BY u.username ORDER BY SUM(b.bid_amount) DESC LIMIT 5";
            rs = stmt.executeQuery(bestBuyersQuery);
            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getDouble("total_spent") %></td>
                </tr>
                <%
            }
            %>
        </table>
        <%
        } catch (SQLException e) {
            out.println("Error retrieving data: " + e.getMessage());
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) {
                    out.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) {
                    out.println("Error closing Statement: " + e.getMessage());
                }
            }
            if (con != null) {
                db.closeConnection(con); // Assuming db.closeConnection() handles its own exceptions
            }
        }
        %>
</body>
</html>
