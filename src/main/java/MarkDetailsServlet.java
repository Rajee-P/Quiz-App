import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.ArrayList;

public class MarkDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String quizId = request.getParameter("quizID");
        ArrayList<String[]> participants = new ArrayList<>();

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/QuizApp", "postgres", "mahaswin");

            String fetchParticipantsQuery =
                    "SELECT u.user_id, u.name, u.email, qp.score " +
                            "FROM users u " +
                            "JOIN quiz_participants qp ON u.user_id = qp.user_id " +
                            "WHERE qp.quiz_id = ? " +
                            "ORDER BY u.user_id";

            PreparedStatement pst = con.prepareStatement(fetchParticipantsQuery);
            pst.setString(1, quizId);
            ResultSet rs = pst.executeQuery();

            // Add fetched participants to the list
            while (rs.next()) {
                String[] participant = new String[4];
                participant[0] = String.valueOf(rs.getInt("user_id"));
                participant[1] = rs.getString("quiz_name");
                participant[2] = rs.getString("email");
                participant[3] = String.valueOf(rs.getInt("score"));
                participants.add(participant);
            }

            request.setAttribute("quiz_id", quizId);
            request.setAttribute("participants", participants);

            // Forward to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("MarkDetails.jsp");
            dispatcher.forward(request, response);

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error retrieving participants. Please try again.</h3>");
        }
    }
}