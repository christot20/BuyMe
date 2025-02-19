<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* Add styles for the popup form and overlay */
    .overlay {
        position: fixed;
        display: none;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0,0,0,0.5);
        z-index: 2;
        cursor: pointer;
    }

    .user-form-popup {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #fff;
        padding: 20px;
        width: 300px;
        z-index: 9;
    }

    /* Add styles for the close button */
    .close-btn {
        position: absolute;
        right: 10px;
        top: 10px;
        font-size: 18px;
        cursor: pointer;
    }
</style>
<script>
    function editUser(userId, username, password) {
        document.getElementById('editFormOverlay').style.display='block';
        document.getElementById('editUsername').value = username;
        document.getElementById('editPassword').value = password;
        document.getElementById('editUserId').value = userId;
    }
</script>
</head>
<body>
    <button onclick="window.location.href='StaffMode.jsp'">Back to Main Menu</button>

    <div id="editFormOverlay" class="overlay" onclick="if (event.target == this) this.style.display='none'">
	    <div class="user-form-popup">
	        <span class="close-btn" onclick="document.getElementById('editFormOverlay').style.display='none'">�</span>
	        <form action="StaffEditUser.jsp" method="post">
	            <input type="hidden" id="editUserId" name="userId">
	            <label for="editUsername">Username:</label><br>
	            <input type="text" id="editUsername" name="username" required><br>
	            <label for="editPassword">Password:</label><br>
	            <input type="text" id="editPassword" name="password" required><br>
	            <input type="submit" value="Submit">
	        </form>
	    </div>
	</div>

	<table>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Action</th>
        </tr>
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Construct the base SQL query
            String baseQuery = "SELECT user_id, username, password FROM users WHERE username != 'Admin'";

            PreparedStatement ps = con.prepareStatement(baseQuery);
            
            ResultSet result = ps.executeQuery();
            

            while (result.next()) { %>
                <tr>
                    <td><%= result.getString("user_id") %></td>
                    <td><%= result.getString("username") %></td>
                    <td>
                        <button onclick="editUser('<%= result.getString("user_id") %>', '<%= result.getString("username") %>', '<%= result.getString("password") %>')">Edit User</button>
                    </td>
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
