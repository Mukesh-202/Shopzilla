package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public Product findById(int id) throws SQLException {

        String sql = "SELECT * FROM products WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }
        }

        return null;
    }

    public List<Product> findAll() throws SQLException {

        String sql = "SELECT * FROM products ORDER BY id DESC";

        List<Product> products = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }

        return products;
    }

    public List<Product> findApprovedProducts() throws SQLException {

        String sql = "SELECT * FROM products " +
                     "WHERE status = 'APPROVED' " +
                     "ORDER BY id DESC";

        List<Product> products = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }

        return products;
    }

    public List<Product> findByCategory(String category) throws SQLException {

        String sql = "SELECT * FROM products " +
                     "WHERE category = ? AND status = 'APPROVED' " +
                     "ORDER BY id DESC";

        List<Product> products = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, category);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    public List<Product> findBySubcategory(String subcategory)
            throws SQLException {

        String sql = "SELECT * FROM products " +
                     "WHERE subcategory = ? AND status = 'APPROVED' " +
                     "ORDER BY id DESC";

        List<Product> products = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, subcategory);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    public List<Product> search(String keyword) throws SQLException {

        String sql = "SELECT * FROM products " +
                     "WHERE status = 'APPROVED' " +
                     "AND (name LIKE ? OR category LIKE ? " +
                     "OR subcategory LIKE ? OR description LIKE ?) " +
                     "ORDER BY id DESC";

        List<Product> products = new ArrayList<>();

        String search = "%" + keyword + "%";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, search);
            statement.setString(2, search);
            statement.setString(3, search);
            statement.setString(4, search);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    public List<Product> findBySeller(int sellerId) throws SQLException {

        String sql = "SELECT * FROM products " +
                     "WHERE seller_id = ? ORDER BY id DESC";

        List<Product> products = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, sellerId);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    public int create(Product product) throws SQLException {

        String sql = "INSERT INTO products " +
                     "(seller_id, name, category, subcategory, description, " +
                     "price, mrp, stock, sku, image_url, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, product.getSellerId());
            statement.setString(2, product.getName());
            statement.setString(3, product.getCategory());
            statement.setString(4, product.getSubcategory());
            statement.setString(5, product.getDescription());
            statement.setDouble(6, product.getPrice());
            statement.setDouble(7, product.getMrp());
            statement.setInt(8, product.getStock());
            statement.setString(9, product.getSku());
            statement.setString(10, product.getImageUrl());
            statement.setString(11, product.getStatus());

            statement.executeUpdate();

            try (ResultSet rs = statement.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    product.setId(id);
                    return id;
                }
            }
        }

        return -1;
    }

    public boolean update(Product product) throws SQLException {

        String sql = "UPDATE products SET " +
                     "name = ?, category = ?, subcategory = ?, " +
                     "description = ?, price = ?, mrp = ?, stock = ?, " +
                     "sku = ?, image_url = ?, status = ?, " +
                     "updated_at = CURRENT_TIMESTAMP " +
                     "WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, product.getName());
            statement.setString(2, product.getCategory());
            statement.setString(3, product.getSubcategory());
            statement.setString(4, product.getDescription());
            statement.setDouble(5, product.getPrice());
            statement.setDouble(6, product.getMrp());
            statement.setInt(7, product.getStock());
            statement.setString(8, product.getSku());
            statement.setString(9, product.getImageUrl());
            statement.setString(10, product.getStatus());
            statement.setInt(11, product.getId());

            return statement.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {

        String sql = "DELETE FROM products WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(int id, String status)
            throws SQLException {

        String sql = "UPDATE products SET " +
                     "status = ?, updated_at = CURRENT_TIMESTAMP " +
                     "WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, id);

            return statement.executeUpdate() > 0;
        }
    }

    private Product mapProduct(ResultSet rs) throws SQLException {

        Product product = new Product();

        product.setId(rs.getInt("id"));
        product.setSellerId(rs.getInt("seller_id"));
        product.setName(rs.getString("name"));
        product.setCategory(rs.getString("category"));
        product.setSubcategory(rs.getString("subcategory"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setMrp(rs.getDouble("mrp"));
        product.setStock(rs.getInt("stock"));
        product.setSku(rs.getString("sku"));
        product.setImageUrl(rs.getString("image_url"));
        product.setStatus(rs.getString("status"));

        return product;
    }
}