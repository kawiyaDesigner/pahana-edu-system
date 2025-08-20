package com.kawishka.controller;

import com.kawishka.dao.UserDAO;
import com.kawishka.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    // GET request: show login form
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/view/login.jsp").forward(request, response);
    }

    // POST request: process login
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);  // store user in session
            response.sendRedirect("item?action=list"); // redirect to product list
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}
