package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public int create(Review review) throws SQLException {

        String sql =
                "INSERT INTO reviews " +
                "(user_id, product_id, rating, title, comment) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, review.getUserId());
            statement.setInt(2, review.getProductId());
            statement.setInt(3, review.getRating());
            statement.setString(4, review.getTitle());
            statement.setString(5, review.getComment());

            statement.executeUpdate();

            try (ResultSet rs = statement.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    review.setId(id);
                    return id;
                }
            }
        }

        return -1;
    }

    public Review findById(int id) throws SQLException {

        String sql =
                "SELECT r.*, u.name AS user_name, " +
                "p.name AS product_name " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "JOIN products p ON r.product_id = p.id " +
                "WHERE r.id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapReview(rs);
                }
            }
        }

        return null;
    }

    public List<Review> findByProductId(int productId)
            throws SQLException {

        String sql =
                "SELECT r.*, u.name AS user_name, " +
                "p.name AS product_name " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "JOIN products p ON r.product_id = p.id " +
                "WHERE r.product_id = ? " +
                "ORDER BY r.id DESC";

        List<Review> reviews = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    reviews.add(mapReview(rs));
                }
            }
        }

        return reviews;
    }

    public List<Review> findByUserId(int userId)
            throws SQLException {

        String sql =
                "SELECT r.*, u.name AS user_name, " +
                "p.name AS product_name " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "JOIN products p ON r.product_id = p.id " +
                "WHERE r.user_id = ? " +
                "ORDER BY r.id DESC";

        List<Review> reviews = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    reviews.add(mapReview(rs));
                }
            }
        }

        return reviews;
    }

    public boolean update(Review review) throws SQLException {

        String sql =
                "UPDATE reviews SET rating = ?, title = ?, " +
                "comment = ? " +
                "WHERE id = ? AND user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, review.getRating());
            statement.setString(2, review.getTitle());
            statement.setString(3, review.getComment());
            statement.setInt(4, review.getId());
            statement.setInt(5, review.getUserId());

            return statement.executeUpdate() > 0;
        }
    }

    public boolean delete(int id, int userId)
            throws SQLException {

        String sql =
                "DELETE FROM reviews " +
                "WHERE id = ? AND user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            statement.setInt(2, userId);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean exists(int userId, int productId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) FROM reviews " +
                "WHERE user_id = ? AND product_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            try (ResultSet rs = statement.executeQuery()) {

                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    public double getAverageRating(int productId)
            throws SQLException {

        String sql =
                "SELECT COALESCE(AVG(rating), 0) " +
                "FROM reviews WHERE product_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        }

        return 0.0;
    }

    public int getReviewCount(int productId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) FROM reviews " +
                "WHERE product_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }

    public List<Review> findAll() throws SQLException {

        String sql =
                "SELECT r.*, u.name AS user_name, " +
                "p.name AS product_name " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "JOIN products p ON r.product_id = p.id " +
                "ORDER BY r.id DESC";

        List<Review> reviews = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                reviews.add(mapReview(rs));
            }
        }

        return reviews;
    }

    private Review mapReview(ResultSet rs) throws SQLException {

        Review review = new Review();

        review.setId(rs.getInt("id"));
        review.setUserId(rs.getInt("user_id"));
        review.setProductId(rs.getInt("product_id"));
        review.setRating(rs.getInt("rating"));
        review.setTitle(rs.getString("title"));
        review.setComment(rs.getString("comment"));
        review.setCreatedAt(rs.getString("created_at"));
        review.setUserName(rs.getString("user_name"));
        review.setProductName(rs.getString("product_name"));

        return review;
    }
}