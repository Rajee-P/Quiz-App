<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            max-width: 800px;
            width: 100%;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            font-size: 2rem;
        }
        .question-container {
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .form-actions {
            text-align: center;
            margin-top: 30px;
        }
        .form-actions button {
            width: 100%;
            font-size: 1.25rem;
            padding: 15px;
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Quiz</h1>

        <form id="quizForm" action="SubmitQuizServlet" method="post">
            <%
                Class.forName("org.postgresql.Driver");
                String quizId = (String) session.getAttribute("quiz_id");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/QuizApp", "postgres", "mahaswin");

                // Fetch questions for the quiz
                String questionQuery = "SELECT * FROM questions WHERE quiz_id = ?";
                PreparedStatement pst = con.prepareStatement(questionQuery);
                pst.setString(1, quizId);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    int questionId = rs.getInt("question_id");
                    String questionText = rs.getString("question_text");
                    out.println("<div class='question-container'><h3>" + questionText + "</h3>");

                    String optionsQuery = "SELECT * FROM options WHERE quiz_id = ? AND question_id = ?";
                    PreparedStatement pstOptions = con.prepareStatement(optionsQuery);
                    pstOptions.setString(1, quizId);
                    pstOptions.setInt(2, questionId);
                    ResultSet rsOptions = pstOptions.executeQuery();

                    while (rsOptions.next()) {
                        int optionId = rsOptions.getInt("option_id");
                        String optionText = rsOptions.getString("option_text");
                        out.println("<input type='radio' name='question_" + questionId + "' value='" + optionId + "'>" + optionText + "<br>");
                    }
                    out.println("</div>");
                }

                con.close();
            %>
            <div class="form-actions">
                <button type="submit">Submit Quiz</button>
            </div>
        </form>
    </div>
</body>
</html>
