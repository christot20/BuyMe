<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();
Connection conn = db.getConnection();
int user_id = (int) session.getAttribute("user_id");
	
String name = request.getParameter("auctionName");
String message = "INSERT INTO Messages (user_id, message, time) VALUES (?, ?, ?)";
PreparedStatement ps = conn.prepareStatement(message);

PreparedStatement ps3 = conn.prepareStatement("SELECT user_id FROM alerts WHERE item_name = ?");
ps3.setString(1, name);
ResultSet rs = ps3.executeQuery();
if(rs.next()) {
	response.getWriter().println("You already have an alert for this auction!");
} else {
	ps.setInt(1, user_id);
	ps.setString(2, "You have set an alert for " + name); // Message
	ps.setObject(3, LocalDateTime.now()); // Current time
	ps.executeUpdate();
			
	int item_id = Integer.parseInt(request.getParameter("auctionId"));
	PreparedStatement ps2 = conn.prepareStatement("INSERT INTO alerts (item_id, user_id, item_name) VALUES (?, ?, ?)");
	ps2.setInt(1, item_id);
	ps2.setInt(2, user_id);
	ps2.setString(3, name);
	ps2.executeUpdate();
	
	response.sendRedirect("Messages.jsp");
}
%>
</body>
</html>
s