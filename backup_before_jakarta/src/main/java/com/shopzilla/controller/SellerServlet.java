package com.shopzilla.controller;
import com.shopzilla.model.Product;
import com.shopzilla.model.User;
import com.shopzilla.service.ProductService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
public class SellerServlet extends HttpServlet {
private ProductService productService;

@Override
public void init() {
    productService = new ProductService();
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

    if (!"SELLER".equalsIgnoreCase(user.getRole())) {
        response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Seller access required."
        );
        return;
    }

    String action = request.getParameter("action");

    try {

        if ("products".equalsIgnoreCase(action)) {
            products(request, response, user);

        } else if ("edit".equalsIgnoreCase(action)) {
            editProduct(request, response, user);

        } else if ("delete".equalsIgnoreCase(action)) {
            deleteProduct(request, response, user);

        } else {

            products(request, response, user);
        }

    } catch (SQLException e) {

        getServletContext().log(
                "Seller error",
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

    if (!"SELLER".equalsIgnoreCase(user.getRole())) {
        response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Seller access required."
        );
        return;
    }

    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");

    try {

        if ("add".equalsIgnoreCase(action)) {

            addProduct(request, response, user);

        } else if ("update".equalsIgnoreCase(action)) {

            updateProduct(request, response, user);

        } else if ("delete".equalsIgnoreCase(action)) {

            deleteProduct(request, response, user);

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid seller action."
            );
        }

    } catch (SQLException e) {

        getServletContext().log(
                "Seller operation error",
                e
        );

        response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Database error."
        );
    }
}

private void products(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, ServletException, IOException {

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

private void editProduct(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
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

    Product product =
            productService.getProductById(productId);

    if (product == null) {
        response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Product not found."
        );
        return;
    }

    if (product.getSellerId() != user.getId()) {
        response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "You can edit only your own products."
        );
        return;
    }

    request.setAttribute(
            "product",
            product
    );

    request.getRequestDispatcher(
            "/seller/edit-product.jsp"
    ).forward(request, response);
}

private void addProduct(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    String name =
            request.getParameter("name");

    String description =
            request.getParameter("description");

    String category =
            request.getParameter("category");

    String subcategory =
            request.getParameter("subcategory");

    double price =
            parseDouble(request.getParameter("price"));

    int stock =
            parseInt(request.getParameter("stock"));

    String imageUrl =
            request.getParameter("imageUrl");

    if (name == null || name.trim().isEmpty()
            || price <= 0
            || stock < 0) {

        response.sendRedirect(
                request.getContextPath()
                        + "/seller/add-product.jsp"
                        + "?error=Invalid+product+details"
        );
        return;
    }

    Product product = new Product();

    product.setSellerId(user.getId());
    product.setName(name.trim());
    product.setDescription(
            description == null ? "" : description.trim()
    );
    product.setCategory(
            category == null ? "" : category.trim()
    );
    product.setSubcategory(
            subcategory == null ? "" : subcategory.trim()
    );
    product.setPrice(price);
    product.setStock(stock);
    product.setImageUrl(
            imageUrl == null ? "" : imageUrl.trim()
    );

    boolean success =
            productService.addProduct(product);

    response.sendRedirect(
            request.getContextPath()
                    + "/SellerServlet?action=products"
                    + (success
                    ? "&success=Product+added"
                    : "&error=Unable+to+add+product")
    );
}

private void updateProduct(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    int productId =
            parseInt(request.getParameter("productId"));

    Product product =
            productService.getProductById(productId);

    if (product == null) {
        response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Product not found."
        );
        return;
    }

    if (product.getSellerId() != user.getId()) {
        response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "You can update only your own products."
        );
        return;
    }

    String name =
            request.getParameter("name");

    String description =
            request.getParameter("description");

    String category =
            request.getParameter("category");

    String subcategory =
            request.getParameter("subcategory");

    double price =
            parseDouble(request.getParameter("price"));

    int stock =
            parseInt(request.getParameter("stock"));

    String imageUrl =
            request.getParameter("imageUrl");

    if (name == null || name.trim().isEmpty()
            || price <= 0
            || stock < 0) {

        response.sendRedirect(
                request.getContextPath()
                        + "/SellerServlet?action=edit"
                        + "&productId="
                        + productId
                        + "&error=Invalid+product+details"
        );
        return;
    }

    product.setName(name.trim());
    product.setDescription(
            description == null ? "" : description.trim()
    );
    product.setCategory(
            category == null ? "" : category.trim()
    );
    product.setSubcategory(
            subcategory == null ? "" : subcategory.trim()
    );
    product.setPrice(price);
    product.setStock(stock);
    product.setImageUrl(
            imageUrl == null ? "" : imageUrl.trim()
    );

    boolean success =
            productService.updateProduct(product);

    response.sendRedirect(
            request.getContextPath()
                    + "/SellerServlet?action=products"
                    + (success
                    ? "&success=Product+updated"
                    : "&error=Update+failed")
    );
}

private void deleteProduct(
        HttpServletRequest request,
        HttpServletResponse response,
        User user)
        throws SQLException, IOException {

    int productId =
            parseInt(request.getParameter("productId"));

    Product product =
            productService.getProductById(productId);

    if (product == null) {
        response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Product not found."
        );
        return;
    }

    if (product.getSellerId() != user.getId()) {
        response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "You can delete only your own products."
        );
        return;
    }

    boolean success =
            productService.deleteProduct(productId);

    response.sendRedirect(
            request.getContextPath()
                    + "/SellerServlet?action=products"
                    + (success
                    ? "&success=Product+deleted"
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

private double parseDouble(String value) {

    try {
        return Double.parseDouble(
                value == null ? "0" : value
        );
    } catch (NumberFormatException e) {
        return 0.0;
    }
}
}