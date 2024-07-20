<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try {
            // Get form data
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            int permissions = Integer.parseInt(request.getParameter("permissions"));

            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            
            //check if the user already exists
            PreparedStatement ps0 = con.prepareStatement("SELECT user_id FROM Users WHERE username = ? AND password = ?");
            ps0.setString(1, username);
            ps0.setString(2, password);
            ResultSet rs0 = ps0.executeQuery();
            
            if(rs0.next()) {
            	response.sendRedirect("FailedLogin.jsp");
            }

            // Construct the SQL query
            String insertUser = "INSERT INTO users (username, password, permissions) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertUser);

            // Set parameters
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, permissions);

            // Execute the query
            ps.executeUpdate();
            
            if (permissions == 1) {
            	//add account to the staff table
            	PreparedStatement ps1 = con.prepareStatement("SELECT user_id FROM users WHERE username = ?");
            	ps1.setString(1, username);
            	ResultSet rs = ps1.executeQuery();
            	
            	rs.next();
            	int user_id = rs.getInt("user_id");
            	
                String addStaff = "INSERT INTO staff (staff_id, password, staff_rank, name) VALUES (?, ?, '1', ?)";
            	PreparedStatement ps2 = con.prepareStatement(addStaff);
            	
            	ps2.setInt(1, user_id);
                ps2.setString(2, password);
                ps2.setString(3, username);

                ps2.execute();
            }
            // Close the connection
            con.close();
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        // Redirect back to AdminManageUsers.jsp
        response.sendRedirect("AdminManageUsers.jsp");
%>
</body>
</html>