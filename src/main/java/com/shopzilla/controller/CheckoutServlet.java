package com.shopzilla.controller;

import com.shopzilla.model.User;
import com.shopzilla.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
public class CheckoutServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User user = getLoggedInUser(request);

        if (user == null) {
            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );
            return;
        }

        request.getRequestDispatcher(
                "/buyer/checkout.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User user = getLoggedInUser(request);

        if (user == null) {
            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );
            return;
        }

        String paymentMethod =
                request.getParameter("paymentMethod");

        String shippingAddress =
                request.getParameter("shippingAddress");

        if (paymentMethod == null
                || paymentMethod.trim().isEmpty()
                || shippingAddress == null
                || shippingAddress.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/buyer/checkout.jsp"
                            + "?error=Please+fill+all+checkout+details"
            );
            return;
        }

        /*
         * Current OrderService.checkout() accepts only userId.
         * The payment method and shipping address are validated
         * here so the checkout form still works correctly.
         */
        boolean success =
                orderService.checkout(
                        user.getId()
                );

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/buyer/orders.jsp"
                            + "?success=Order+placed+successfully"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/buyer/checkout.jsp"
                            + "?error=Unable+to+place+order"
            );
        }
    }

    private User getLoggedInUser(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return null;
        }

        Object userObject =
                session.getAttribute("user");

        if (userObject instanceof User) {
            return (User) userObject;
        }

        return null;
    }
}
