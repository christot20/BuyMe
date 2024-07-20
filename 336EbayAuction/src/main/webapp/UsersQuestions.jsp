<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Question Answering System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .question-container {
            margin-bottom: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        label {
            font-weight: bold;
        }
        textarea {
            width: 100%;
            resize: vertical;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        hr {
            border: none;
            border-top: 1px solid #ccc;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        
        .back-button {
            display: block;
            margin-top: 20px;
            text-align: center;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .back-button:hover {
            background-color: #0056b3;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <h1>Staff Question Answering System</h1>
        
        <%-- Import necessary Java classes for database access --%>
        <%@ page import="java.sql.*, java.util.ArrayList" %>
        
        <%-- Establish database connection --%>
        <% 
            Connection connection = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                // Validate username and password
                ApplicationDB db = new ApplicationDB();
                connection = db.getConnection();
                
                
                stmt = connection.createStatement();
                rs = stmt.executeQuery("SELECT q.user_id, q.question_id, q.body, a.answer_body FROM Question q left join Answers a on a.question_id = q.question_id");
                
                // Display questions and form for each question
                while (rs.next()) {
                    String questionId = rs.getString("question_id");
                    String questionBody = rs.getString("body");
                    
                    int user_id = rs.getInt("user_id");
                    
                    String answerBody = "";
                    
                    
                    if(rs.getString("answer_body") != null){
                        answerBody = rs.getString("answer_body");
                    }
          
                    
                    if(answerBody.equals("") && user_id == (Integer)session.getAttribute("user_id")){
                        
                        
        %>
                    
                   <div class="question-container">
                        <p><strong>Question:</strong> <%= questionBody %></p>
                        <p><strong>Answer:</strong> <%= answerBody %></p>
                        
                    </div>
                   
                    <hr>
        <% 
        
                    }
                    
                    else if(!answerBody.equals("") && user_id == (Integer)session.getAttribute("user_id")){
                        %>  
                        
                        <div class="question-container">
                        <p><strong>Question:</strong> <%= questionBody %></p>
                        <p><strong>Answer:</strong> <%= answerBody %></p>
                        
                    </div>
                    <hr>
                    
                        <% 
                    
                    }
                    
                    
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (connection != null) connection.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>

        <script>
            function prepareAnswer(questionId) {
                var answerTextArea = document.getElementById('answer_' + questionId);
                var answerBodyInput = document.getElementById('answer_body_' + questionId);
                answerBodyInput.value = answerTextArea.value;
            }
        </script>


        <div>
            <h2>Submit a Question</h2>
            <form action="submitQuestion.jsp" method="post">
                <label for="question">Your Question:</label><br>
                <textarea id="question" name="question" rows="4" cols="50" required></textarea><br><br>
                <input type="submit" value="Submit Question">
            </form>
        </div>

        <div>
            <a href="Welcome.jsp" class="back-button">Back</a>
        </div>
    </div>
</body>
</html>
