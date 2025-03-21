package com.example.cydaily_new;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Invalidate session
        request.getSession().invalidate();

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
