package com.shopzilla.controller;

import com.shopzilla.model.Product;
import com.shopzilla.model.User;
import com.shopzilla.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        try {

            switch (action.toLowerCase()) {

                case "list":
                    listProducts(request, response);
                    break;

                case "category":
                    categoryProducts(request, response);
                    break;

                case "search":
                    searchProducts(request, response);
                    break;

                case "view":
                    viewProduct(request, response);
                    break;

                case "seller":
                    sellerProducts(request, response);
                    break;

                default:
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid product action."
                    );
                    break;
            }

        } catch (SQLException e) {

            getServletContext().log(
                    "Product GET database error",
                    e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error."
            );
        }
    }

    private void listProducts(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<Product> products =
                productService.getApprovedProducts();

        request.setAttribute(
                "products",
                products
        );

        request.getRequestDispatcher(
                "/buyer/products.jsp"
        ).forward(request, response);
    }

    private void categoryProducts(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String category =
                request.getParameter("category");

        if (category == null || category.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Category is required."
            );

            return;
        }

        List<Product> products =
                productService.getProductsByCategory(
                        category.trim()
                );

        request.setAttribute(
                "products",
                products
        );

        request.setAttribute(
                "selectedCategory",
                category.trim()
        );

        request.getRequestDispatcher(
                "/buyer/products.jsp"
        ).forward(request, response);
    }

    private void searchProducts(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        if (keyword == null) {
            keyword = "";
        }

        keyword = keyword.trim();

        List<Product> products =
                productService.searchProducts(
                        keyword
                );

        request.setAttribute(
                "products",
                products
        );

        request.setAttribute(
                "searchKeyword",
                keyword
        );

        request.getRequestDispatcher(
                "/buyer/products.jsp"
        ).forward(request, response);
    }

    private void viewProduct(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id =
                parseInt(
                        request.getParameter("id")
                );

        if (id <= 0) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID."
            );

            return;
        }

        Product product =
                productService.getProductById(id);

        if (product == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Product not found."
            );

            return;
        }

        request.setAttribute(
                "product",
                product
        );

        request.getRequestDispatcher(
                "/buyer/product-details.jsp"
        ).forward(request, response);
    }

    private void sellerProducts(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );

            return;
        }

        User user =
                getLoggedInUser(request);

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );

            return;
        }

        if (!"SELLER".equalsIgnoreCase(
                user.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Seller access required."
            );

            return;
        }

        List<Product> products =
                productService.getProductsBySeller(
                        user.getId()
                );

        request.setAttribute(
                "products",
                products
        );

        request.getRequestDispatcher(
                "/seller/dashboard.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action =
                request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Action required."
            );

            return;
        }

        try {

            switch (action.toLowerCase()) {

                case "add":
                    addProduct(request, response);
                    break;

                case "update":
                    updateProduct(request, response);
                    break;

                case "delete":
                    deleteProduct(request, response);
                    break;

                case "approve":
                    updateStatus(
                            request,
                            response,
                            "APPROVED"
                    );
                    break;

                case "reject":
                    updateStatus(
                            request,
                            response,
                            "REJECTED"
                    );
                    break;

                default:
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid product action."
                    );
                    break;
            }

        } catch (SQLException e) {

            getServletContext().log(
                    "Product POST database error",
                    e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error."
            );
        }
    }

    private void addProduct(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {

        User seller =
                getLoggedInUser(request);

        if (seller == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );

            return;
        }

        if (!"SELLER".equalsIgnoreCase(
                seller.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Seller access required."
            );

            return;
        }

        Product product =
                createProductFromRequest(request);

        product.setSellerId(
                seller.getId()
        );

        product.setStatus("PENDING");

        boolean success =
                productService.addProduct(product);

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/seller/dashboard.jsp?success=Product+added"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/seller/add-product.jsp?error=Unable+to+add+product"
            );
        }
    }

    private void updateProduct(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {

        User seller =
                getLoggedInUser(request);

        if (seller == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );

            return;
        }

        int id =
                parseInt(
                        request.getParameter("id")
                );

        if (id <= 0) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID."
            );

            return;
        }

        Product existing =
                productService.getProductById(id);

        if (existing == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Product not found."
            );

            return;
        }

        boolean isAdmin =
                "ADMIN".equalsIgnoreCase(
                        seller.getRole()
                );

        boolean isOwner =
                "SELLER".equalsIgnoreCase(
                        seller.getRole()
                )
                && existing.getSellerId()
                == seller.getId();

        if (!isAdmin && !isOwner) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "You cannot update this product."
            );

            return;
        }

        Product product =
                createProductFromRequest(request);

        product.setId(id);

        product.setSellerId(
                existing.getSellerId()
        );

        product.setStatus(
                existing.getStatus()
        );

        boolean success =
                productService.updateProduct(product);

        response.sendRedirect(
                request.getContextPath()
                        + "/seller/dashboard.jsp?"
                        + (
                        success
                                ? "success=Product+updated"
                                : "error=Update+failed"
                )
        );
    }

    private void deleteProduct(
            HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {

        User user =
                getLoggedInUser(request);

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );

            return;
        }

        int id =
                parseInt(
                        request.getParameter("id")
                );

        if (id <= 0) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID."
            );

            return;
        }

        Product product =
                productService.getProductById(id);

        if (product == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Product not found."
            );

            return;
        }

        boolean isAdmin =
                "ADMIN".equalsIgnoreCase(
                        user.getRole()
                );

        boolean isOwner =
                "SELLER".equalsIgnoreCase(
                        user.getRole()
                )
                && product.getSellerId()
                == user.getId();

        if (!isAdmin && !isOwner) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "You cannot delete this product."
            );

            return;
        }

        boolean success =
                productService.deleteProduct(id);

        String redirectPage =
                isAdmin
                        ? "/admin/listings.jsp"
                        : "/seller/dashboard.jsp";

        response.sendRedirect(
                request.getContextPath()
                        + redirectPage
                        + "?"
                        + (
                        success
                                ? "success=Product+deleted"
                                : "error=Delete+failed"
                )
        );
    }

    private void updateStatus(
            HttpServletRequest request,
            HttpServletResponse response,
            String status)
            throws SQLException, IOException {

        User admin =
                getLoggedInUser(request);

        if (admin == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/auth/login.jsp"
            );

            return;
        }

        if (!"ADMIN".equalsIgnoreCase(
                admin.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Admin access required."
            );

            return;
        }

        int id =
                parseInt(
                        request.getParameter("id")
                );

        if (id <= 0) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID."
            );

            return;
        }

        boolean success =
                productService.updateProductStatus(
                        id,
                        status
                );

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/listings.jsp?"
                        + (
                        success
                                ? "success=Status+updated"
                                : "error=Status+update+failed"
                )
        );
    }

    private Product createProductFromRequest(
            HttpServletRequest request) {

        Product product =
                new Product();

        product.setName(
                safeValue(
                        request.getParameter("name")
                )
        );

        product.setCategory(
                safeValue(
                        request.getParameter("category")
                )
        );

        product.setSubcategory(
                safeValue(
                        request.getParameter("subcategory")
                )
        );

        product.setDescription(
                safeValue(
                        request.getParameter("description")
                )
        );

        product.setPrice(
                parseDouble(
                        request.getParameter("price")
                )
        );

        product.setMrp(
                parseDouble(
                        request.getParameter("mrp")
                )
        );

        product.setStock(
                parseInt(
                        request.getParameter("stock")
                )
        );

        product.setSku(
                safeValue(
                        request.getParameter("sku")
                )
        );

        product.setImageUrl(
                safeValue(
                        request.getParameter("imageUrl")
                )
        );

        return product;
    }

    private User getLoggedInUser(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return null;
        }

        Object object =
                session.getAttribute("user");

        if (object instanceof User) {
            return (User) object;
        }

        return null;
    }

    private String safeValue(String value) {

        if (value == null) {
            return "";
        }

        return value.trim();
    }

    private int parseInt(String value) {

        if (value == null || value.trim().isEmpty()) {
            return 0;
        }

        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private double parseDouble(String value) {

        if (value == null || value.trim().isEmpty()) {
            return 0.0;
        }

        try {
            return Double.parseDouble(value.trim());
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }
}
