package com.shopzilla.service;

import com.shopzilla.dao.ProductDAO;
import com.shopzilla.model.Product;

import java.util.List;

public class ProductService {

    private final ProductDAO productDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    public List<Product> getAllProducts() {
        return productDAO.findAll();
    }

    public List<Product> getApprovedProducts() {
        return productDAO.findApproved();
    }

    public Product getProductById(int id) {
        return productDAO.findById(id);
    }

    public List<Product> getProductsByCategory(String category) {
        return productDAO.findByCategory(category);
    }

    public List<Product> getProductsBySubcategory(String subcategory) {
        return productDAO.findBySubcategory(subcategory);
    }

    public List<Product> searchProducts(String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {
            return getApprovedProducts();
        }

        return productDAO.search(
                keyword.trim()
        );
    }

    public List<Product> getProductsBySeller(int sellerId) {
        return productDAO.findBySeller(sellerId);
    }

    public boolean addProduct(Product product) {

        if (product == null) {
            return false;
        }

        if (product.getName() == null
                || product.getName().trim().isEmpty()) {
            return false;
        }

        if (product.getPrice() < 0
                || product.getStock() < 0) {
            return false;
        }

        return productDAO.create(product);
    }

    public boolean updateProduct(Product product) {

        if (product == null
                || product.getId() <= 0) {
            return false;
        }

        if (product.getName() == null
                || product.getName().trim().isEmpty()) {
            return false;
        }

        if (product.getPrice() < 0
                || product.getStock() < 0) {
            return false;
        }

        return productDAO.update(product);
    }

    public boolean deleteProduct(int productId) {

        if (productId <= 0) {
            return false;
        }

        return productDAO.delete(productId);
    }

    public boolean updateProductStatus(
            int productId,
            String status) {

        if (productId <= 0
                || status == null
                || status.trim().isEmpty()) {
            return false;
        }

        return productDAO.updateStatus(
                productId,
                status.trim().toUpperCase()
        );
    }
}