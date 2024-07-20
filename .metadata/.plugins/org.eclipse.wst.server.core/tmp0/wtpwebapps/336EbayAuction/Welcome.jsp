<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
//not necessary but will improve readability down the line.
//alternatively, I was thinking of making this into a function. 
boolean is_logged_in = false;
if (session.getAttribute("user_id") != null) {
	is_logged_in = true;
}
%>
<html>
<head>
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
        }
        button:hover {
            background-color: #0056b3;
        }
        .description {
		    max-width: 800px; /* Adjust the width as needed */
		    margin: 0 auto; /* Center the content horizontally */
		}
		
		#additionalButtons {
    		display: flex;
    		justify-content: center;
		}

		#additionalButtons button {
   		 	margin: 0 5px; /* Adjust as needed */
   			padding: 10px 20px;
		}

            
        }
        
    </style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to BuyMe</title>
</head>
<body>
	
	<header>
        <h1>Welcome to BuyMe - Your Online Auction System</h1>
    </header>
    <% if (!is_logged_in) { %>
    
    <main>
        <section>
		    <h2>Welcome to BuyMe - Your Ultimate Auction Destination</h2>
		    <div class="description">
		        <p>BuyMe is your premier online auction system, revolutionizing the way you buy and sell goods. With a user-friendly interface and robust features, BuyMe empowers users to bid on a wide range of items, from electronics to collectibles, and everything in between. Whether you're a seasoned bidder or a first-time buyer, BuyMe provides a seamless experience, connecting buyers and sellers worldwide. Say goodbye to traditional shopping constraints and hello to endless possibilities with BuyMe, where every bid brings you closer to your desired treasures. Join us today and embark on an exciting journey of discovery and acquisition.</p>
		    </div>
		</section>

        <section>
            <h2>Get Started</h2>
            <p>Explore the features of BuyMe:</p>
            <button onclick="window.location.href='browse_items.jsp'">Browse Items</button>
            <button onclick="window.location.href='Login.jsp'">Login</button>
            <button onclick="window.location.href='Login.jsp'">Register</button>

            <!-- Add more buttons for additional actions -->
        </section>
    </main>
	
	<% } else { %>
		<body>
    
    <main>
        <section>
            <h2>Welcome back, <% out.print(session.getAttribute("username")); %>!</h2>
            <p>What would you like to do today?</p>
        </section>
         <section>
            <h2>Explore BuyMe</h2>
            <p>Check out the features:</p>
            <button onclick="window.location.href='BrowseItems.jsp'">Browse Items</button>
            <button onclick="window.location.href='NewAuction.jsp'">Create New Auction</button>
            <button onclick="window.location.href='view_bids.jsp'">View Bids</button>
            <button onclick="window.location.href='edit_profile.jsp'">Edit Profile</button>
            <button onclick="window.location.href='logout.jsp'">Logout</button>
            <!-- Add more buttons for additional actions -->
        </section>
        <section id="additionalButtons">
			<button onclick="window.location.href='UsersQuestions.jsp'">Have A Question?</button>   
			<button onclick="window.location.href='Messages.jsp'">View Messages</button>        
			<button onclick="window.location.href='FAQ.jsp'">FAQ</button>
    </main>
    <% } %>
    <footer>
        <p>&copy; 2024 BuyMe - All rights reserved</p>
    </footer>
</body>
	
	
	
</body>
</html>
