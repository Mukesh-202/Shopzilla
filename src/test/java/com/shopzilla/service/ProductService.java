package com.shopzilla.service;

import com.shopzilla.dao.ProductDAO;
import com.shopzilla.model.Product;

import java.sql.SQLException;
import java.util.List;

public class ProductService {

    private final ProductDAO productDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    public Product getProductById(int id) throws SQLException {
        if (id <= 0) {
            return null;
        }

        return productDAO.findById(id);
    }

    public List<Product> getAllProducts() throws SQLException {
        return productDAO.findAll();
    }

    public List<Product> getApprovedProducts() throws SQLException {
        return productDAO.findApprovedProducts();
    }

    public List<Product> getProductsByCategory(String category)
            throws SQLException {

        if (category == null || category.trim().isEmpty()) {
            return getApprovedProducts();
        }

        return productDAO.findByCategory(category.trim());
    }

    public List<Product> getProductsBySubcategory(String subcategory)
            throws SQLException {

        if (subcategory == null || subcategory.trim().isEmpty()) {
            return getApprovedProducts();
        }

        return productDAO.findBySubcategory(subcategory.trim());
    }

    public List<Product> searchProducts(String keyword)
            throws SQLException {

        if (keyword == null || keyword.trim().isEmpty()) {
            return getApprovedProducts();
        }

        return productDAO.search(keyword.trim());
    }

    public List<Product> getProductsBySeller(int sellerId)
            throws SQLException {

        if (sellerId <= 0) {
            return List.of();
        }

        return productDAO.findBySeller(sellerId);
    }

    public boolean addProduct(Product product) throws SQLException {

        if (!isValidProduct(product)) {
            return false;
        }

        if (product.getStatus() == null ||
                product.getStatus().trim().isEmpty()) {

            product.setStatus("PENDING");
        }

        return productDAO.create(product) > 0;
    }

    public boolean updateProduct(Product product) throws SQLException {

        if (!isValidProduct(product) || product.getId() <= 0) {
            return false;
        }

        return productDAO.update(product);
    }

    public boolean deleteProduct(int id) throws SQLException {

        if (id <= 0) {
            return false;
        }

        return productDAO.delete(id);
    }

    public boolean approveProduct(int id) throws SQLException {

        if (id <= 0) {
            return false;
        }

        return productDAO.updateStatus(id, "APPROVED");
    }

    public boolean rejectProduct(int id) throws SQLException {

        if (id <= 0) {
            return false;
        }

        return productDAO.updateStatus(id, "REJECTED");
    }

    public boolean updateProductStatus(
            int id,
            String status) throws SQLException {

        if (id <= 0 ||
                status == null ||
                status.trim().isEmpty()) {

            return false;
        }

        String normalizedStatus = status.trim().toUpperCase();

        if (!normalizedStatus.equals("PENDING") &&
                !normalizedStatus.equals("APPROVED") &&
                !normalizedStatus.equals("REJECTED")) {

            return false;
        }

        return productDAO.updateStatus(id, normalizedStatus);
    }

    private boolean isValidProduct(Product product) {

        if (product == null) {
            return false;
        }

        if (product.getSellerId() <= 0) {
            return false;
        }

        if (product.getName() == null ||
                product.getName().trim().isEmpty()) {
            return false;
        }

        if (product.getCategory() == null ||
                product.getCategory().trim().isEmpty()) {
            return false;
        }

        if (product.getPrice() < 0 ||
                product.getMrp() < 0 ||
                product.getStock() < 0) {
            return false;
        }

        return true;
    }
}