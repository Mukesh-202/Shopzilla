package com.shopzilla.service;

import com.shopzilla.dao.ReviewDAO;
import com.shopzilla.model.Review;

import java.util.Collections;
import java.util.List;

public class ReviewService {

    private final ReviewDAO reviewDAO;

    public ReviewService() {
        this.reviewDAO = new ReviewDAO();
    }

    public List<Review> getProductReviews(int productId) {

        if (productId <= 0) {
            return Collections.emptyList();
        }

        return reviewDAO.findByProduct(productId);
    }

    public double getAverageRating(int productId) {

        if (productId <= 0) {
            return 0.0;
        }

        return reviewDAO.getAverageRating(productId);
    }

    public int getReviewCount(int productId) {

        if (productId <= 0) {
            return 0;
        }

        return reviewDAO.getReviewCount(productId);
    }

    public List<Review> getUserReviews(int userId) {

        if (userId <= 0) {
            return Collections.emptyList();
        }

        return reviewDAO.findByUser(userId);
    }

    public boolean addReview(
            int userId,
            int productId,
            int rating,
            String title,
            String comment) {

        if (userId <= 0 || productId <= 0) {
            return false;
        }

        if (rating < 1 || rating > 5) {
            return false;
        }

        if (comment == null
                || comment.trim().isEmpty()) {
            return false;
        }

        Review review = new Review();

        review.setUserId(userId);
        review.setProductId(productId);
        review.setRating(rating);
        review.setTitle(
                title == null ? "" : title.trim()
        );
        review.setComment(comment.trim());

        return reviewDAO.create(review);
    }

    public boolean updateReview(
            int reviewId,
            int userId,
            int rating,
            String title,
            String comment) {

        if (reviewId <= 0 || userId <= 0) {
            return false;
        }

        if (rating < 1 || rating > 5) {
            return false;
        }

        if (comment == null
                || comment.trim().isEmpty()) {
            return false;
        }

        Review review = new Review();

        review.setId(reviewId);
        review.setUserId(userId);
        review.setRating(rating);
        review.setTitle(
                title == null ? "" : title.trim()
        );
        review.setComment(comment.trim());

        return reviewDAO.update(review);
    }

    public boolean deleteReview(
            int reviewId,
            int userId) {

        if (reviewId <= 0 || userId <= 0) {
            return false;
        }

        return reviewDAO.delete(
                reviewId,
                userId
        );
    }
}