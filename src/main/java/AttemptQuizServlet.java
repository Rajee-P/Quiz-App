import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AttemptQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String quizId = request.getParameter("quiz_id");
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("user_id");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Load PostgreSQL driver
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/QuizApp", "postgres", "mahaswin");

            // Check if the quiz exists
            String quizCheckQuery = "SELECT * FROM quiz WHERE quiz_id = ?";
            PreparedStatement pstQuiz = con.prepareStatement(quizCheckQuery);
            pstQuiz.setString(1, quizId);
            ResultSet rsQuiz = pstQuiz.executeQuery();

            if (rsQuiz.next()) {
                // Check if the user has already attempted the quiz
                String attemptCheckQuery = "SELECT * FROM user_attempt WHERE user_id = ? AND quiz_id = ?";
                PreparedStatement pstAttempt = con.prepareStatement(attemptCheckQuery);
                pstAttempt.setInt(1, userId);
                pstAttempt.setString(2, quizId);
                ResultSet rsAttempt = pstAttempt.executeQuery();

                if (!rsAttempt.next()) {
                    // Set quiz_id in session and redirect to QuizPage
                    session.setAttribute("quiz_id", quizId);
                    response.sendRedirect("QuizPage.jsp");
                } else {
                    out.println("<h3>You have already attempted this quiz!</h3>");
                }
            } else {
                out.println("<h3>Invalid Quiz Code!</h3>");
            }

            // Close database connection
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
