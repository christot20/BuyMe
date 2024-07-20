<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*,java.util.*,java.sql.*,javax.servlet.*, com.cs336.pkg.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Set default values if parameters are null
        
        
        ApplicationDB db = new ApplicationDB();
        Connection connection = db.getConnection();
        
        if (username == null || username.equals("")) {
        	response.sendRedirect("FailedLogin.jsp");
        }
        if (password == null || password.equals("")) {
        	response.sendRedirect("FailedLogin.jsp");
        }
       
        try {
            // Select user_id from the database based on username and password
            PreparedStatement ps = connection.prepareStatement("SELECT user_id FROM Users WHERE username = ? AND password = ?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            // Check if the result set is empty (i.e., if the username and password are available)
            if (!rs.next()) {
                
                // Insert the new user into the database
                PreparedStatement ps2 = connection.prepareStatement("INSERT INTO users(username,password,permissions) VALUES (?, ?,0) ", Statement.RETURN_GENERATED_KEYS);
                
                ps2.setString(1, username);
                ps2.setString(2, password);
                
                // Execute the insert query
                int rowsAffected = ps2.executeUpdate();
                if (rowsAffected > 0) {
                    // User inserted successfully, retrieve the generated user_id
                    ResultSet generatedKeys = ps2.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int id = generatedKeys.getInt(1); // Get the generated user_id
                        session.setAttribute("user_id", id);
                        session.setAttribute("username", username);
                        response.sendRedirect("Welcome.jsp");
                    } else {
                        // Failed to retrieve the generated user_id
                        response.sendRedirect("FailedLogin.jsp");
                    }
                } else {
                    // Failed to insert user
                    response.sendRedirect("FailedLogin.jsp");
                }
            } else {
                // User already exists
                response.sendRedirect("FailedLogin.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } finally {
            db.closeConnection(connection);
        }
    %>
    <h2>Success!</h2>
    <p>Username <%= username %> with password <%= password %> was created.</p>
</body>
</html>
