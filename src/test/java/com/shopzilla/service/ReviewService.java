package com.shopzilla.service;

import com.shopzilla.dao.ReviewDAO;
import com.shopzilla.dao.ProductDAO;
import com.shopzilla.model.Review;
import com.shopzilla.model.Product;

import java.sql.SQLException;
import java.util.List;

public class ReviewService {

    private final ReviewDAO reviewDAO;
    private final ProductDAO productDAO;

    public ReviewService() {
        this.reviewDAO = new ReviewDAO();
        this.productDAO = new ProductDAO();
    }

    public boolean addReview(
            int userId,
            int productId,
            int rating,
            String title,
            String comment) throws SQLException {

        if (userId <= 0 || productId <= 0) {
            return false;
        }

        if (rating < 1 || rating > 5) {
            return false;
        }

        Product product = productDAO.findById(productId);

        if (product == null) {
            return false;
        }

        if (reviewDAO.exists(userId, productId)) {
            return false;
        }

        Review review = new Review(
                userId,
                productId,
                rating,
                title,
                comment
        );

        return reviewDAO.create(review) > 0;
    }

    public Review getReviewById(int id)
            throws SQLException {

        if (id <= 0) {
            return null;
        }

        return reviewDAO.findById(id);
    }

    public List<Review> getProductReviews(int productId)
            throws SQLException {

        if (productId <= 0) {
            return List.of();
        }

        return reviewDAO.findByProductId(productId);
    }

    public List<Review> getUserReviews(int userId)
            throws SQLException {

        if (userId <= 0) {
            return List.of();
        }

        return reviewDAO.findByUserId(userId);
    }

    public List<Review> getAllReviews()
            throws SQLException {

        return reviewDAO.findAll();
    }

    public double getAverageRating(int productId)
            throws SQLException {

        if (productId <= 0) {
            return 0.0;
        }

        return reviewDAO.getAverageRating(productId);
    }

    public int getReviewCount(int productId)
            throws SQLException {

        if (productId <= 0) {
            return 0;
        }

        return reviewDAO.getReviewCount(productId);
    }

    public boolean updateReview(
            int reviewId,
            int userId,
            int rating,
            String title,
            String comment) throws SQLException {

        if (reviewId <= 0 || userId <= 0) {
            return false;
        }

        if (rating < 1 || rating > 5) {
            return false;
        }

        Review review = new Review();

        review.setId(reviewId);
        review.setUserId(userId);
        review.setRating(rating);
        review.setTitle(title);
        review.setComment(comment);

        return reviewDAO.update(review);
    }

    public boolean deleteReview(
            int reviewId,
            int userId) throws SQLException {

        if (reviewId <= 0 || userId <= 0) {
            return false;
        }

        return reviewDAO.delete(reviewId, userId);
    }
}