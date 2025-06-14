import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class QuizDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dbURL = "jdbc:postgresql://localhost:5432/QuizApp";
        String dbUser = "postgres";
        String dbPassword = "mahaswin";

        String quizID = request.getParameter("quizID");
        if (quizID == null || quizID.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quiz ID is missing.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            String quizQuery = "SELECT quiz_name FROM quiz WHERE quiz_id = ?";
            String questionQuery = "SELECT question_id, question_text, marks FROM questions WHERE quiz_id = ?";
            String optionQuery = "SELECT question_id, option_text, is_correct FROM options WHERE quiz_id = ?";

            try (
                    PreparedStatement quizStmt = conn.prepareStatement(quizQuery);
                    PreparedStatement questionStmt = conn.prepareStatement(questionQuery);
                    PreparedStatement optionStmt = conn.prepareStatement(optionQuery)
            ) {
                quizStmt.setString(1, quizID);
                questionStmt.setString(1, quizID);
                optionStmt.setString(1, quizID);

                ResultSet quizRs = quizStmt.executeQuery();
                if (quizRs.next()) {
                    request.setAttribute("quizID", quizID);
                    request.setAttribute("quizName", quizRs.getString("quiz_name"));
                }

                ResultSet questionRs = questionStmt.executeQuery();
                request.setAttribute("questionRs", questionRs);

                ResultSet optionRs = optionStmt.executeQuery();
                request.setAttribute("optionRs", optionRs);

                RequestDispatcher dispatcher = request.getRequestDispatcher("QuizDetails.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        }
    }
}
