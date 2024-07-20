<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Timestamp, java.time.LocalDateTime, java.time.LocalDate"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
</head>
<body>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String username = request.getParameter("username");
String password = request.getParameter("password");

// Validate username and password
ApplicationDB db = new ApplicationDB();
conn = db.getConnection();

// Get parameters from the form
String item_name = request.getParameter("item_name");
String item_id = request.getParameter("item_id");
int user_id = (Integer) session.getAttribute("user_id");
String bid_amount = request.getParameter("bid_amount");
int bid_amount_int = Integer.parseInt(bid_amount);
String auto_bid = request.getParameter("autobid");
int auto_bid_int = "yes".equals(auto_bid) ? 1 : 0; // Convert auto_bid to integer
String bid_increment = request.getParameter("bid_increment");
String max_bid = request.getParameter("upper_limit");

LocalDate time = LocalDate.now();

// Create a timestamp for the current time
Timestamp timestamp = Timestamp.valueOf(LocalDateTime.now());

// Define SQL query to insert bid into Bids table
String insertBidSQL = "INSERT INTO Bid(item_id, user_id, time, bid_amount, auto_bid, bid_increment, max_bid) VALUES (?, ?, ?, ?, ?, ?, ?)";
String getCurrentBidSQL = "SELECT current_bid, initial_price, bid_id FROM Computers WHERE item_id = ?";
String updateCurrentBidSQL = "UPDATE Computers SET current_bid = ?, current_top_bidder = ? WHERE item_id = ?";
String findUsersThatBidSQL = "SELECT user_id, bid_amount FROM bid WHERE item_id = ? AND user_id != ? AND bid_amount < ?";
String notifyUsersOfOutbidSQL = "INSERT INTO messages (user_id, message, time) VALUES (?, ?, ?)";

try {
    // Check if the new bid is higher than the current highest bid
    pstmt = conn.prepareStatement(getCurrentBidSQL);
    pstmt.setString(1, item_id);
    rs = pstmt.executeQuery();

    double currentHighestBid = 0;
    double initialPrice = 0;
    int currentBidId = 0;

    if (rs.next()) {
        currentHighestBid = rs.getDouble("current_bid");
        initialPrice = rs.getDouble("initial_price");
        currentBidId = rs.getInt("bid_id");

        if (bid_amount_int > currentHighestBid && bid_amount_int >= initialPrice) {
            String getExpirationDateSQL = "SELECT expiration_date FROM Computers WHERE item_id = ?";
            pstmt = conn.prepareStatement(getExpirationDateSQL);
            pstmt.setString(1, item_id);
            ResultSet expirationDateResult = pstmt.executeQuery();

            if (expirationDateResult.next()) {
                Timestamp expirationTimestamp = expirationDateResult.getTimestamp("expiration_date");

                Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
                if (currentTimestamp.before(expirationTimestamp)) {
                    pstmt = conn.prepareStatement(insertBidSQL, Statement.RETURN_GENERATED_KEYS);
                    pstmt.setString(1, item_id);
                    pstmt.setInt(2, user_id);
                    pstmt.setTimestamp(3, currentTimestamp);
                    pstmt.setInt(4, bid_amount_int);
                    pstmt.setInt(5, auto_bid_int); // Use the integer value of auto_bid
                    pstmt.setString(6, bid_increment);
                    pstmt.setString(7, max_bid);

                    // Execute the insert query
                    int affectedRows = pstmt.executeUpdate();

                    if (affectedRows > 0) {
                        // Retrieve the generated keys and update current bid
                        ResultSet generatedKeys = pstmt.getGeneratedKeys();
                        if (generatedKeys.next()) {
                            int generatedBidId = generatedKeys.getInt(1);

                            // Update the current bid in the Computers table
                            pstmt = conn.prepareStatement(updateCurrentBidSQL);
                            pstmt.setInt(1, bid_amount_int);
                            pstmt.setInt(2, user_id); // Set the current top bidder
                            pstmt.setString(3, item_id);
                            pstmt.executeUpdate();
                            
                            pstmt = conn.prepareStatement(findUsersThatBidSQL);
                            pstmt.setString(1, item_id);
                            pstmt.setInt(2, user_id);
                            pstmt.setInt(3, bid_amount_int);
                            ResultSet usersThatBidResult = pstmt.executeQuery();
                            		
                            while(usersThatBidResult.next()) {
                            	int user_that_bid_id = usersThatBidResult.getInt("user_id");
                            	double last_bid_amount = usersThatBidResult.getDouble("bid_amount");
                            	double diff = bid_amount_int - last_bid_amount;
                            	
                            	pstmt = conn.prepareStatement(notifyUsersOfOutbidSQL);
                            	pstmt.setInt(1, user_that_bid_id);
                            	pstmt.setString(2, "You have been outbid on item " + item_name + ".");
                            	pstmt.setTimestamp(3, currentTimestamp);
                            	pstmt.executeUpdate();
                            }
                        }
                    }
                } else {
                    // Handle the case where the auction has expired
                    // For example, redirect the user back with an error message
                    response.sendRedirect("BidError.jsp?error=expired");
                }
            }
        } else {
            // Handle the case where the bid is not higher than the current highest bid or below the initial price
            // For example, redirect the user back with an error message
            response.sendRedirect("BidError.jsp?error=invalid");
        }
    }

    // Check if there are any autobidders for this item
    if (auto_bid_int == 1) {
        String getAutobiddersSQL = "SELECT user_id, max_bid, bid_increment FROM (SELECT DISTINCT user_id, max_bid, bid_increment FROM Bid WHERE item_id = ? AND auto_bid = 1 ORDER BY max_bid DESC LIMIT 2) AS highest_bids"; // Use 1 for 'yes'
        pstmt = conn.prepareStatement(getAutobiddersSQL);
        pstmt.setString(1, item_id);
        rs = pstmt.executeQuery();

        // Count the number of rows in the result set
        int rowCount = 0;
        while (rs.next()) {
            rowCount++;
        }

        // If there's only one autobidder, skip the calculation and insertion
        if (rowCount == 1) {
            // Redirect or perform any other action here if needed
        } else {
            double highestBidLimit = 0;
            double secondHighestBidLimit = 0;

            if (rs.first()) {
                highestBidLimit = rs.getDouble("max_bid");
                if (rs.next()) {
                    secondHighestBidLimit = rs.getDouble("max_bid");
                }
            }

            // Calculate bid amount to be placed
            double newBidAmount = secondHighestBidLimit + Double.parseDouble(bid_increment);

            // Check if the new bid amount exceeds the highest bid limit
            if (newBidAmount > highestBidLimit) {
                newBidAmount = highestBidLimit;
            }
			
            
            
            // Place a new bid
            pstmt = conn.prepareStatement(insertBidSQL, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, item_id);
            pstmt.setInt(2, user_id);
            pstmt.setTimestamp(3, timestamp);
            pstmt.setDouble(4, newBidAmount);
            pstmt.setInt(5, auto_bid_int); // Use the integer value of auto_bid
            pstmt.setString(6, bid_increment);
            pstmt.setString(7, max_bid);

            // Execute the insert query
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                // Retrieve the generated keys and update current bid
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int generatedBidId = generatedKeys.getInt(1);

                    // Update the current bid in the Computers table
                    pstmt = conn.prepareStatement(updateCurrentBidSQL);
                    pstmt.setDouble(1, newBidAmount);
                    pstmt.setInt(2, user_id); // Set the current top bidder
                    pstmt.setString(3, item_id);
                    pstmt.executeUpdate();

                    // Notify users of being outbid
                    pstmt = conn.prepareStatement(findUsersThatBidSQL);
                    pstmt.setString(1, item_id);
                    pstmt.setInt(2, user_id);
                    pstmt.setDouble(3, newBidAmount);
                    ResultSet usersThatBidResult = pstmt.executeQuery();
                    
                    while(usersThatBidResult.next()) {
                        int user_that_bid_id = usersThatBidResult.getInt("user_id");
                        double last_bid_amount = usersThatBidResult.getDouble("bid_amount");
                        double diff = newBidAmount - last_bid_amount;

                        pstmt = conn.prepareStatement(notifyUsersOfOutbidSQL);
                        pstmt.setInt(1, user_that_bid_id);
                        pstmt.setString(2, "You have been outbid on item " + item_name + ".");
                        pstmt.setTimestamp(3, timestamp);
                        pstmt.executeUpdate();
                    }
                }
            }
        }
    }
    response.sendRedirect("BrowseItems.jsp");
} catch (Exception e) {
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
