/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.100
 * Generated at: 2024-04-12 06:01:06 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.cs336.pkg.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

public final class HelloWorld_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(7);
    _jspx_imports_packages.add("com.cs336.pkg");
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("java.io");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("	<head>\r\n");
      out.write("		<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\r\n");
      out.write("		<title>Hi Beer World</title>\r\n");
      out.write("	</head>\r\n");
      out.write("	\r\n");
      out.write("	<body>\r\n");
      out.write("\r\n");
      out.write("		Hello World1 <!-- the usual HTML way -->\r\n");
      out.write("		");
 out.println("Hello World2"); 
      out.write(" <!-- output the same thing, but using \r\n");
      out.write("	                                      jsp programming -->\r\n");
      out.write("							  \r\n");
      out.write("		<br>\r\n");
      out.write("	\r\n");
      out.write("		 <!-- Show html form to i) display something, ii) choose an action via a \r\n");
      out.write("		  | radio button -->\r\n");
      out.write("		<!-- forms are used to collect user input \r\n");
      out.write("			The default method when submitting form data is GET.\r\n");
      out.write("			However, when GET is used, the submitted form data will be visible in the page address field-->\r\n");
      out.write("		<form method=\"post\" action=\"show.jsp\">\r\n");
      out.write("		    <!-- note the show.jsp will be invoked when the choice is made -->\r\n");
      out.write("			<!-- The next lines give HTML for radio buttons being displayed -->\r\n");
      out.write("		  <input type=\"radio\" name=\"command\" value=\"beers\"/>Let's have a beer! Click here to see the beers.\r\n");
      out.write("		  <br>\r\n");
      out.write("		  <input type=\"radio\" name=\"command\" value=\"bars\"/>Let's go to a bar! Click here to see the bars.\r\n");
      out.write("		    <!-- when the radio for bars is chosen, then 'command' will have value \r\n");
      out.write("		     | 'bars', in the show.jsp file, when you access request.parameters -->\r\n");
      out.write("		  <br>\r\n");
      out.write("		  <input type=\"submit\" value=\"submit\" />\r\n");
      out.write("		</form>\r\n");
      out.write("		<br>\r\n");
      out.write("	\r\n");
      out.write("	An existing bar wants to sell an existing beer! Type the bar, the beer and the price of the beer:\r\n");
      out.write("	<br>\r\n");
      out.write("		<form method=\"get\" action=\"sellsNewBeer.jsp\">\r\n");
      out.write("			<table>\r\n");
      out.write("				<tr>    \r\n");
      out.write("					<td>Bar</td><td><input type=\"text\" name=\"barvalia\"></td>\r\n");
      out.write("				</tr>\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td>Beer</td><td><input type=\"text\" name=\"beer\"></td>\r\n");
      out.write("				</tr>\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td>Price</td><td><input type=\"text\" name=\"price\"></td>\r\n");
      out.write("				</tr>\r\n");
      out.write("			</table>\r\n");
      out.write("			<input type=\"submit\" value=\"Add the selling beer!\">\r\n");
      out.write("		</form>\r\n");
      out.write("	<br>\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	Alternatively, lets type in a new bar, a new beer, and a price that this bar will sell the beer for.\r\n");
      out.write("	<br>\r\n");
      out.write("		<form method=\"post\" action=\"newBarBeerPrice.jsp\">\r\n");
      out.write("		<table>\r\n");
      out.write("		<tr>    \r\n");
      out.write("		<td>Bar</td><td><input type=\"text\" name=\"bar\"></td>\r\n");
      out.write("		</tr>\r\n");
      out.write("		<tr>\r\n");
      out.write("		<td>Beer</td><td><input type=\"text\" name=\"beer\"></td>\r\n");
      out.write("		</tr>\r\n");
      out.write("		<tr>\r\n");
      out.write("		<td>Price</td><td><input type=\"text\" name=\"price\"></td>\r\n");
      out.write("		</tr>\r\n");
      out.write("		</table>\r\n");
      out.write("		<input type=\"submit\" value=\"Add me!\">\r\n");
      out.write("		</form>\r\n");
      out.write("	<br>\r\n");
      out.write("	\r\n");
      out.write("	Or we can query the beers with price:\r\n");
      out.write("	<br>\r\n");
      out.write("		<form method=\"get\" action=\"query.jsp\">\r\n");
      out.write("			<select name=\"price\" size=1>\r\n");
      out.write("				<option value=\"3.0\">$3.0 and under</option>\r\n");
      out.write("				<option value=\"5.0\">$5.0 and under</option>\r\n");
      out.write("				<option value=\"8.0\">$8.0 and under</option>\r\n");
      out.write("			</select>&nbsp;<br> <input type=\"submit\" value=\"submit\">\r\n");
      out.write("		</form>\r\n");
      out.write("	<br>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
