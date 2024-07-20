<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>
</head>
<body>
	<%
    // Get username and password from request
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    

    // Validate username and password
    ApplicationDB db = new ApplicationDB();
    Connection connection = db.getConnection();
    
    
    
    try {    	
    	
    	//selecting id from here so we don't have to do another query to get it 
        PreparedStatement ps = connection.prepareStatement("SELECT user_id FROM Users WHERE username = ? AND password = ?");
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        
        PreparedStatement permissionRank = connection.prepareStatement("SELECT permissions FROM Users WHERE username = ? AND password = ?");
        permissionRank.setString(1, username);
        permissionRank.setString(2, password);
        
        ResultSet permissionResultSet = permissionRank.executeQuery();
        
        
        if (rs.next()) {
            int id = rs.getInt("user_id");

            // Move the cursor to the first row of permissionResultSet
            if(permissionResultSet.next()) {
                int permissions = permissionResultSet.getInt("permissions");

                //store the user information in the session variable
                session.setAttribute("user_id", id);
                session.setAttribute("username", username);
                session.setAttribute("permissions", permissions);

                if(permissions == 2) { //Admin has permission rank of 2
                    response.sendRedirect("AdminMode.jsp");
                } else if(permissions == 1) { //staff members have permission rank of 1
                    response.sendRedirect("StaffMode.jsp");
                } else {
                    response.sendRedirect("Welcome.jsp");
                }
            } else {
                // Handle the case where no permissions are found for the user
                response.sendRedirect("FailedLogin.jsp");
            }
        } else {
            // If the query does not return a result, the login is unsuccessful
            response.sendRedirect("FailedLogin.jsp");
        }

    } catch (SQLException e) {
        throw new ServletException("Database error", e);
    } finally {
    	if (connection != null) {
            db.closeConnection(connection);
        }
    }
%>
</body>
</html>