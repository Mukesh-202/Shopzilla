package com.shopzilla.controller;

import com.shopzilla.model.Order;
import com.shopzilla.model.Product;
import com.shopzilla.model.User;
import com.shopzilla.service.OrderService;
import com.shopzilla.service.ProductService;
import com.shopzilla.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

        private UserService userService;
        private ProductService productService;
        private OrderService orderService;

        @Override
        public void init() {
                userService = new UserService();
                productService = new ProductService();
                orderService = new OrderService();
        }

        @Override
        protected void doGet(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                User admin = getUser(request);

                if (!isAdmin(admin)) {
                        response.sendError(
                                        HttpServletResponse.SC_FORBIDDEN,
                                        "Admin access required.");
                        return;
                }

                String action = request.getParameter("action");

                try {

                        if ("users".equalsIgnoreCase(action)) {

                                users(request, response);

                        } else if ("products".equalsIgnoreCase(action)
                                        || "listings".equalsIgnoreCase(action)) {

                                products(request, response);

                        } else if ("orders".equalsIgnoreCase(action)) {

                                orders(request, response);

                        } else if ("dashboard".equalsIgnoreCase(action)
                                        || action == null
                                        || action.trim().isEmpty()) {

                                dashboard(request, response);

                        } else {

                                response.sendError(
                                                HttpServletResponse.SC_BAD_REQUEST,
                                                "Invalid admin action.");
                        }

                } catch (SQLException e) {

                        getServletContext().log(
                                        "Admin error",
                                        e);

                        response.sendError(
                                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                                        "Database error.");
                }
        }

        @Override
        protected void doPost(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                User admin = getUser(request);

                if (!isAdmin(admin)) {
                        response.sendError(
                                        HttpServletResponse.SC_FORBIDDEN,
                                        "Admin access required.");
                        return;
                }

                request.setCharacterEncoding("UTF-8");

                String action = request.getParameter("action");

                try {

                        if ("addProduct".equalsIgnoreCase(action)) {

                                addProduct(request, response);

                        } else if ("updateUserStatus".equalsIgnoreCase(action)) {

                                updateUserStatus(request, response);

                        } else if ("updateProductStatus".equalsIgnoreCase(action)) {

                                updateProductStatus(request, response);

                        } else if ("deleteProduct".equalsIgnoreCase(action)) {

                                deleteProduct(request, response);

                        } else if ("updateOrderStatus".equalsIgnoreCase(action)) {

                                updateOrderStatus(request, response);

                        } else {

                                response.sendError(
                                                HttpServletResponse.SC_BAD_REQUEST,
                                                "Invalid admin action.");
                        }

                } catch (SQLException e) {

                        getServletContext().log(
                                        "Admin update error",
                                        e);

                        response.sendError(
                                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                                        "Database error.");
                }
        }

        private void dashboard(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, ServletException, IOException {

                List<User> users = userService.getAllUsers();

                List<Product> products = productService.getAllProducts();

                List<Order> orders = orderService.getAllOrders();

                request.setAttribute("users", users);
                request.setAttribute("products", products);
                request.setAttribute("orders", orders);

                request.getRequestDispatcher(
                                "/admin/dashboard.jsp")
                                .forward(request, response);
        }

        private void users(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, ServletException, IOException {

                List<User> users = userService.getAllUsers();

                request.setAttribute("users", users);

                request.getRequestDispatcher(
                                "/admin/users.jsp")
                                .forward(request, response);
        }

        private void products(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, ServletException, IOException {

                List<Product> products = productService.getAllProducts();

                request.setAttribute("products", products);

                request.getRequestDispatcher(
                                "/admin/listings.jsp")
                                .forward(request, response);
        }

        private void orders(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, ServletException, IOException {

                List<Order> orders = orderService.getAllOrders();

                request.setAttribute("orders", orders);

                request.getRequestDispatcher(
                                "/admin/orders.jsp")
                                .forward(request, response);
        }

        /*
         * ============================================================
         * ADD PRODUCT
         * ============================================================
         *
         * SKU:
         * Automatically generated.
         *
         * IMAGE:
         * No automatic image is assigned.
         *
         * The website does NOT need:
         * - SKU field
         * - Image URL field
         */

        private void addProduct(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, IOException {

                int sellerId = parseInt(
                                request.getParameter("sellerId"));

                String name = request.getParameter("name");

                String category = request.getParameter("category");

                String subcategory = request.getParameter("subcategory");

                String description = request.getParameter("description");

                double price = parseDouble(
                                request.getParameter("price"));

                double mrp = parseDouble(
                                request.getParameter("mrp"));

                int stock = parseInt(
                                request.getParameter("stock"));

                /*
                 * Validate product details.
                 */

                if (sellerId <= 0
                                || name == null
                                || name.trim().isEmpty()
                                || category == null
                                || category.trim().isEmpty()
                                || price < 0
                                || mrp < 0
                                || stock < 0) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/AdminServlet?action=listings"
                                                        + "&error=Invalid+product+details");

                        return;
                }

                /*
                 * ========================================================
                 * AUTOMATIC SKU
                 * ========================================================
                 */

                String sku = generateSku(name);

                /*
                 * ========================================================
                 * NO AUTOMATIC IMAGE
                 * ========================================================
                 *
                 * Image will be empty.
                 *
                 * You can manually assign the image later.
                 */

                String imageUrl = "";

                Product product = new Product();

                product.setSellerId(sellerId);

                product.setName(
                                name.trim());

                product.setCategory(
                                category.trim());

                product.setSubcategory(
                                subcategory == null
                                                ? ""
                                                : subcategory.trim());

                product.setDescription(
                                description == null
                                                ? ""
                                                : description.trim());

                product.setPrice(price);

                product.setMrp(mrp);

                product.setStock(stock);

                /*
                 * Automatically generated SKU.
                 */
                product.setSku(sku);

                /*
                 * No automatic image.
                 */
                product.setImageUrl(imageUrl);

                /*
                 * Admin products are automatically approved.
                 */
                product.setStatus("APPROVED");

                boolean success = productService.addProduct(product);

                response.sendRedirect(
                                request.getContextPath()
                                                + "/AdminServlet?action=listings"
                                                + (success
                                                                ? "&success=Product+added+successfully"
                                                                : "&error=Unable+to+add+product"));
        }

        /*
         * ============================================================
         * AUTOMATIC SKU GENERATOR
         * ============================================================
         *
         * Examples:
         *
         * Slipper -> SLI-XXXXXXXX
         * Earring -> EAR-XXXXXXXX
         * Coat -> COA-XXXXXXXX
         * Shirt -> SHI-XXXXXXXX
         *
         * Every product gets a different SKU.
         */

        private String generateSku(String productName) {

                if (productName == null
                                || productName.trim().isEmpty()) {

                        productName = "PRO";
                }

                String cleanedName = productName
                                .trim()
                                .toUpperCase()
                                .replaceAll("[^A-Z0-9]", "");

                String prefix;

                if (cleanedName.length() >= 3) {

                        prefix = cleanedName.substring(0, 3);

                } else {

                        prefix = cleanedName;

                        while (prefix.length() < 3) {
                                prefix = prefix + "X";
                        }
                }

                String uniquePart = UUID.randomUUID()
                                .toString()
                                .replace("-", "")
                                .substring(0, 8)
                                .toUpperCase();

                return prefix + "-" + uniquePart;
        }

        /*
         * ============================================================
         * UPDATE USER STATUS
         * ============================================================
         */

        private void updateUserStatus(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, IOException {

                int userId = parseInt(
                                request.getParameter("userId"));

                String status = request.getParameter("status");

                if (userId <= 0
                                || status == null
                                || status.trim().isEmpty()) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/AdminServlet?action=users"
                                                        + "&error=Invalid+details");

                        return;
                }

                boolean success = userService.updateUserStatus(
                                userId,
                                status.trim());

                response.sendRedirect(
                                request.getContextPath()
                                                + "/AdminServlet?action=users"
                                                + (success
                                                                ? "&success=User+status+updated"
                                                                : "&error=Update+failed"));
        }

        /*
         * ============================================================
         * UPDATE PRODUCT STATUS
         * ============================================================
         */

        private void updateProductStatus(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, IOException {

                int productId = parseInt(
                                request.getParameter("productId"));

                String status = request.getParameter("status");

                if (productId <= 0
                                || status == null
                                || status.trim().isEmpty()) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/AdminServlet?action=listings"
                                                        + "&error=Invalid+details");

                        return;
                }

                boolean success = productService.updateProductStatus(
                                productId,
                                status.trim());

                response.sendRedirect(
                                request.getContextPath()
                                                + "/AdminServlet?action=listings"
                                                + (success
                                                                ? "&success=Product+status+updated"
                                                                : "&error=Update+failed"));
        }

        /*
         * ============================================================
         * DELETE PRODUCT
         * ============================================================
         */

        private void deleteProduct(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, IOException {

                int productId = parseInt(
                                request.getParameter("productId"));

                if (productId <= 0) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/AdminServlet?action=listings"
                                                        + "&error=Invalid+product");

                        return;
                }

                boolean success = productService.deleteProduct(productId);

                response.sendRedirect(
                                request.getContextPath()
                                                + "/AdminServlet?action=listings"
                                                + (success
                                                                ? "&success=Product+deleted"
                                                                : "&error=Delete+failed"));
        }

        /*
         * ============================================================
         * UPDATE ORDER STATUS
         * ============================================================
         */

        private void updateOrderStatus(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws SQLException, IOException {

                int orderId = parseInt(
                                request.getParameter("orderId"));

                String status = request.getParameter("status");

                if (orderId <= 0
                                || status == null
                                || status.trim().isEmpty()) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/AdminServlet?action=orders"
                                                        + "&error=Invalid+details");

                        return;
                }

                boolean success = orderService.updateOrderStatus(
                                orderId,
                                status.trim());

                response.sendRedirect(
                                request.getContextPath()
                                                + "/AdminServlet?action=orders"
                                                + (success
                                                                ? "&success=Order+status+updated"
                                                                : "&error=Update+failed"));
        }

        /*
         * ============================================================
         * ADMIN CHECK
         * ============================================================
         */

        private boolean isAdmin(User user) {

                return user != null
                                && "ADMIN".equalsIgnoreCase(
                                                user.getRole());
        }

        /*
         * ============================================================
         * GET LOGGED-IN USER
         * ============================================================
         */

        private User getUser(
                        HttpServletRequest request) {

                HttpSession session = request.getSession(false);

                if (session == null) {
                        return null;
                }

                Object object = session.getAttribute("user");

                return object instanceof User
                                ? (User) object
                                : null;
        }

        /*
         * ============================================================
         * INTEGER PARSER
         * ============================================================
         */

        private int parseInt(String value) {

                try {

                        return Integer.parseInt(
                                        value == null
                                                        ? "0"
                                                        : value);

                } catch (NumberFormatException e) {

                        return 0;
                }
        }

        /*
         * ============================================================
         * DOUBLE PARSER
         * ============================================================
         */

        private double parseDouble(String value) {

                try {

                        return Double.parseDouble(
                                        value == null
                                                        ? "0"
                                                        : value);

                } catch (NumberFormatException e) {

                        return 0.0;
                }
        }
}