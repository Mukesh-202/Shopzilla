package com.shopzilla.controller;
import com.shopzilla.model.Review;
import com.shopzilla.model.User;
import com.shopzilla.service.ReviewService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
public class ReviewServlet extends HttpServlet {
private ReviewService reviewService;

@Override
public void init() {
    reviewService = new ReviewService();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    String action = request.getParameter("action");

    try {

        if ("product".equalsIgnoreCase(action)) {
            productReviews(request, response);

        } else if ("user".equalsIgnoreCase(action)) {
            userReviews(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid review action."
            );
        }

    } catch (SQLException e) {

        getServletContext().log(
                "Review error",
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
                request.getContextPath()
                        + "/auth/login.jsp"
        );
        return;
    }

    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");

    try {

        if ("add".equalsIgnoreCase(action)) {
            addReview(request, response, user);

        } else if ("update".equalsIgnoreCase(action)) {
            updateReview(request, response, user);

        } else if ("delete".equalsIgnoreCase(action)) {
            deleteReview(request, response, user);

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid review action."
            );
        }

    } catch (SQLException e) {

        getServletContext().log(
                "Review update error",
                e
        );

        response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Database error."
        );
    }
}

private void productReviews(
        HttpServletRequest request,
        HttpServletResponse response)
        throws SQLException, ServletException, IOException {

    int productId =
            parseInt(request.getParameter("productId"));

    if (productId <= 0) {
        response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid product ID."
        );
        return;
    }

    List<Review> reviews =
            reviewService.getProductReviews(productId);

    double average =
            reviewService.getAverageRating(productId);

    int count =
            reviewService.getReviewCount(productId);

    request.setAttribute("reviews", reviews);
    request.setAttribute("averageRating", average);
    request.setAttribute("reviewCount", count);
    request.setAttribute("productId", productId);

    request.getRequestDispatcher(
            "/buyer/reviews.jsp"
    ).forward(request, response);
}

private void userReviews(
        HttpServletRequest request,
        HttpServletResponse response)
        throws SQLException, ServletException, IOException {

    User user = getUser(request);

    if (user == null) {
        response.sendRedirect(
                request.getContextPath()
                        + "/auth/login.jsp"
        );
        return;
    }

    List<Review> reviews =
            reviewService.getUserReviews(
                    user.getId()
            );

    request.setAttribute("reviews", reviews);

    request.getRequestDispatcher(
            "/buyer/reviews.jsp"
    ).forward(request, response);
}

private void addReview(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    int productId =
            parseInt(request.getParameter("productId"));

    int rating =
            parseInt(request.getParameter("rating"));

    String title =
            request.getParameter("title");

    String comment =
            request.getParameter("comment");

    boolean success =
            reviewService.addReview(
                    user.getId(),
                    productId,
                    rating,
                    title,
                    comment
            );

    response.sendRedirect(
            request.getContextPath()
                    + "/ReviewServlet?action=product"
                    + "&productId="
                    + productId
                    + (success
                    ? "&success=Review+added"
                    : "&error=Unable+to+add+review")
    );
}

private void updateReview(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    int reviewId =
            parseInt(request.getParameter("reviewId"));

    int productId =
            parseInt(request.getParameter("productId"));

    int rating =
            parseInt(request.getParameter("rating"));

    String title =
            request.getParameter("title");

    String comment =
            request.getParameter("comment");

    boolean success =
            reviewService.updateReview(
                    reviewId,
                    user.getId(),
                    rating,
                    title,
                    comment
            );

    response.sendRedirect(
            request.getContextPath()
                    + "/ReviewServlet?action=product"
                    + "&productId="
                    + productId
                    + (success
                    ? "&success=Review+updated"
                    : "&error=Update+failed")
    );
}

private void deleteReview(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    int reviewId =
            parseInt(request.getParameter("reviewId"));

    int productId =
            parseInt(request.getParameter("productId"));

    boolean success =
            reviewService.deleteReview(
                    reviewId,
                    user.getId()
            );

    response.sendRedirect(
            request.getContextPath()
                    + "/ReviewServlet?action=product"
                    + "&productId="
                    + productId
                    + (success
                    ? "&success=Review+deleted"
                    : "&error=Delete+failed")
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