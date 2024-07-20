<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*, java.sql.*, java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	 <button onclick="window.location.href='Welcome.jsp'">Back</button>
	
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();

        String itemName = request.getParameter("itemName");
        String itemType = request.getParameter("itemType");
        
        float ram = Float.parseFloat(request.getParameter("ram"));
        float storage = Float.parseFloat(request.getParameter("storage"));
        
        String cpu = request.getParameter("cpu");
        
        float startingBid = Float.parseFloat(request.getParameter("startingBid"));

        // Convert date strings to LocalDateTime objects
        LocalDateTime auctionListDate = LocalDateTime.parse(request.getParameter("auctionListDate").replace(" ", "T"));
        LocalDateTime expirationDate = LocalDateTime.parse(request.getParameter("expirationDate").replace(" ", "T"));
		
        
        
        String insertSql = "INSERT INTO computers (name, computer_type, ram, storage, cpu, list_date, expiration_date, initial_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(insertSql);
        ps.setString(1, itemName);
        ps.setString(2, itemType);
        ps.setFloat(3, ram);
        ps.setFloat(4, storage);
        ps.setString(5, cpu);
        ps.setTimestamp(6, Timestamp.valueOf(auctionListDate));
        ps.setTimestamp(7, Timestamp.valueOf(expirationDate));
        ps.setFloat(8, startingBid);

        // Execute the insert statement
        ps.executeUpdate();

        // Close the connection
        con.close();

        // Forward to a success page or display a success message
        response.getWriter().println("Auction added successfully!");
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Error adding auction.");
    }
%>
</body>
</html>
