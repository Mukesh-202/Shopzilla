package com.shopzilla.controller;

import com.shopzilla.model.Cart;
import com.shopzilla.model.User;
import com.shopzilla.service.CartService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class CartServlet extends HttpServlet {

    private CartService cartService;

    @Override
    public void init() throws ServletException {
        cartService = new CartService();
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

        String action =
                request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            action = "view";
        }

        try {

            switch (action.toLowerCase()) {

                case "view":
                    showCart(request, response, user);
                    break;

                case "count":
                    response.setContentType(
                            "text/plain;charset=UTF-8"
                    );

                    response.getWriter().write(
                            String.valueOf(
                                    cartService.getCartCount(
                                            user.getId()
                                    )
                            )
                    );
                    break;

                case "total":
                    response.setContentType(
                            "text/plain;charset=UTF-8"
                    );

                    response.getWriter().write(
                            String.format(
                                    "%.2f",
                                    cartService.getCartTotal(
                                            user.getId()
                                    )
                            )
                    );
                    break;

                default:
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid cart action."
                    );
            }

        } catch (SQLException e) {

            getServletContext().log(
                    "Cart GET error",
                    e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error."
            );
        }
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

        String action =
                request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Cart action required."
            );
            return;
        }

        try {

            switch (action.toLowerCase()) {

                case "add":
                    addToCart(request, response, user);
                    break;

                case "update":
                    updateQuantity(request, response, user);
                    break;

                case "remove":
                    removeFromCart(request, response, user);
                    break;

                case "clear":
                    clearCart(request, response, user);
                    break;

                default:
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid cart action."
                    );
            }

        } catch (SQLException e) {

            getServletContext().log(
                    "Cart POST error",
                    e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error."
            );
        }
    }

    private void showCart(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws SQLException, ServletException, IOException {

        List<Cart> cartItems =
                cartService.getCart(user.getId());

        double total =
                cartService.getCartTotal(user.getId());

        int count =
                cartService.getCartCount(user.getId());

        request.setAttribute(
                "cartItems",
                cartItems
        );

        request.setAttribute(
                "cartTotal",
                total
        );

        request.setAttribute(
                "cartCount",
                count
        );

        request.getRequestDispatcher(
                "/buyer/cart.jsp"
        ).forward(request, response);
    }

    private void addToCart(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws SQLException, IOException {

        int productId =
                parseInt(
                        request.getParameter("productId")
                );

        int quantity =
                parseInt(
                        request.getParameter("quantity")
                );

        if (quantity <= 0) {
            quantity = 1;
        }

        boolean success =
                cartService.addToCart(
                        user.getId(),
                        productId,
                        quantity
                );

        sendCartResponse(
                request,
                response,
                success,
                "Product+added+to+cart",
                "Unable+to+add+product+to+cart"
        );
    }

    private void updateQuantity(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws SQLException, IOException {

        int productId =
                parseInt(
                        request.getParameter("productId")
                );

        int quantity =
                parseInt(
                        request.getParameter("quantity")
                );

        boolean success =
                cartService.updateQuantity(
                        user.getId(),
                        productId,
                        quantity
                );

        sendCartResponse(
                request,
                response,
                success,
                "Cart+updated",
                "Unable+to+update+cart"
        );
    }

    private void removeFromCart(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws SQLException, IOException {

        int productId =
                parseInt(
                        request.getParameter("productId")
                );

        boolean success =
                cartService.removeFromCart(
                        user.getId(),
                        productId
                );

        sendCartResponse(
                request,
                response,
                success,
                "Product+removed",
                "Unable+to+remove+product"
        );
    }

    private void clearCart(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws SQLException, IOException {

        cartService.clearCart(
                user.getId()
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/CartServlet?action=view"
                        + "&success=Cart+cleared"
        );
    }

    private void sendCartResponse(
            HttpServletRequest request,
            HttpServletResponse response,
            boolean success,
            String successMessage,
            String errorMessage)
            throws IOException {

        response.sendRedirect(
                request.getContextPath()
                        + "/CartServlet?action=view&"
                        + (success
                        ? "success=" + successMessage
                        : "error=" + errorMessage)
        );
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

    private int parseInt(String value) {

        try {
            return Integer.parseInt(
                    value == null ? "0" : value
            );
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}