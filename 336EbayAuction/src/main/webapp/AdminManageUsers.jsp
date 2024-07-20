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
    function deleteUser(userId) {
        if (confirm('Are you sure you want to delete this user?')) {
            window.location.href = 'AdminDeleteUser.jsp?userId=' + userId;
        }
    }

    function editUser(userId, username, password, permissions) {
        document.getElementById('editFormOverlay').style.display='block';
        document.getElementById('editUsername').value = username;
        document.getElementById('editPassword').value = password;
        document.getElementById('editUserId').value = userId;
        document.getElementById('editPermissions').value = permissions;
    }
</script>
</head>
<body>
    <button onclick="window.location.href='AdminMode.jsp'">Back to Main Menu</button> <!-- Add this line -->

	<button onclick="document.getElementById('userFormOverlay').style.display='block'">Add User</button>
	
    <div id="userFormOverlay" class="overlay" onclick="if (event.target == this) this.style.display='none'">
        <div class="user-form-popup">
            <span class="close-btn" onclick="document.getElementById('userFormOverlay').style.display='none'">�</span>
            <form action="AdminAddUser.jsp" method="post">
                <label for="username">Username:</label><br>
                <input type="text" id="username" name="username" required><br>
                <label for="password">Password:</label><br>
                <input type="password" id="password" name="password" required><br>
                <label for="permissions">Permissions:</label><br>
                <select id="permissions" name="permissions" required>
                    <option value="0">0</option>
                    <option value="1">1</option>
                </select><br>
                <input type="submit" value="Submit">
            </form>
        </div>
    </div>

    <div id="editFormOverlay" class="overlay" onclick="if (event.target == this) this.style.display='none'">
	    <div class="user-form-popup">
	        <span class="close-btn" onclick="document.getElementById('editFormOverlay').style.display='none'">�</span>
	        <form action="AdminEditUser.jsp" method="post">
	            <input type="hidden" id="editUserId" name="userId">
	            <label for="editUsername">Username:</label><br>
	            <input type="text" id="editUsername" name="username" required><br>
	            <label for="editPassword">Password:</label><br>
	            <input type="text" id="editPassword" name="password" required><br> <!-- Change type to "text" -->
	            <label for="editPermissions">Permissions:</label><br>
	            <select id="editPermissions" name="permissions" required>
	                <option value="0">0</option>
	                <option value="1">1</option>
	            </select><br>
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
            String baseQuery = "SELECT user_id, username, password, permissions FROM users WHERE username != 'Admin'";

            PreparedStatement ps = con.prepareStatement(baseQuery);
            
            ResultSet result = ps.executeQuery();
            

            while (result.next()) { %>
                <tr>
                    <td><%= result.getString("user_id") %></td>
                    <td><%= result.getString("username") %></td>
                    <td>
                        <button onclick="editUser('<%= result.getString("user_id") %>', '<%= result.getString("username") %>', '<%= result.getString("password") %>', '<%= result.getInt("permissions") %>')">Edit User</button>
                        <button onclick="deleteUser('<%= result.getString("user_id") %>')">Delete User</button>
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
