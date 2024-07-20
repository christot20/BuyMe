<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Computer Listings</title>
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
        form input[type="submit"],
        form input[type="submit"]:hover {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        form select,
        form select:focus {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        form label {
            margin-right: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border: 1px solid #ccc;
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
    <h1>Computer Listings</h1>
    <form action="Welcome.jsp">
        <input type="submit" value="Main Menu">
    </form>

    <form action="SortComputers.jsp" method="post">
        <label for="sortOption">Sort by:</label>
        <select id="sortOption" name="sortOption">
        	<option value="none">None</option>
            <option value="current_bid">Current Bid</option>
            <option value="list_date">List Date</option>
            <option value="expiration_date">Expiration Date</option>
            <option value="computer_type">Computer Type</option>
            <option value="ram">RAM</option>
            <option value="storage">Storage</option>
        </select>
        <input type="submit" value="Sort">
        
        <!-- New filtering dropdowns -->
        <label for="filterComputerType">Computer Type:</label>
        <select id="filterComputerType" name="filterComputerType">
            <option value="all">All</option>
            <option value="LAPTOP">Laptop</option>
            <option value="DESKTOP">Desktop</option>
            <option value="ALLINONE">All in One</option>
        </select>

        <label for="filterPrice">Current Bid:</label>
        <select id="filterPrice" name="filterPrice">
            <option value="all">All</option>
            <option value="500">Current Bid > 500</option>
            <option value="1000">Current Bid > 1000</option>
        </select>

        <label for="filterCpu">CPU:</label>
        <select id="filterCpu" name="filterCpu">
            <option value="all">All</option>
            <option value="%Intel%">Intel</option>
            <option value="%Ryzen%">Ryzen</option>
        </select>
        
        <label for="filterRam">RAM:</label>
        <select id="filterRam" name="filterRam">
            <option value="all">All</option>
            <option value="8">RAM > 8GB</option>
            <option value="16">RAM > 16GB</option>
        </select>
        
        <label for="filterStorage">Storage:</label>
        <select id="filterStorage" name="filterStorage">
            <option value="all">All</option>
            <option value="500">Storage > 500GB</option>
            <option value="1000">Storage > 1 TB</option>
        </select>

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
            <th>Current Bid</th>
        </tr>
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Construct the base SQL query
            String baseQuery = "SELECT name, computer_type, ram, storage, cpu, list_date, expiration_date, current_bid FROM computers where item_id in (select item_id from bid where user_id = ?) and ";

            // Check if filters are applied
            String filterComputerType = request.getParameter("filterComputerType");
            String filterPrice = request.getParameter("filterPrice");
            String filterCpu = request.getParameter("filterCpu");
            String filterRam = request.getParameter("filterRam");
            String filterStorage = request.getParameter("filterStorage");

            // Build the WHERE clause based on filters
            String whereClause = " 1=1"; // Default condition
            if (!"all".equals(filterComputerType)) {
                whereClause += " AND computer_type = '" + filterComputerType + "'";
            }
            if (!"all".equals(filterPrice)) {
                whereClause += " AND current_bid > '" + filterPrice + "'";
            }
            if (!"all".equals(filterCpu)) {
            	whereClause += " AND cpu LIKE '" + filterCpu + "'";
            }
            if (!"all".equals(filterRam)) {
                whereClause += " AND ram > '" + filterRam + "'";
            }
            if (!"all".equals(filterStorage)) {
                whereClause += " AND storage > '" + filterStorage + "'";
            }

            // Construct the final query
            String finalQuery = baseQuery + whereClause;

            // Check if sorting is needed
            String sortOption = request.getParameter("sortOption");
            if (!"none".equals(sortOption)) {
                finalQuery += " ORDER BY " + sortOption;
            }

            // Execute the query
            
            int user_id = (Integer)session.getAttribute("user_id");
            PreparedStatement ps = con.prepareStatement(finalQuery);
            
            ps.setInt(1, user_id);
            
            
            ResultSet result = ps.executeQuery();
            

            while (result.next()) { %>
                <tr>
                    <td><%= result.getString("name") %></td>
                    <td><%= result.getString("computer_type") %></td>
                    <td><%= result.getString("ram") %></td>
                    <td><%= result.getString("storage") %></td>
                    <td><%= result.getString("cpu") %></td>
                    <td><%= result.getString("list_date") %></td>
                    <td><%= result.getString("expiration_date") %></td>
                    <td><%= result.getString("current_bid") %></td>
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
