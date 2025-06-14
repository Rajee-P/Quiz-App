import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class QuizHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dbURL = "jdbc:postgresql://localhost:5432/QuizApp";
        String dbUser = "postgres";
        String dbPassword = "mahaswin";

        HttpSession session = request.getSession(false);
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
                request.setAttribute("quizList", rs);
                RequestDispatcher dispatcher = request.getRequestDispatcher("quizHistory.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}