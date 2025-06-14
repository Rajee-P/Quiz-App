import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Properties;

public class ForgetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = null;

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/QuizApp", "postgres", "mahaswin");

            String query = "SELECT pass FROM admin WHERE email = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                password = rs.getString("pass");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h3>Email not found in the database.</h3>");
                out.println("<a href='ForgetPass.jsp'>Try again</a>");
                out.println("</body></html>");
                return;
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        // Sending the password via email
        try {
            String host = "smtp.gmail.com";
            String from = "mahaswinganesan@gmail.com";
            String pass = "akhome_999";

            Properties props = System.getProperties();
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");

            Session mailSession = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, pass);
                }
            });

            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Your Password");
            message.setText("Your password is: " + password);

            Transport.send(message);

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h3>Password sent to your email.</h3>");
            out.println("<a href='Login.jsp'>Go to Login</a>");
            out.println("</body></html>");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
