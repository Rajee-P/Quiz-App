<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Details</title>
    <style>
        .quiz-details { max-width: 800px; margin: auto; font-family: Arial, sans-serif; }
        .question { margin-bottom: 20px; padding: 15px; border: 1px solid #ccc; border-radius: 5px; }
        .question h3 { margin: 0; }
        .options { margin-top: 10px; }
        .option { margin: 5px 0; }
    </style>
</head>
<body>
    <div class="quiz-details">
        <h1>Quiz Details</h1>
        <%
            String quizID = request.getParameter("quizID");
            String dbURL = "jdbc:postgresql://localhost:5432/QuizApp";
            String dbUser = "postgres";
            String dbPassword = "mahaswin";

            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                String quizQuery = "SELECT quiz_name FROM quiz WHERE quiz_id = ?";
                try (PreparedStatement quizStmt = conn.prepareStatement(quizQuery)) {
                    quizStmt.setString(1, quizID);
                    ResultSet quizRs = quizStmt.executeQuery();
                    if (quizRs.next()) {
                        String quizName = quizRs.getString("quiz_name");
        %>
                        <h2>Quiz ID: <%= quizID %></h2>
                        <h2>Quiz Name: <%= quizName %></h2>
        <%
                    }
                }

                String questionQuery = "SELECT question_id, question_text, marks FROM questions WHERE quiz_id = ?";
                try (PreparedStatement questionStmt = conn.prepareStatement(questionQuery)) {
                    questionStmt.setString(1, quizID);
                    ResultSet questionRs = questionStmt.executeQuery();

                    while (questionRs.next()) {
                        int questionID = questionRs.getInt("question_id");
                        String questionText = questionRs.getString("question_text");
                        int marks = questionRs.getInt("marks");
        %>
                        <div class="question">
                            <h3>Question <%= questionID %>: <%= questionText %></h3>
                            <p>Marks: <%= marks %></p>
                            <div class="options">
        <%
                        String optionQuery = "SELECT option_text, is_correct FROM options WHERE quiz_id = ? AND question_id = ?";
                        try (PreparedStatement optionStmt = conn.prepareStatement(optionQuery)) {
                            optionStmt.setString(1, quizID);
                            optionStmt.setInt(2, questionID);
                            ResultSet optionRs = optionStmt.executeQuery();
                            while (optionRs.next()) {
                                String optionText = optionRs.getString("option_text");
                                boolean isCorrect = optionRs.getBoolean("is_correct");
        %>
                                <div class="option">
                                    <%= optionText %> <% if (isCorrect) { %><strong>(Correct)</strong><% } %>
                                </div>
        <%
                            }
                        }
        %>
                            </div>
                        </div>
        <%
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error fetching quiz details. Please try again later.</p>");
            }
        %>
    </div>
</body>
</html>
