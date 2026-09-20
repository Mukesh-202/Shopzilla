package com.shopzilla.controller;

import com.shopzilla.model.User;
import com.shopzilla.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

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

                String email = request.getParameter("email");
                String password = request.getParameter("password");

                if (email == null || email.trim().isEmpty()
                                || password == null || password.isEmpty()) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/auth/login.jsp"
                                                        + "?error=Please+enter+email+and+password");
                        return;
                }

                User user = userService.login(
                                email.trim(),
                                password);

                if (user == null) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/auth/login.jsp"
                                                        + "?error=Invalid+email+or+password");

                        return;
                }

                /*
                 * Invalidate old session
                 */
                HttpSession oldSession = request.getSession(false);

                if (oldSession != null) {
                        oldSession.invalidate();
                }

                /*
                 * Create new session
                 */
                HttpSession session = request.getSession(true);

                session.setMaxInactiveInterval(30 * 60);

                /*
                 * Store logged-in user
                 */
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userRole", user.getRole());

                /*
                 * Get user role
                 */
                String role = user.getRole() == null
                                ? "BUYER"
                                : user.getRole().trim().toUpperCase();

                /*
                 * DEBUG
                 * Check Tomcat console after login.
                 */
                System.out.println(
                                "LOGIN USER: "
                                                + user.getEmail()
                                                + " | ROLE: ["
                                                + role
                                                + "]");

                /*
                 * Redirect based on role
                 */
                if ("ADMIN".equals(role)) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/admin/dashboard.jsp");

                } else if ("SELLER".equals(role)) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/seller/dashboard.jsp");

                } else {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/buyer/products.jsp");
                }
        }

        @Override
        protected void doGet(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                response.sendRedirect(
                                request.getContextPath()
                                                + "/auth/login.jsp");
        }
}