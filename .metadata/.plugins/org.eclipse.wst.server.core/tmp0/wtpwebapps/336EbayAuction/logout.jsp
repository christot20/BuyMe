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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	if (is_logged_in) {
		session.invalidate();
		out.print("Successfully logged out.");
	} else {
		response.sendRedirect("Login.jsp");
	}
	%>
	<a href="Login.jsp">Back to Login</a>
</body>
</html>