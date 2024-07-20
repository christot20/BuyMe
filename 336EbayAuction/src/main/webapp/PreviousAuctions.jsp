<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Computer Auction History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        h1 {
            text-align: center;
            margin-top: 20px;
        }
        form {
            margin-bottom: 20px;
            text-align: center;
        }
        form input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
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
    <h1>Computer Auction History</h1>
    <form action="Welcome.jsp">
        <input type="submit" value="Main Menu">
    </form>

    <form action="SortComputers.jsp" method="post">
        <label for="sortOption">Sort by:</label>
        <select id="sortOption" name="sortOption">
            <option value="none">None</option>
            <option value="name">Name</option>
            <option value="computer_type">Computer Type</option>
            <option value="ram">RAM</option>
            <option value="storage">Storage</option>
            <option value="cpu">CPU</option>
            <option value="list_date">List Date</option>
            <option value="expiration_date">Expiration Date</option>
            <option value="current_top_bidder">Top Bidder</option>
        </select>
        <input type="submit" value="Sort">
    </form>

    <form action="FilterComputers.jsp" method="get">
        <label for="computerTypeFilter">Computer Type:</label>
        <select id="computerTypeFilter" name="computerTypeFilter">
            <option value="">All</option>
            <option value="Laptop">Laptop</option>
            <option value="Desktop">Desktop</option>
            <option value="All in One">All in One</option>
        </select>

        <label for="ramFilter">RAM:</label>
        <select id="ramFilter" name="ramFilter">
            <option value="">All</option>
            <option value="8">8GB</option>
            <option value="16">16GB</option>
            <option value="32">32GB</option>
        </select>

        <label for="storageFilter">Storage:</label>
        <select id="storageFilter" name="storageFilter">
            <option value="">All</option>
            <option value="256">256GB</option>
            <option value="512">512GB</option>
            <option value="1024">1TB</option>
        </select>

        <label for="cpuFilter">CPU:</label>
        <select id="cpuFilter" name="cpuFilter">
            <option value="">All</option>
            <option value="Intel">Intel</option>
            <option value="Ryzen">Ryzen</option>
        </select>

        <label for="topBidderFilter">Top Bidder:</label>
        <input type="text" id="topBidderFilter" name="topBidderFilter">

        <input type="submit" value="Apply Filter">
    </form>

    <table>
        <tr>
            <th>Name</th>
            <th>Computer Type</th>
            <th>RAM</th>
            <th>Storage</th>
            <th>CPU</th>
            <th>List Date</th>
            <th>Expiration Date</th>
            <th>Top Bidder</th>
        </tr>
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Create a SQL statement
            Statement stmt = con.createStatement();
            String str = "SELECT name, computer_type, ram, storage, cpu, list_date, expiration_date, current_top_bidder " +
                         "FROM computers WHERE isFinished = 1"; // Retrieve finished auctions

            // Apply filters if provided
            String computerTypeFilter = request.getParameter("computerTypeFilter");
            String ramFilter = request.getParameter("ramFilter");
            String storageFilter = request.getParameter("storageFilter");
            String cpuFilter = request.getParameter("cpuFilter");
            String topBidderFilter = request.getParameter("topBidderFilter");

            if (computerTypeFilter != null && !computerTypeFilter.isEmpty()) {
                str += " AND computer_type = '" + computerTypeFilter + "'";
            }
            if (ramFilter != null && !ramFilter.isEmpty()) {
                str += " AND ram = " + ramFilter;
            }
            if (storageFilter != null && !storageFilter.isEmpty()) {
                str += " AND storage = " + storageFilter;
            }
            if (cpuFilter != null && !cpuFilter.isEmpty()) {
                str += " AND cpu LIKE '%" + cpuFilter + "%'";
            }
            if (topBidderFilter != null && !topBidderFilter.isEmpty()) {
                str += " AND current_top_bidder LIKE '%" + topBidderFilter + "%'";
            }

            ResultSet result = stmt.executeQuery(str);

            // Parse out the results
            while (result.next()) { %>
                <tr>
                    <td><%= result.getString("name") %></td>
                    <td><%= result.getString("computer_type") %></td>
                    <td><%= result.getString("ram") %>GB</td>
                    <td><%= result.getString("storage") %>GB</td>
                    <td><%= result.getString("cpu") %></td>
                    <td><%= result.getString("list_date") %></td>
                    <td><%= result.getString("expiration_date") %></td>
                    <td><%= result.getString("current_top_bidder") %></td>
                </tr>
            <% }
            // Close the connection.
            db.closeConnection(con);
        } catch (Exception e) {
            out.print(e);
        } %>
    </table>
</body>
</html>
