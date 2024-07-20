<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to BuyMe Staff Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px 0;
        }
        main {
            padding: 20px;
            text-align: center;
        }
        section {
            margin-bottom: 20px;
        }
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin: 5px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to BuyMe Staff Portal</h1>
    </header>
    <main>
        <section>
            <h2>Welcome back, <% out.print(session.getAttribute("username")); %>!</h2>
            <p>What would you like to do today?</p>
        </section>
        <section>
            <h2>Staff Functions</h2>
            <p>Choose from the following options:</p>
            <button onclick="window.location.href='StaffManageUsers.jsp'">Manage Users</button>
            <button onclick="window.location.href='StaffManageListings.jsp'">Manage Listings</button>
            <button onclick="window.location.href='StaffManageBids.jsp'">Manage Bids</button>
            <button onclick="window.location.href='Questions.jsp'">Answer Questions</button>
            <button onclick="window.location.href='logout.jsp'">Logout</button>
            <!-- Add more buttons for additional staff functionalities -->
        </section>
    </main>
    <footer>
        <p>&copy; 2024 BuyMe - All rights reserved</p>
    </footer>
    
</body>
</html>
