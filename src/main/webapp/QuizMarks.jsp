<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Quiz Results</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:hover { background-color: #f9f9f9; }
    </style>
</head>
<body>
    <h1>Your Quiz Results</h1>

    <%
        String dbURL = "jdbc:postgresql://localhost:5432/QuizApp";
        String dbUser = "postgres";
        String dbPassword = "mahaswin";

        // Check if the user is logged in
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            String query = "SELECT q.quiz_id, q.quiz_name, COUNT(ua.is_correct) AS marks " +
                           "FROM user_attempt ua " +
                           "JOIN quiz q ON ua.quiz_id = q.quiz_id " +
                           "WHERE ua.user_id = ? AND ua.is_correct = true " +
                           "GROUP BY q.quiz_id, q.quiz_name " +
                           "ORDER BY q.quiz_name";

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p>No quizzes attempted yet.</p>");
                } else {
    %>

    <table>
        <thead>
            <tr>
                <th>Quiz ID</th>
                <th>Quiz Name</th>
                <th>Marks</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    String quizId = rs.getString("quiz_id");
                    String quizName = rs.getString("quiz_name");
                    int marks = rs.getInt("marks");
            %>
            <tr>
                <td><%= quizId %></td>
                <td><%= quizName %></td>
                <td><%= marks %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error retrieving quiz results. Please try again later.</p>");
        }
    %>
</body>
</html>
