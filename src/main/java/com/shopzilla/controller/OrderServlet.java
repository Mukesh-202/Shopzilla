package com.shopzilla.controller;
import com.shopzilla.model.Order;
import com.shopzilla.model.User;
import com.shopzilla.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
public class OrderServlet extends HttpServlet {
private OrderService orderService;

@Override
public void init() {
    orderService = new OrderService();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    User user = getUser(request);

    if (user == null) {
        response.sendRedirect(
                request.getContextPath() + "/auth/login.jsp"
        );
        return;
    }

    String action = request.getParameter("action");

    try {

        if ("view".equalsIgnoreCase(action)) {

            viewOrder(request, response, user);

        } else if ("seller".equalsIgnoreCase(action)) {

            sellerOrders(request, response, user);

        } else if ("all".equalsIgnoreCase(action)) {

            allOrders(request, response, user);

        } else {

            myOrders(request, response, user);
        }

    } catch (SQLException e) {

        getServletContext().log(
                "Order error",
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

    User user = getUser(request);

    if (user == null) {
        response.sendRedirect(
                request.getContextPath() + "/auth/login.jsp"
        );
        return;
    }

    String action = request.getParameter("action");

    try {

        if ("updateStatus".equalsIgnoreCase(action)) {

            updateStatus(request, response, user);

        } else if ("cancel".equalsIgnoreCase(action)) {

            cancelOrder(request, response, user);

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid order action."
            );
        }

    } catch (SQLException e) {

        getServletContext().log(
                "Order update error",
                e
        );

        response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Database error."
        );
    }
}

private void myOrders(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, ServletException, IOException {

    List<Order> orders =
            orderService.getOrdersByUser(user.getId());

    request.setAttribute("orders", orders);

    request.getRequestDispatcher(
            "/buyer/orders.jsp"
    ).forward(request, response);
}

private void viewOrder(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, ServletException, IOException {

    int orderId = parseInt(
            request.getParameter("orderId")
    );

    Order order =
            orderService.getOrderById(orderId);

    if (order == null) {
        response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Order not found."
        );
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(user.getRole())
            && order.getUserId() != user.getId()) {

        response.sendError(
                HttpServletResponse.SC_FORBIDDEN
        );
        return;
    }

    request.setAttribute("order", order);

    request.getRequestDispatcher(
            "/buyer/orders.jsp"
    ).forward(request, response);
}

private void sellerOrders(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, ServletException, IOException {

    if (!"SELLER".equalsIgnoreCase(user.getRole())) {
        response.sendError(
                HttpServletResponse.SC_FORBIDDEN
        );
        return;
    }

    List<Order> orders =
            orderService.getSellerOrders(user.getId());

    request.setAttribute("orders", orders);

    request.getRequestDispatcher(
            "/seller/orders.jsp"
    ).forward(request, response);
}

private void allOrders(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, ServletException, IOException {

    if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendError(
                HttpServletResponse.SC_FORBIDDEN
        );
        return;
    }

    List<Order> orders =
            orderService.getAllOrders();

    request.setAttribute("orders", orders);

    request.getRequestDispatcher(
            "/admin/orders.jsp"
    ).forward(request, response);
}

private void updateStatus(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    if (!"ADMIN".equalsIgnoreCase(user.getRole())
            && !"SELLER".equalsIgnoreCase(user.getRole())) {

        response.sendError(
                HttpServletResponse.SC_FORBIDDEN
        );
        return;
    }

    int orderId = parseInt(
            request.getParameter("orderId")
    );

    String status =
            request.getParameter("status");

    boolean success =
            orderService.updateOrderStatus(
                    orderId,
                    status
            );

    String page =
            "ADMIN".equalsIgnoreCase(user.getRole())
                    ? "/admin/orders.jsp"
                    : "/seller/orders.jsp";

    response.sendRedirect(
            request.getContextPath()
                    + page
                    + (success
                    ? "?success=Order+updated"
                    : "?error=Update+failed")
    );
}

private void cancelOrder(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    int orderId = parseInt(
            request.getParameter("orderId")
    );

    Order order =
            orderService.getOrderById(orderId);

    if (order == null) {
        response.sendError(
                HttpServletResponse.SC_NOT_FOUND
        );
        return;
    }

    if (order.getUserId() != user.getId()
            && !"ADMIN".equalsIgnoreCase(user.getRole())) {

        response.sendError(
                HttpServletResponse.SC_FORBIDDEN
        );
        return;
    }

    boolean success =
            orderService.updateOrderStatus(
                    orderId,
                    "CANCELLED"
            );

    response.sendRedirect(
            request.getContextPath()
                    + "/buyer/orders.jsp"
                    + (success
                    ? "?success=Order+cancelled"
                    : "?error=Cancellation+failed")
    );
}

private User getUser(
        HttpServletRequest request) {

    HttpSession session =
            request.getSession(false);

    if (session == null) {
        return null;
    }

    Object object =
            session.getAttribute("user");

    return object instanceof User
            ? (User) object
            : null;
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
















