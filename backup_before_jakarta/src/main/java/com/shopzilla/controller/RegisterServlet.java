package com.shopzilla.controller;

import com.shopzilla.model.User;
import com.shopzilla.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
public class RegisterServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword =
                request.getParameter("confirmPassword");

        String role = request.getParameter("role");

        // Validate required fields
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/register.jsp"
                            + "?error=Please+fill+all+required+fields"
            );
            return;
        }

        // Password length
        if (password.length() < 6) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/register.jsp"
                            + "?error=Password+must+be+at+least+6+characters"
            );
            return;
        }

        // Confirm password
        if (confirmPassword != null
                && !password.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/register.jsp"
                            + "?error=Passwords+do+not+match"
            );
            return;
        }

        // Default role
        if (role == null || role.trim().isEmpty()) {
            role = "BUYER";
        }

        role = role.trim().toUpperCase();

        // Allow only BUYER or SELLER
        if (!role.equals("BUYER")
                && !role.equals("SELLER")) {

            role = "BUYER";
        }

        // Create User object
        User user = new User();

        user.setName(name.trim());
        user.setEmail(email.trim().toLowerCase());
        user.setPhone(
                phone == null ? "" : phone.trim()
        );
        user.setPassword(password);
        user.setRole(role);

        // Register user
        boolean registered =
                userService.register(user);

        if (registered) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
                            + "?success=Registration+successful.+Please+login"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/register.jsp"
                            + "?error=Email+already+exists+or+registration+failed"
            );
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                request.getContextPath()
                        + "/auth/register.jsp"
        );
    }
}