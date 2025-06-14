import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class SubmitQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("user_id");
        String quizId = (String) session.getAttribute("quiz_id");

        int totalScore = 0;

        try {
            // Database connection
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/QuizApp", "postgres", "mahaswin");

            // Fetch questions for the quiz
            String questionQuery = "SELECT * FROM questions WHERE quiz_id = ?";
            PreparedStatement pst = con.prepareStatement(questionQuery);
            pst.setString(1, quizId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int questionId = rs.getInt("question_id");
                int correctOptionId = -1;

                // Get the correct option
                String correctOptionQuery = "SELECT option_id FROM options WHERE quiz_id = ? AND question_id = ? AND is_correct = TRUE";
                PreparedStatement pstCorrect = con.prepareStatement(correctOptionQuery);
                pstCorrect.setString(1, quizId);
                pstCorrect.setInt(2, questionId);
                ResultSet rsCorrect = pstCorrect.executeQuery();

                if (rsCorrect.next()) {
                    correctOptionId = rsCorrect.getInt("option_id");
                }

                String selectedOption = request.getParameter("question_" + questionId);
                if (selectedOption != null && Integer.parseInt(selectedOption) == correctOptionId) {
                    totalScore += rs.getInt("marks");
                }

                // Store attempt details in student_attempt table
                String insertAttemptQuery = "INSERT INTO user_attempt (user_id, quiz_id, question_id, selected_option_id, is_correct) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pstInsert = con.prepareStatement(insertAttemptQuery);
                pstInsert.setInt(1, userId);
                pstInsert.setString(2, quizId);
                pstInsert.setInt(3, questionId);
                pstInsert.setObject(4, selectedOption != null ? Integer.parseInt(selectedOption) : null, java.sql.Types.INTEGER);
                pstInsert.setBoolean(5, selectedOption != null && Integer.parseInt(selectedOption) == correctOptionId);
                pstInsert.executeUpdate();
            }

            String insertScoreQuery = "INSERT INTO quiz_participants (user_id, quiz_id, score) VALUES (?, ?, ?) ON CONFLICT (user_id, quiz_id) DO UPDATE SET score = ?";
            PreparedStatement pstScore = con.prepareStatement(insertScoreQuery);
            pstScore.setInt(1, userId);
            pstScore.setString(2, quizId);
            pstScore.setInt(3, totalScore);
            pstScore.setInt(4, totalScore);
            pstScore.executeUpdate();

            response.getWriter().println("<h3>Quiz submitted successfully! Your score: " + totalScore + "</h3>");

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error submitting quiz. Please try again.</h3>");
            response.getWriter().println(e.getMessage());
            response.getWriter().println(e.getCause());
        }
    }
}
