<%@ page import="java.util.List" %>
<%@ page import="com.shopzilla.model.Product" %>
<%@ page import="com.shopzilla.model.User" %>
<%@ page import="com.shopzilla.service.ProductService" %>
<%@ page import="com.shopzilla.service.UserService" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%!
    private String esc(String value) {
        if (value == null) return "";

        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    private String money(double value) {
        return String.format("₹%.2f", value);
    }
%>

<%
    String ctx = request.getContextPath();

    ProductService productService = new ProductService();
    UserService userService = new UserService();

    List<Product> products = productService.getAllProducts();
    List<User> users = userService.getAllUsers();

    int total = products.size();
    int approved = 0;
    int pending = 0;
    int rejected = 0;

    for (Product p : products) {
        String status = p.getStatus();

        if ("APPROVED".equalsIgnoreCase(status)) {
            approved++;
        } else if ("REJECTED".equalsIgnoreCase(status)) {
            rejected++;
        } else {
            pending++;
        }
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Listings | Shopzilla Admin</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="<%= ctx %>/css/style.css">

    <link rel="stylesheet"
          href="<%= ctx %>/css/navbar.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f6f6f6;
            color: #222;
            font-family: Arial, Helvetica, sans-serif;
        }

        .listings-page {
            max-width: 1450px;
            margin: auto;
            padding: 35px 30px 70px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 25px;
        }

        .page-header h1 {
            margin: 0 0 7px;
            font-size: 32px;
        }

        .page-header p {
            margin: 0;
            color: #777;
            font-size: 14px;
        }

        .back-btn,
        .add-btn {
            text-decoration: none;
            background: #111;
            color: #fff;
            padding: 12px 18px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 600;
            border: 0;
            cursor: pointer;
        }

        .back-btn:hover,
        .add-btn:hover {
            background: #333;
        }

        .message {
            padding: 13px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 20px;
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 17px;
        }

        .stat-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #f1f1f1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .stat-card span {
            display: block;
            color: #888;
            font-size: 12px;
            margin-bottom: 6px;
        }

        .stat-card strong {
            font-size: 25px;
        }

        .listings-panel {
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            overflow: hidden;
        }

        .panel-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .panel-title h2 {
            margin: 0 0 5px;
            font-size: 17px;
        }

        .panel-title p {
            margin: 0;
            color: #888;
            font-size: 11px;
        }

        .search-box {
            width: 350px;
        }

        .search-box input {
            width: 100%;
            height: 42px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            padding: 0 14px;
            font-size: 12px;
        }

        .filters {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .filter-btn {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 9px 15px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: #111;
            color: #fff;
            border-color: #111;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 1150px;
            border-collapse: collapse;
        }

        thead {
            background: #fafafa;
        }

        th {
            padding: 15px 18px;
            text-align: left;
            color: #777;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 1px solid #eee;
        }

        td {
            padding: 15px 18px;
            border-bottom: 1px solid #eee;
            font-size: 12px;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #fafafa;
        }

        .product-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .product-image {
            width: 58px;
            height: 68px;
            border-radius: 5px;
            object-fit: cover;
            background: #eee;
        }

        .product-name {
            font-weight: 700;
            max-width: 190px;
            line-height: 1.4;
        }

        .product-id {
            color: #999;
            font-size: 9px;
            margin-top: 5px;
        }

        .seller-name {
            font-weight: 600;
            margin-bottom: 4px;
        }

        .seller-email {
            color: #888;
            font-size: 10px;
        }

        .price {
            font-weight: 700;
        }

        .stock {
            color: #777;
            font-size: 10px;
            margin-top: 4px;
        }

        .category {
            display: inline-block;
            background: #f1f1f1;
            padding: 6px 9px;
            border-radius: 20px;
            font-size: 9px;
            font-weight: 600;
        }

        .status {
            display: inline-flex;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 9px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .approved {
            background: #dcfce7;
            color: #15803d;
        }

        .pending {
            background: #fff3cd;
            color: #856404;
        }

        .rejected {
            background: #fee2e2;
            color: #b91c1c;
        }

        .actions {
            display: flex;
            gap: 6px;
        }

        .action-btn {
            width: 34px;
            height: 34px;
            border: 1px solid #ddd;
            background: #fff;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .action-btn:hover {
            background: #111;
            color: #fff;
        }

        .approve-btn:hover {
            background: #16803c;
        }

        .reject-btn:hover {
            background: #c62828;
        }

        .delete-btn:hover {
            background: #b91c1c;
        }

        .inline-form {
            display: inline;
        }

        .add-panel {
            display: none;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 25px;
        }

        .add-panel.show {
            display: block;
        }

        .add-panel h2 {
            margin-top: 0;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            font-size: 11px;
            font-weight: 700;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 11px;
            font-size: 12px;
            outline: none;
        }

        .form-group textarea {
            min-height: 80px;
            resize: vertical;
        }

        .submit-add {
            margin-top: 18px;
            background: #111;
            color: #fff;
            border: 0;
            padding: 12px 22px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #888;
        }

        @media (max-width: 1000px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 700px) {

            .listings-page {
                padding: 25px 15px;
            }

            .page-header,
            .panel-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .search-box {
                width: 100%;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }

    </style>

</head>

<body>

<header class="navbar">

    <div class="nav-container">

        <a href="<%= ctx %>/index.jsp" class="logo">
            SHOPZILLA
        </a>

        <nav class="nav-links">

            <a href="<%= ctx %>/index.jsp">
                Home
            </a>

            <a href="<%= ctx %>/AdminServlet?action=dashboard">
                Dashboard
            </a>

            <a href="<%= ctx %>/AdminServlet?action=users">
                Users
            </a>

            <a href="<%= ctx %>/AdminServlet?action=orders">
                Orders
            </a>

            <a href="<%= ctx %>/AdminServlet?action=listings"
               class="active">
                Listings
            </a>

        </nav>

        <div class="nav-icons">

            <a href="<%= ctx %>/LogoutServlet"
               title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>

        </div>

    </div>

</header>


<main class="listings-page">

    <div class="page-header">

        <div>

            <h1>Manage Listings</h1>

            <p>
                Review, approve, reject, add and delete seller products.
            </p>

        </div>

        <div style="display:flex;gap:10px;">

            <button class="add-btn"
                    type="button"
                    onclick="toggleAddPanel()">

                <i class="fa-solid fa-plus"></i>
                Add Product

            </button>

            <a href="<%= ctx %>/AdminServlet?action=dashboard"
               class="back-btn">

                <i class="fa-solid fa-arrow-left"></i>
                Dashboard

            </a>

        </div>

    </div>


    <% if (success != null) { %>

        <div class="message success">

            <i class="fa-solid fa-circle-check"></i>

            <%= esc(success.replace("+", " ")) %>

        </div>

    <% } %>


    <% if (error != null) { %>

        <div class="message error">

            <i class="fa-solid fa-circle-exclamation"></i>

            <%= esc(error.replace("+", " ")) %>

        </div>

    <% } %>


    <!-- ADD PRODUCT -->

    <section class="add-panel" id="addPanel">

        <h2>

            <i class="fa-solid fa-box"></i>
            Add New Product

        </h2>

        <form method="post"
              action="<%= ctx %>/AdminServlet">

            <input type="hidden"
                   name="action"
                   value="addProduct">

            <div class="form-grid">

                <!-- SELLER -->

                <div class="form-group">

                    <label>Seller</label>

                    <select name="sellerId" required>

                        <option value="">
                            Select Seller
                        </option>

                        <%
                            for (User seller : users) {

                                if ("SELLER".equalsIgnoreCase(
                                        seller.getRole())) {
                        %>

                            <option value="<%= seller.getId() %>">

                                <%= esc(seller.getName()) %>
                                -
                                <%= esc(seller.getEmail()) %>

                            </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <!-- PRODUCT NAME -->

                <div class="form-group">

                    <label>Product Name</label>

                    <input type="text"
                           name="name"
                           required>

                </div>


                <!-- CATEGORY -->

                <div class="form-group">

                    <label>Category</label>

                    <input type="text"
                           name="category"
                           required>

                </div>


                <!-- SUBCATEGORY -->

                <div class="form-group">

                    <label>Subcategory</label>

                    <input type="text"
                           name="subcategory">

                </div>


                <!-- PRICE -->

                <div class="form-group">

                    <label>Price</label>

                    <input type="number"
                           name="price"
                           step="0.01"
                           min="0"
                           required>

                </div>


                <!-- MRP -->

                <div class="form-group">

                    <label>MRP</label>

                    <input type="number"
                           name="mrp"
                           step="0.01"
                           min="0"
                           required>

                </div>


                <!-- STOCK -->

                <div class="form-group">

                    <label>Stock</label>

                    <input type="number"
                           name="stock"
                           min="0"
                           required>

                </div>


                <!-- SKU REMOVED -->


                <!-- DESCRIPTION -->

                <div class="form-group full">

                    <label>Description</label>

                    <textarea name="description"></textarea>

                </div>

            </div>


            <button type="submit"
                    class="submit-add">

                <i class="fa-solid fa-plus"></i>
                Add Product

            </button>

        </form>

    </section>


    <!-- STATS -->

    <section class="stats-grid">

        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-box"></i>
                </div>

            </div>

            <span>Total Listings</span>

            <strong><%= total %></strong>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-circle-check"></i>
                </div>

            </div>

            <span>Approved</span>

            <strong><%= approved %></strong>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-clock"></i>
                </div>

            </div>

            <span>Pending Review</span>

            <strong><%= pending %></strong>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-circle-xmark"></i>
                </div>

            </div>

            <span>Rejected</span>

            <strong><%= rejected %></strong>

        </div>

    </section>


    <!-- LISTINGS -->

    <section class="listings-panel">

        <div class="panel-header">

            <div class="panel-title">

                <h2>Product Listings</h2>

                <p>
                    These products are loaded directly from the database.
                </p>

            </div>

            <div class="search-box">

                <input type="text"
                       id="listingSearch"
                       placeholder="Search product..."
                       onkeyup="filterListings()">

            </div>

        </div>


        <div class="filters">

            <button class="filter-btn active"
                    type="button"
                    onclick="setFilter(this,'all')">
                All
            </button>

            <button class="filter-btn"
                    type="button"
                    onclick="setFilter(this,'APPROVED')">
                Approved
            </button>

            <button class="filter-btn"
                    type="button"
                    onclick="setFilter(this,'PENDING')">
                Pending
            </button>

            <button class="filter-btn"
                    type="button"
                    onclick="setFilter(this,'REJECTED')">
                Rejected
            </button>

        </div>


        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>Product</th>
                    <th>Seller ID</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th>Actions</th>

                </tr>

                </thead>


                <tbody id="listingsTable">

                <%
                    for (Product product : products) {

                        String status =
                                product.getStatus() == null
                                        ? "PENDING"
                                        : product.getStatus().toUpperCase();

                        String statusClass;

                        if ("APPROVED".equals(status)) {
                            statusClass = "approved";
                        } else if ("REJECTED".equals(status)) {
                            statusClass = "rejected";
                        } else {
                            statusClass = "pending";
                        }


                        String image = product.getImageUrl();

                        if (image == null
                                || image.trim().isEmpty()) {

                            image = "men1.jpg";
                        }


                        String imageSrc;

                        if (image.startsWith("http://")
                                || image.startsWith("https://")
                                || image.startsWith("/")) {

                            imageSrc = image;

                        } else {

                            imageSrc =
                                    ctx + "/images/" + image;
                        }


                        User seller =
                                userService.getUserById(
                                        product.getSellerId()
                                );

                        String sellerName =
                                seller != null
                                        ? seller.getName()
                                        : "Seller #"
                                        + product.getSellerId();

                        String sellerEmail =
                                seller != null
                                        ? seller.getEmail()
                                        : "";

                %>

                    <tr class="listing-row"
                        data-status="<%= status %>"
                        data-search="<%= esc(
                                (product.getName() == null
                                        ? ""
                                        : product.getName())
                                .toLowerCase()
                        ) %>">

                        <td>

                            <div class="product-cell">

                                <img class="product-image"
                                     src="<%= esc(imageSrc) %>"
                                     alt="Product"
                                     onerror="this.src='<%= ctx %>/images/men1.jpg';">

                                <div>

                                    <div class="product-name">

                                        <%= esc(product.getName()) %>

                                    </div>

                                    <div class="product-id">

                                        ID: <%= product.getId() %>

                                    </div>

                                </div>

                            </div>

                        </td>


                        <td>

                            <div class="seller-name">

                                <%= esc(sellerName) %>

                            </div>

                            <div class="seller-email">

                                <%= esc(sellerEmail) %>

                            </div>

                        </td>


                        <td>

                            <span class="category">

                                <%= esc(product.getCategory()) %>

                            </span>

                        </td>


                        <td>

                            <div class="price">

                                <%= money(product.getPrice()) %>

                            </div>

                        </td>


                        <td>

                            <div>

                                <%= product.getStock() %>

                            </div>

                            <div class="stock">

                                <%
                                    if (product.getStock() > 0) {
                                %>

                                    In stock

                                <%
                                    } else {
                                %>

                                    Out of stock

                                <%
                                    }
                                %>

                            </div>

                        </td>


                        <td>

                            <span class="status <%= statusClass %>">

                                <%= esc(status) %>

                            </span>

                        </td>


                        <td>

                            <div class="actions">


                                <!-- APPROVE -->

                                <form class="inline-form"
                                      method="post"
                                      action="<%= ctx %>/AdminServlet">

                                    <input type="hidden"
                                           name="action"
                                           value="updateProductStatus">

                                    <input type="hidden"
                                           name="productId"
                                           value="<%= product.getId() %>">

                                    <input type="hidden"
                                           name="status"
                                           value="APPROVED">

                                    <button type="submit"
                                            class="action-btn approve-btn"
                                            title="Approve"
                                            onclick="return confirm('Approve this product?');">

                                        <i class="fa-solid fa-check"></i>

                                    </button>

                                </form>


                                <!-- REJECT -->

                                <form class="inline-form"
                                      method="post"
                                      action="<%= ctx %>/AdminServlet">

                                    <input type="hidden"
                                           name="action"
                                           value="updateProductStatus">

                                    <input type="hidden"
                                           name="productId"
                                           value="<%= product.getId() %>">

                                    <input type="hidden"
                                           name="status"
                                           value="REJECTED">

                                    <button type="submit"
                                            class="action-btn reject-btn"
                                            title="Reject"
                                            onclick="return confirm('Reject this product?');">

                                        <i class="fa-solid fa-xmark"></i>

                                    </button>

                                </form>


                                <!-- DELETE -->

                                <form class="inline-form"
                                      method="post"
                                      action="<%= ctx %>/AdminServlet">

                                    <input type="hidden"
                                           name="action"
                                           value="deleteProduct">

                                    <input type="hidden"
                                           name="productId"
                                           value="<%= product.getId() %>">

                                    <button type="submit"
                                            class="action-btn delete-btn"
                                            title="Delete"
                                            onclick="return confirm('DELETE this product permanently?');">

                                        <i class="fa-solid fa-trash"></i>

                                    </button>

                                </form>

                            </div>

                        </td>

                    </tr>

                <%
                    }

                    if (products.isEmpty()) {
                %>

                    <tr>

                        <td colspan="7">

                            <div class="no-results">

                                <i class="fa-solid fa-box-open"
                                   style="font-size:40px;"></i>

                                <h3>No products found</h3>

                                <p>
                                    Add a product using the Add Product button.
                                </p>

                            </div>

                        </td>

                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </section>

</main>


<script>

    let currentFilter = "all";


    function toggleAddPanel() {

        document
            .getElementById("addPanel")
            .classList.toggle("show");

    }


    function setFilter(button, filter) {

        currentFilter = filter;

        document
            .querySelectorAll(".filter-btn")
            .forEach(function(btn) {

                btn.classList.remove("active");

            });

        button.classList.add("active");

        filterListings();

    }


    function filterListings() {

        const search =
            document
                .getElementById("listingSearch")
                .value
                .toLowerCase()
                .trim();


        const rows =
            document.querySelectorAll(".listing-row");


        rows.forEach(function(row) {

            const status =
                row.dataset.status;

            const data =
                row.dataset.search.toLowerCase();


            const statusMatch =
                currentFilter === "all"
                || status === currentFilter;


            const searchMatch =
                search === ""
                || data.includes(search);


            row.style.display =
                statusMatch && searchMatch
                    ? "table-row"
                    : "none";

        });

    }

</script>


</body>

</html>