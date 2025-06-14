import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class QuizMarksServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.getWriter().println("<h3>Error: User is not logged in.</h3>");
            return;
        }

        try {
            // Database connection
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/QuizApp", "postgres", "mahaswin");

            String query = "SELECT DISTINCT q.quiz_id, q.quiz_name FROM user_attempt sa " +
                    "JOIN quiz q ON sa.quiz_id = q.quiz_id WHERE sa.user_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, userId);

            ResultSet rs = pst.executeQuery();

            // Convert ResultSet to a List of Maps
            List<Map<String, String>> quizzes = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> quiz = new HashMap<>();
                quiz.put("quiz_id", rs.getString("quiz_id"));
                quiz.put("quiz_name", rs.getString("quiz_name"));
                quizzes.add(quiz);
            }

            // Set the list as a request attribute
            request.setAttribute("quizList", quizzes);

            // Forward the request to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("QuizMarks.jsp");
            dispatcher.forward(request, response);

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error fetching quiz history. Please try again.</h3>");
        }
    }
}
