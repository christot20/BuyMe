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
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	
	
	// Validate username and password
	ApplicationDB db = new ApplicationDB();
	Connection connection = db.getConnection();
	
	
	
	int staff_id = (Integer)session.getAttribute("user_id");
	String questionId = request.getParameter("question_id");
	
	String answerBody = request.getParameter("answer_body");
	
	out.print("Staff ID: "+ staff_id + "\n");
	out.print("Question ID: " + questionId + "\n");
	out.print("Answer: "+ answerBody + "\n");

	
	try{

	        PreparedStatement ps2 = connection.prepareStatement("INSERT INTO answers(question_id, staff_id, answer_body) VALUES (?, ?,?) ", Statement.RETURN_GENERATED_KEYS);

	        ps2.setString(1, questionId);
	        ps2.setInt(2, staff_id);
	        ps2.setString(3, answerBody);
			
	        ps2.executeUpdate();
	        
	        
			

	    }
	    catch(SQLException e) {
	        throw new ServletException("Database error", e);
	    } finally {
	        db.closeConnection(connection);
	    }
	
	

%>

<!-- Back Button Form -->
	<form action="Questions.jsp" method="get">
	    <button type="submit">Go Back</button>
	</form>



</body>
</html>