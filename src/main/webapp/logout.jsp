<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*" %>
<%
    // Invalidate the session to log the user out
    session = request.getSession(false); // Get session if it exists
    if (session != null) {
        session.invalidate(); // End the session
    }
    // Redirect to the HomePage.jsp or the intended page
    response.sendRedirect("FrontPage.jsp"); // Redirect to home page after logout
%>
