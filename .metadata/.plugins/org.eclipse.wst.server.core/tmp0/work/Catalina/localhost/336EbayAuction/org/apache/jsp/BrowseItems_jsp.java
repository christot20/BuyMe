/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.100
 * Generated at: 2024-05-04 04:49:30 UTC
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
import java.time.LocalDateTime;
import javax.servlet.http.*;
import javax.servlet.*;

public final class BrowseItems_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes = new java.util.LinkedHashSet<>(1);
    _jspx_imports_classes.add("java.time.LocalDateTime");
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
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>Computer Auctions</title>\r\n");
      out.write("    <style>\r\n");
      out.write("        .container {\r\n");
      out.write("            max-width: 800px;\r\n");
      out.write("            margin: 0 auto;\r\n");
      out.write("            padding: 20px;\r\n");
      out.write("        }\r\n");
      out.write("        .product {\r\n");
      out.write("            margin-bottom: 20px;\r\n");
      out.write("        }\r\n");
      out.write("        .product-details {\r\n");
      out.write("            border: 1px solid #ccc;\r\n");
      out.write("            padding: 10px;\r\n");
      out.write("        }\r\n");
      out.write("        .product img {\r\n");
      out.write("            max-width: 100px;\r\n");
      out.write("            max-height: 100px;\r\n");
      out.write("            margin-right: 10px;\r\n");
      out.write("            float: left;\r\n");
      out.write("        }\r\n");
      out.write("        .bid-form {\r\n");
      out.write("            clear: both;\r\n");
      out.write("        }\r\n");
      out.write("        .bid-history-button {\r\n");
      out.write("            float: right;\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <button onclick=\"window.location.href='Welcome.jsp'\">Back</button>\r\n");
      out.write("\r\n");
      out.write("    <div class=\"container\">\r\n");
      out.write("        <h1>Computer Auctions</h1>\r\n");
      out.write("        ");
 
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            boolean expiredItemsExist = false; // Flag to check if there are any expired items
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                // Validate username and password
                ApplicationDB db = new ApplicationDB();
                conn = db.getConnection();
                
                stmt = conn.prepareStatement("SELECT * FROM Computers");
                rs = stmt.executeQuery();
                while (rs.next()) {
                    int item_id = rs.getInt("item_id");
                    String name = rs.getString("name");
                    String computer_type = rs.getString("computer_type");
                    double initial_price = rs.getDouble("initial_price");
                    double current_bid = rs.getDouble("current_bid");
                    Timestamp expiration_date = rs.getTimestamp("expiration_date"); // Retrieve expiration date from database
                    String imageFilename = "Images/" + computer_type.toLowerCase() + ".png"; // Assuming images are stored in a folder named "images"
                    String current_top_bidder = rs.getString("current_top_bidder");
	
                    
                    
                    // Check if item is expired
                    if (!expiration_date.toLocalDateTime().isAfter(LocalDateTime.now())) {
                        
                    	
                    	
                    	String messageWinner = "INSERT INTO Messages (user_id, message, time) VALUES (?, ?, ?)";
                    	PreparedStatement ps = conn.prepareStatement(messageWinner);
                    	ps.setString(1, current_top_bidder); // Assuming current_top_bidder is the user_id
                    	ps.setString(2, "Congrats! You won item " + name); // Message
                    	ps.setObject(3, LocalDateTime.now()); // Current time

                    	ps.executeUpdate();


                    	
                    	/*
                    	
                    	Don't use this, we still need to have the bid in the DB for when we show bids a user has participated in
                    	String deleteCurrentEntrySQL = "DELETE FROM Computers WHERE item_id = ?";
                    	PreparedStatement deleteStatement = conn.prepareStatement(deleteCurrentEntrySQL);
                    	deleteStatement.setInt(1, item_id);
                    	deleteStatement.executeUpdate();
                    	
                    	*/
                    	
                    	
                        continue; // Skip this item
                    }
                    
                   
                    

                    
        
      out.write("\r\n");
      out.write("        <div class=\"product\">\r\n");
      out.write("            <div class=\"product-details\">\r\n");
      out.write("                <img src=\"");
      out.print(imageFilename);
      out.write("\" alt=\"");
      out.print(computer_type);
      out.write("\">\r\n");
      out.write("                <h2>");
      out.print(name);
      out.write("</h2>\r\n");
      out.write("                <p>Type: ");
      out.print(computer_type);
      out.write("</p>\r\n");
      out.write("                <p>Initial Price: $");
      out.print(initial_price);
      out.write("</p>\r\n");
      out.write("                <p>Current Bid: $");
      out.print(current_bid);
      out.write("</p>\r\n");
      out.write("                <p>End Date: ");
      out.print(expiration_date);
      out.write("</p> <!-- Display expiration date -->\r\n");
      out.write("                <div class=\"bid-form\">\r\n");
      out.write("                    <form action=\"PlaceBid.jsp\" method=\"post\">\r\n");
      out.write("                        <input type=\"hidden\" name=\"item_id\" value=\"");
      out.print(item_id);
      out.write("\">\r\n");
      out.write("                        <label for=\"bid_amount\">Your Bid:</label>\r\n");
      out.write("                        <input type=\"number\" name=\"bid_amount\" id=\"bid_amount\" step=\"0.01\" required>\r\n");
      out.write("                        <button type=\"submit\">Place Bid</button>\r\n");
      out.write("                    </form>\r\n");
      out.write("                    <form action=\"BidHistory.jsp\" method=\"post\">\r\n");
      out.write("                        <input type=\"hidden\" name=\"item_id\" value=\"");
      out.print(item_id);
      out.write("\">\r\n");
      out.write("                        <button class=\"bid-history-button\" type=\"submit\">Bid History</button>\r\n");
      out.write("                    </form>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        ");
 
                }
                
                // Redirect to ItemExpired.jsp if there are any expired items
                
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        
      out.write("\r\n");
      out.write("    </div>\r\n");
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
