<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Marks</title>
    <style>
        .quiz-list { max-width: 600px; margin: auto; font-family: Arial, sans-serif; }
        .quiz-card { padding: 15px; margin: 10px; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; }
        .quiz-card:hover { background-color: #f1f1f1; }
        .quiz-id { color: #007bff; font-weight: bold; }
    </style>
</head>
<body>
    <div class="quiz-list">
        <h1>Quiz Marks</h1>

        <%
            String dbURL = "jdbc:postgresql://localhost:5432/QuizApp";
            String dbUser = "postgres";
            String dbPassword = "mahaswin";

            // Use the implicit session object directly
            if (session == null || session.getAttribute("admin_id") == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
                return;
            }

            int adminId = (int) session.getAttribute("admin_id");

            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                String query = "SELECT quiz_id, quiz_name FROM quiz WHERE admin_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, adminId);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        String quizId = rs.getString("quiz_id");
                        String quizName = rs.getString("quiz_name");
        %>

        <div class="quiz-card" onclick="window.location.href='MarkDetails.jsp?quizID=<%= quizId %>'">
            <h3><%= quizName %></h3>
            <p class="quiz-id">Quiz ID: <%= quizId %></p>
        </div>

        <%
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html>
