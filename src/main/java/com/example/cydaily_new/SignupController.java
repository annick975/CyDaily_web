package com.example.cydaily_new;

import com.example.cydaily_new.model.User;
import com.example.cydaily_new.model.UserDAO;
import jakarta.servlet.*;
        import jakarta.servlet.http.*;
        import java.io.IOException;

public class SignupController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String password = request.getParameter("password");

        User user = new User(name, role, password);
        UserDAO userDAO = new UserDAO();

        if (userDAO.save(user)) {
            response.sendRedirect("login"); // Redirect to login page
        } else {
            request.setAttribute("errorMessage", "Signup failed. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/signup.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/signup.jsp");
        dispatcher.forward(request, response);
    }
}