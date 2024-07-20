<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Computer Auctions</title>
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .product {
            margin-bottom: 20px;
        }
        .product-details {
            border: 1px solid #ccc;
            padding: 10px;
        }
        .product img {
            max-width: 100px;
            max-height: 100px;
            margin-right: 10px;
            float: left;
        }
        .bid-form {
            clear: both;
        }
        .bid-history-button {
            float: right;
        }
    </style>
</head>
<body>
    <button onclick="window.location.href='Welcome.jsp'">Back</button>

    <div class="container">
        <h1>Computer Auctions</h1>
        <% 
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            boolean expiredItemsExist = false; // Flag to check if there are any expired items
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                // Validate username and password
                ApplicationDB db = new ApplicationDB();
                conn = db.getConnection();
                
                stmt = conn.prepareStatement("SELECT * FROM Computers");
                rs = stmt.executeQuery();
                while (rs.next()) {
                    int item_id = rs.getInt("item_id");
                    String name = rs.getString("name");
                    String computer_type = rs.getString("computer_type");
                    double initial_price = rs.getDouble("initial_price");
                    double current_bid = rs.getDouble("current_bid");
                    Timestamp expiration_date = rs.getTimestamp("expiration_date"); // Retrieve expiration date from database
                    String imageFilename = "Images/" + computer_type.toLowerCase() + ".png"; // Assuming images are stored in a folder named "images"
                    String current_top_bidder = rs.getString("current_top_bidder");
	
                    
                    
                    // Check if item is expired
                    if (!expiration_date.toLocalDateTime().isAfter(LocalDateTime.now())) {
                        
                    	
                    	
                    	String messageWinner = "INSERT INTO Messages (user_id, message, time) VALUES (?, ?, ?)";
                    	PreparedStatement ps = conn.prepareStatement(messageWinner);
                    	ps.setString(1, current_top_bidder); // Assuming current_top_bidder is the user_id
                    	ps.setString(2, "Congrats! You won item " + name); // Message
                    	ps.setObject(3, LocalDateTime.now()); // Current time

                    	ps.executeUpdate();


                    	
                    	/*
                    	
                    	Don't use this, we still need to have the bid in the DB for when we show bids a user has participated in
                    	String deleteCurrentEntrySQL = "DELETE FROM Computers WHERE item_id = ?";
                    	PreparedStatement deleteStatement = conn.prepareStatement(deleteCurrentEntrySQL);
                    	deleteStatement.setInt(1, item_id);
                    	deleteStatement.executeUpdate();
                    	
                    	*/
                    	
                    	
                        continue; // Skip this item
                    }
                    
                   
                    

                    
        %>
        <div class="product">
            <div class="product-details">
                <img src="<%=imageFilename%>" alt="<%=computer_type%>">
                <h2><%=name%></h2>
                <p>Type: <%=computer_type%></p>
                <p>Initial Price: $<%=initial_price%></p>
                <p>Current Bid: $<%=current_bid%></p>
                <p>End Date: <%=expiration_date%></p> <!-- Display expiration date -->
                <div class="bid-form">
                    <form action="PlaceBid.jsp" method="post">
                        <input type="hidden" name="item_id" value="<%=item_id%>">
                        <label for="bid_amount">Your Bid:</label>
                        <input type="number" name="bid_amount" id="bid_amount" step="0.01" required>
                        <button type="submit">Place Bid</button>
                    </form>
                    <form action="BidHistory.jsp" method="post">
                        <input type="hidden" name="item_id" value="<%=item_id%>">
                        <button class="bid-history-button" type="submit">Bid History</button>
                    </form>
                </div>
            </div>
        </div>
        <% 
                }
                
                // Redirect to ItemExpired.jsp if there are any expired items
                
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
