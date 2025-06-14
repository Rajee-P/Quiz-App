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
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 8px 12px; text-align: left; border: 1px solid #ccc; }
        th { background-color: #f4f4f4; }
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
                // Query to fetch quiz name
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

                // Query to fetch user details for the quiz
                String questionQuery = "SELECT p.user_id, u.user_name, u.email, p.score FROM quiz_participants p " +
                                       "JOIN users u ON p.user_id = u.user_id " +
                                       "WHERE p.quiz_id = ? ORDER BY p.user_id;";
                try (PreparedStatement questionStmt = conn.prepareStatement(questionQuery)) {
                    questionStmt.setString(1, quizID);
                    ResultSet questionRs = questionStmt.executeQuery();

                    // Display the user data in a table
                    if (questionRs.next()) {
        %>
                        <table>
                            <thead>
                                <tr>
                                    <th>User ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Marks</th>
                                </tr>
                            </thead>
                            <tbody>
        <%
                        // Loop through and display each user data
                        do {
                            int userId = questionRs.getInt("user_id");
                            String userName = questionRs.getString("user_name");
                            String userEmail = questionRs.getString("email");
                            int score = questionRs.getInt("score");
        %>
                                <tr>
                                    <td><%= userId %></td>
                                    <td><%= userName %></td>
                                    <td><%= userEmail %></td>
                                    <td><%= score %></td>
                                </tr>
        <%
                        } while (questionRs.next());
        %>
                            </tbody>
                        </table>
        <%
                    } else {
                        out.println("<p>No participants found for this quiz.</p>");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error fetching quiz details. Please try again later.</p>");
                out.println(e.getMessage());
            }
        %>
    </div>
</body>
</html>
