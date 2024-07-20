<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Auction</title>
</head>
<body>
    <h1>Create a New Auction</h1>
    <form action="AddAuction.jsp" method="post">

        <label for="itemName">Item Name:</label>
        <input type="text" id="itemName" name="itemName" required><br>
        
        <label for="itemType">Item Type (Laptop, Desktop, All-In-One):</label>
        <select id="itemType" name="itemType" required>
            <option value="LAPTOP">Laptop</option>
            <option value="DESKTOP">Desktop</option>
            <option value="ALLINONE">All-In-One</option>
        </select><br>
        
        <label for="ram">RAM:</label>
        <select id="ram" name="ram" required>
            <option value="8">8 GB</option>
            <option value="16">16 GB</option>
            <option value="24">24 GB</option>
            <option value="32">32 GB</option>
            <option value="64">64 GB</option>
            <option value="128">128 GB</option>
        </select><br>
        
        <label for="storage">Storage (in GB--if 1TB+ enter the equivalent in GB (1000+ GB)):</label>
        <input type="number" id="storage" name="storage"><br>
        
        <label for="cpu">CPU:</label>
        <select id="cpu" name="cpu" required>
            <option value="AMD Ryzen 3">AMD Ryzen 3</option>
            <option value="AMD Ryzen 5">AMD Ryzen 5</option>
            <option value="AMD Ryzen 7">AMD Ryzen 7</option>
            <option value="AMD Ryzen 9">AMD Ryzen 9</option>
            <option value="Intel I3">Intel I3</option>
            <option value="Intel I7">Intel I7</option>
            <option value="Intel I9">Intel I9</option>
        </select><br>

        <label for="startingBid">Starting Bid:</label>
        <input type="number" id="startingBid" name="startingBid" min="0" value="0"><br>
        
        <label for="reserve">Reserve:</label>
        <input type="number" id="startingBid" name="reserve" min="0" value="0"><br>

        <label for="auctionListDate">Auction List Date (at least today):</label>
        <input type="datetime-local" id="auctionListDate" name="auctionListDate" min="<%= java.time.LocalDateTime.now() %>" required><br>

        <label for="expirationDate">Expiration Date (cannot be earlier than Auction List Date):</label>
        <input type="datetime-local" id="expirationDate" name="expirationDate" min="<%= java.time.LocalDateTime.now() %>" required><br>
        
        <input type="submit" value="Create Auction">
    </form>
    <br>
    <a href="Welcome.jsp"><button>Back to Main Menu</button></a>
</body>
</html>
