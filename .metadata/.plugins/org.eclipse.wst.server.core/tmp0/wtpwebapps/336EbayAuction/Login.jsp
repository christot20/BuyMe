<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    
    <!--Functionality to toggle passwords>  -->
    
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login</title>
    <script>
        function togglePassword() {
            var passwordInput = document.getElementById("password");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
            } else {
                passwordInput.type = "password";
            }
        }
    </script>
</head>
<body>
<%
    if (is_logged_in) {
        out.print("You are already logged in as " + session.getAttribute("username") + ". <a href='logout.jsp'><button>Logout</button></a>");
    } else {
%> 
    Login
    <form method="post" action="SignIn.jsp">
        <table>
            <tr>
                <td>Username</td><td><input type="text" name="username"></td>
            </tr>
            <tr>
                <td>Password</td><td><input type="password" name="password" id="password"></td>
                <td><button type="button" onclick="togglePassword()">Show Password</button></td>
            </tr>
        </table>
        <div>
            <input type="submit" value="Login User">
            <input type="submit" value="Sign Up" formaction="SignUp.jsp">
        </div>
    </form>
<% } %>
</body>
</html>
