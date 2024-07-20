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
String item_id = request.getParameter("item_id");
int user_id = (Integer) session.getAttribute("user_id");
String bid_amount = request.getParameter("bid_amount");
int bid_amount_int = Integer.parseInt(bid_amount);

LocalDate time = LocalDate.now();

// Create a timestamp for the current time
Timestamp timestamp = Timestamp.valueOf(LocalDateTime.now());

// Define SQL query to insert bid into Bids table
String insertBidSQL = "INSERT INTO Bid(item_id, user_id, time, bid_amount) VALUES (?, ?, ?, ?)";
String getCurrentBidSQL = "SELECT current_bid, initial_price FROM Computers WHERE item_id = ?";
String updateCurrentBidSQL = "UPDATE Computers SET current_bid = ?, current_top_bidder = ? WHERE item_id = ?";

try {
    // Check if the new bid is higher than the current highest bid
    pstmt = conn.prepareStatement(getCurrentBidSQL);
    pstmt.setString(1, item_id);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        double currentHighestBid = rs.getDouble("current_bid");
        double initialPrice = rs.getDouble("initial_price");

        // Check if bid amount is higher than current highest bid and initial price
        if (bid_amount_int > currentHighestBid && bid_amount_int >= initialPrice) {
            // Check expiration date of the item
            String getExpirationDateSQL = "SELECT expiration_date FROM Computers WHERE item_id = ?";
            pstmt = conn.prepareStatement(getExpirationDateSQL);
            pstmt.setString(1, item_id);
            ResultSet expirationDateResult = pstmt.executeQuery();

            if (expirationDateResult.next()) {
                Timestamp expirationTimestamp = expirationDateResult.getTimestamp("expiration_date");

                // Compare current time with expiration time
                Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
                if (currentTimestamp.before(expirationTimestamp)) {
                    // Proceed with placing the bid
                    pstmt = conn.prepareStatement(insertBidSQL, Statement.RETURN_GENERATED_KEYS);
                    pstmt.setString(1, item_id);
                    pstmt.setInt(2, user_id);
                    pstmt.setTimestamp(3, currentTimestamp);
                    pstmt.setInt(4, bid_amount_int);

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

    response.sendRedirect("BrowseItems.jsp");
} catch (Exception e) {
    e.printStackTrace();
    // Handle any exceptions here
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
