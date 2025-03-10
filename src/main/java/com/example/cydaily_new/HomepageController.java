package com.example.cydaily_new;

import com.example.cydaily_new.model.User;
import jakarta.servlet.*;
        import jakarta.servlet.http.*;
        import java.io.IOException;

public class HomepageController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/home.jsp");
        dispatcher.forward(request, response);
    }
}