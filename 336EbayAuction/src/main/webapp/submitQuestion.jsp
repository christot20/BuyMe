<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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

Connection connection = null;
Statement stmt = null;
ResultSet rs = null;


    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Validate username and password
    ApplicationDB db = new ApplicationDB();
    connection = db.getConnection();
    
    int user_id = (Integer)session.getAttribute("user_id");
    
    String questionBody = request.getParameter("question");
    
    
    out.println(user_id + "\n");
    out.println(questionBody + "\n");

    
    try{
    	PreparedStatement ps2 = connection.prepareStatement("INSERT INTO question(body, user_id) VALUES (?, ?) ", Statement.RETURN_GENERATED_KEYS);

        ps2.setString(1, questionBody);
        ps2.setInt(2, user_id);
        
		
        ps2.executeUpdate();
    }
    catch(SQLException e) {
        throw new ServletException("Database error", e);
    } finally {
        db.closeConnection(connection);
    }

%>

<!-- Back Button Form -->
	<form action="UsersQuestions.jsp" method="get">
	    <button type="submit">Go Back</button>
	</form>

</body>
</html>