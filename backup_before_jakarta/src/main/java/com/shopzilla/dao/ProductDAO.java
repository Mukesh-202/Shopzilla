package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Connection getConnection() throws SQLException {
        return DatabaseConfig.getConnection();
    }

    public List<Product> findAll() {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products ORDER BY id DESC";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> findApproved() {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT * FROM products
                WHERE status = 'APPROVED'
                ORDER BY id DESC
                """;

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product findById(int id) {

        String sql = "SELECT * FROM products WHERE id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapProduct(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Product> findByCategory(String category) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT * FROM products
                WHERE category = ?
                ORDER BY id DESC
                """;

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> findBySubcategory(String subcategory) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT * FROM products
                WHERE subcategory = ?
                ORDER BY id DESC
                """;

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, subcategory);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> search(String keyword) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT * FROM products
                WHERE name LIKE ?
                   OR category LIKE ?
                   OR subcategory LIKE ?
                   OR description LIKE ?
                   OR sku LIKE ?
                ORDER BY id DESC
                """;

        String search = "%" + keyword + "%";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);
            ps.setString(5, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> findBySeller(int sellerId) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT * FROM products
                WHERE seller_id = ?
                ORDER BY id DESC
                """;

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, sellerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public boolean create(Product product) {

        String sql = """
                INSERT INTO products
                (seller_id, name, category, subcategory, description,
                 price, mrp, stock, sku, image_url, status)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(
                        sql,
                        Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, product.getSellerId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getCategory());
            ps.setString(4, product.getSubcategory());
            ps.setString(5, product.getDescription());
            ps.setDouble(6, product.getPrice());
            ps.setDouble(7, product.getMrp());
            ps.setInt(8, product.getStock());
            ps.setString(9, product.getSku());
            ps.setString(10, product.getImageUrl());
            ps.setString(11, product.getStatus());

            int rows = ps.executeUpdate();

            if (rows == 0) {
                return false;
            }

            try (ResultSet keys = ps.getGeneratedKeys()) {

                if (keys.next()) {
                    product.setId(keys.getInt(1));
                }
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Product product) {

        String sql = """
                UPDATE products
                SET seller_id = ?,
                    name = ?,
                    category = ?,
                    subcategory = ?,
                    description = ?,
                    price = ?,
                    mrp = ?,
                    stock = ?,
                    sku = ?,
                    image_url = ?,
                    status = ?
                WHERE id = ?
                """;

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, product.getSellerId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getCategory());
            ps.setString(4, product.getSubcategory());
            ps.setString(5, product.getDescription());
            ps.setDouble(6, product.getPrice());
            ps.setDouble(7, product.getMrp());
            ps.setInt(8, product.getStock());
            ps.setString(9, product.getSku());
            ps.setString(10, product.getImageUrl());
            ps.setString(11, product.getStatus());
            ps.setInt(12, product.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int productId) {

        String sql = "DELETE FROM products WHERE id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatus(int productId, String status) {

        String sql = """
                UPDATE products
                SET status = ?
                WHERE id = ?
                """;

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, productId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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