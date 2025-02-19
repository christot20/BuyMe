/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.100
 * Generated at: 2024-05-04 04:58:17 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

public final class NewAuction_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(6);
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
      response.setContentType("text/html; charset=UTF-8");
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
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>Create New Auction</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <h1>Create a New Auction</h1>\r\n");
      out.write("    <form action=\"AddAuction.jsp\" method=\"post\">\r\n");
      out.write("\r\n");
      out.write("        <label for=\"itemName\">Item Name:</label>\r\n");
      out.write("        <input type=\"text\" id=\"itemName\" name=\"itemName\" required><br>\r\n");
      out.write("        \r\n");
      out.write("        <label for=\"itemType\">Item Type (Laptop, Desktop, All-In-One):</label>\r\n");
      out.write("        <select id=\"itemType\" name=\"itemType\" required>\r\n");
      out.write("            <option value=\"LAPTOP\">Laptop</option>\r\n");
      out.write("            <option value=\"DESKTOP\">Desktop</option>\r\n");
      out.write("            <option value=\"ALLINONE\">All-In-One</option>\r\n");
      out.write("        </select><br>\r\n");
      out.write("        \r\n");
      out.write("        <label for=\"ram\">RAM:</label>\r\n");
      out.write("        <select id=\"ram\" name=\"ram\" required>\r\n");
      out.write("            <option value=\"8\">8 GB</option>\r\n");
      out.write("            <option value=\"16\">16 GB</option>\r\n");
      out.write("            <option value=\"24\">24 GB</option>\r\n");
      out.write("            <option value=\"32\">32 GB</option>\r\n");
      out.write("            <option value=\"64\">64 GB</option>\r\n");
      out.write("            <option value=\"128\">128 GB</option>\r\n");
      out.write("        </select><br>\r\n");
      out.write("        \r\n");
      out.write("        <label for=\"storage\">Storage (in GB--if 1TB+ enter the equivalent in GB (1000+ GB)):</label>\r\n");
      out.write("        <input type=\"number\" id=\"storage\" name=\"storage\"><br>\r\n");
      out.write("        \r\n");
      out.write("        <label for=\"cpu\">CPU:</label>\r\n");
      out.write("        <select id=\"cpu\" name=\"cpu\" required>\r\n");
      out.write("            <option value=\"AMD Ryzen 3\">AMD Ryzen 3</option>\r\n");
      out.write("            <option value=\"AMD Ryzen 5\">AMD Ryzen 5</option>\r\n");
      out.write("            <option value=\"AMD Ryzen 7\">AMD Ryzen 7</option>\r\n");
      out.write("            <option value=\"AMD Ryzen 9\">AMD Ryzen 9</option>\r\n");
      out.write("            <option value=\"Intel I3\">Intel I3</option>\r\n");
      out.write("            <option value=\"Intel I7\">Intel I7</option>\r\n");
      out.write("            <option value=\"Intel I9\">Intel I9</option>\r\n");
      out.write("        </select><br>\r\n");
      out.write("\r\n");
      out.write("        <label for=\"startingBid\">Starting Bid:</label>\r\n");
      out.write("        <input type=\"number\" id=\"startingBid\" name=\"startingBid\" min=\"0\" value=\"0\"><br>\r\n");
      out.write("\r\n");
      out.write("        <label for=\"auctionListDate\">Auction List Date (at least today):</label>\r\n");
      out.write("        <input type=\"datetime-local\" id=\"auctionListDate\" name=\"auctionListDate\" min=\"");
      out.print( java.time.LocalDateTime.now() );
      out.write("\" required><br>\r\n");
      out.write("\r\n");
      out.write("        <label for=\"expirationDate\">Expiration Date (cannot be earlier than Auction List Date):</label>\r\n");
      out.write("        <input type=\"datetime-local\" id=\"expirationDate\" name=\"expirationDate\" min=\"");
      out.print( java.time.LocalDateTime.now() );
      out.write("\" required><br>\r\n");
      out.write("        \r\n");
      out.write("        <input type=\"submit\" value=\"Create Auction\">\r\n");
      out.write("    </form>\r\n");
      out.write("    <br>\r\n");
      out.write("    <a href=\"Welcome.jsp\"><button>Back to Main Menu</button></a>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
