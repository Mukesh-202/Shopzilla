<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopzilla.model.User" %>
<%@ page import="com.shopzilla.model.Product" %>
<%@ page import="com.shopzilla.model.Order" %>

<%
    List<User> users = (List<User>) request.getAttribute("users");
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Order> orders = (List<Order>) request.getAttribute("orders");

    int userCount = users != null ? users.size() : 0;
    int productCount = products != null ? products.size() : 0;
    int orderCount = orders != null ? orders.size() : 0;

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | Shopzilla</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f5f6fa;
            color: #222;
        }

        a {
            text-decoration: none;
        }

        /* ================= TOP BAR ================= */

        .topbar {
            height: 70px;
            background: #111827;
            color: white;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 35px;

            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 25px;
            font-weight: 800;
        }

        .logo span {
            color: #a855f7;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .admin-badge {
            background: #7c3aed;
            padding: 8px 14px;
            border-radius: 20px;

            font-size: 13px;
            font-weight: 600;
        }

        .logout-btn {
            background: #ef4444;
            color: white;

            padding: 9px 15px;
            border-radius: 7px;

            font-size: 13px;
        }

        .logout-btn:hover {
            background: #dc2626;
        }

        /* ================= LAYOUT ================= */

        .layout {
            display: flex;
            min-height: calc(100vh - 70px);
        }

        /* ================= SIDEBAR ================= */

        .sidebar {
            width: 240px;
            background: white;

            border-right: 1px solid #e5e7eb;

            padding: 25px 15px;
        }

        .sidebar-title {
            color: #9ca3af;

            font-size: 11px;
            font-weight: 700;

            margin: 0 12px 12px;

            letter-spacing: 1px;
        }

        .side-link {
            display: flex;
            align-items: center;

            gap: 13px;

            padding: 13px 14px;

            margin-bottom: 6px;

            color: #374151;

            border-radius: 8px;

            font-size: 14px;

            transition: .2s;
        }

        .side-link i {
            width: 20px;
            text-align: center;
        }

        .side-link:hover {
            background: #f3e8ff;
            color: #7c3aed;
        }

        .side-link.active {
            background: #7c3aed;
            color: white;
        }

        /* ================= CONTENT ================= */

        .content {
            flex: 1;
            padding: 30px;

            overflow-x: hidden;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;

            margin-bottom: 7px;
        }

        .page-subtitle {
            color: #6b7280;

            margin-bottom: 30px;
        }

        /* ================= STATS ================= */

        .stats {
            display: grid;

            grid-template-columns: repeat(3, 1fr);

            gap: 20px;

            margin-bottom: 30px;
        }

        .stat-card {
            background: white;

            padding: 22px;

            border-radius: 12px;

            border: 1px solid #e5e7eb;

            display: flex;
            align-items: center;

            gap: 18px;
        }

        .stat-icon {
            width: 55px;
            height: 55px;

            border-radius: 12px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 22px;
        }

        .users-icon {
            background: #ede9fe;
            color: #7c3aed;
        }

        .products-icon {
            background: #dbeafe;
            color: #2563eb;
        }

        .orders-icon {
            background: #dcfce7;
            color: #16a34a;
        }

        .stat-label {
            color: #6b7280;

            font-size: 13px;

            margin-bottom: 5px;
        }

        .stat-value {
            font-size: 25px;

            font-weight: 700;
        }

        /* ================= SECTION ================= */

        .section {
            background: white;

            border-radius: 12px;

            border: 1px solid #e5e7eb;

            padding: 25px;

            margin-bottom: 25px;
        }

        .section-header {
            display: flex;

            align-items: center;

            justify-content: space-between;

            margin-bottom: 20px;
        }

        .section-title {
            font-size: 19px;

            font-weight: 700;
        }

        /* ================= QUICK ACTIONS ================= */

        .quick-actions {
            display: grid;

            grid-template-columns: repeat(4, 1fr);

            gap: 15px;
        }

        .quick-action {
            border: 1px solid #e5e7eb;

            border-radius: 10px;

            padding: 20px;

            display: flex;

            align-items: center;

            gap: 13px;

            color: #374151;

            transition: .2s;
        }

        .quick-action i {
            font-size: 20px;

            color: #7c3aed;
        }

        .quick-action:hover {
            border-color: #7c3aed;

            background: #faf5ff;

            transform: translateY(-2px);
        }

        .quick-action span {
            font-weight: 600;

            font-size: 14px;
        }

        /* ================= BUTTON ================= */

        .manage-btn {
            display: inline-flex;

            align-items: center;

            gap: 7px;

            background: #7c3aed;

            color: white;

            padding: 10px 16px;

            border-radius: 7px;

            font-size: 13px;

            font-weight: 600;
        }

        .manage-btn:hover {
            background: #6d28d9;
        }

        /* ================= TABLE ================= */

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;

            border-collapse: collapse;
        }

        th {
            background: #f9fafb;

            color: #6b7280;

            font-size: 12px;

            text-align: left;

            padding: 13px;

            border-bottom: 1px solid #e5e7eb;
        }

        td {
            padding: 14px 13px;

            border-bottom: 1px solid #f0f0f0;

            font-size: 13px;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .empty {
            text-align: center;

            color: #9ca3af;

            padding: 25px;
        }

        /* ================= STATUS ================= */

        .status {
            display: inline-block;

            padding: 5px 10px;

            border-radius: 20px;

            font-size: 11px;

            font-weight: 700;
        }

        .status-admin {
            background: #ede9fe;
            color: #7c3aed;
        }

        .status-seller {
            background: #dbeafe;
            color: #2563eb;
        }

        .status-buyer {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-default {
            background: #f3f4f6;
            color: #4b5563;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 1000px) {

            .sidebar {
                width: 200px;
            }

            .quick-actions {
                grid-template-columns: repeat(2, 1fr);
            }

            .stats {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 700px) {

            .layout {
                display: block;
            }

            .sidebar {
                width: 100%;

                border-right: none;

                border-bottom: 1px solid #e5e7eb;
            }

            .content {
                padding: 20px;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }

            .topbar {
                padding: 0 15px;
            }

            .admin-badge {
                display: none;
            }

            .section-header {
                flex-direction: column;

                align-items: flex-start;

                gap: 12px;
            }
        }

    </style>

</head>

<body>

<!-- ================= TOP BAR ================= -->

<header class="topbar">

    <div class="logo">
        SHOP<span>ZILLA</span>
    </div>

    <div class="admin-info">

        <span class="admin-badge">
            <i class="fa-solid fa-shield-halved"></i>
            ADMIN
        </span>

        <a href="<%= contextPath %>/LogoutServlet"
           class="logout-btn">

            <i class="fa-solid fa-right-from-bracket"></i>
            Logout

        </a>

    </div>

</header>


<!-- ================= MAIN LAYOUT ================= -->

<div class="layout">


    <!-- ================= SIDEBAR ================= -->

    <aside class="sidebar">

        <div class="sidebar-title">
            ADMIN PANEL
        </div>


        <!-- DASHBOARD -->

        <a href="<%= contextPath %>/AdminServlet?action=dashboard"
           class="side-link active">

            <i class="fa-solid fa-gauge-high"></i>

            <span>
                Dashboard
            </span>

        </a>


        <!-- USERS -->

        <a href="<%= contextPath %>/AdminServlet?action=users"
           class="side-link">

            <i class="fa-solid fa-users"></i>

            <span>
                Users
            </span>

        </a>


        <!-- PRODUCTS -->

        <a href="<%= contextPath %>/AdminServlet?action=listings"
           class="side-link">

            <i class="fa-solid fa-box"></i>

            <span>
                Products
            </span>

        </a>


        <!-- ORDERS -->

        <a href="<%= contextPath %>/AdminServlet?action=orders"
           class="side-link">

            <i class="fa-solid fa-cart-shopping"></i>

            <span>
                Orders
            </span>

        </a>


        <!-- STORE -->

        <a href="<%= contextPath %>/"
           class="side-link">

            <i class="fa-solid fa-store"></i>

            <span>
                View Store
            </span>

        </a>

    </aside>


    <!-- ================= CONTENT ================= -->

    <main class="content">

        <h1 class="page-title">
            Admin Dashboard
        </h1>

        <p class="page-subtitle">
            Manage Shopzilla users, products and orders.
        </p>


        <!-- ================= STAT CARDS ================= -->

        <div class="stats">


            <!-- USERS -->

            <div class="stat-card">

                <div class="stat-icon users-icon">

                    <i class="fa-solid fa-users"></i>

                </div>

                <div>

                    <div class="stat-label">
                        Total Users
                    </div>

                    <div class="stat-value">
                        <%= userCount %>
                    </div>

                </div>

            </div>


            <!-- PRODUCTS -->

            <div class="stat-card">

                <div class="stat-icon products-icon">

                    <i class="fa-solid fa-box"></i>

                </div>

                <div>

                    <div class="stat-label">
                        Total Products
                    </div>

                    <div class="stat-value">
                        <%= productCount %>
                    </div>

                </div>

            </div>


            <!-- ORDERS -->

            <div class="stat-card">

                <div class="stat-icon orders-icon">

                    <i class="fa-solid fa-cart-shopping"></i>

                </div>

                <div>

                    <div class="stat-label">
                        Total Orders
                    </div>

                    <div class="stat-value">
                        <%= orderCount %>
                    </div>

                </div>

            </div>

        </div>


        <!-- ================= QUICK ACTIONS ================= -->

        <div class="section">

            <div class="section-title"
                 style="margin-bottom:20px;">

                Quick Actions

            </div>


            <div class="quick-actions">


                <!-- MANAGE USERS -->

                <a href="<%= contextPath %>/AdminServlet?action=users"
                   class="quick-action">

                    <i class="fa-solid fa-users"></i>

                    <span>
                        Manage Users
                    </span>

                </a>


                <!-- MANAGE PRODUCTS -->

                <a href="<%= contextPath %>/AdminServlet?action=listings"
                   class="quick-action">

                    <i class="fa-solid fa-box"></i>

                    <span>
                        Manage Products
                    </span>

                </a>


                <!-- MANAGE ORDERS -->

                <a href="<%= contextPath %>/AdminServlet?action=orders"
                   class="quick-action">

                    <i class="fa-solid fa-cart-shopping"></i>

                    <span>
                        Manage Orders
                    </span>

                </a>


                <!-- VIEW STORE -->

                <a href="<%= contextPath %>/"
                   class="quick-action">

                    <i class="fa-solid fa-store"></i>

                    <span>
                        View Store
                    </span>

                </a>


            </div>

        </div>


        <!-- ================= RECENT PRODUCTS ================= -->

        <div class="section">

            <div class="section-header">

                <div class="section-title">
                    Recent Products
                </div>

                <a href="<%= contextPath %>/AdminServlet?action=listings"
                   class="manage-btn">

                    <i class="fa-solid fa-box"></i>
                    Manage Products

                </a>

            </div>


            <div class="table-wrapper">

                <table>

                    <thead>

                    <tr>

                        <th>ID</th>

                        <th>Product</th>

                        <th>Category</th>

                        <th>Price</th>

                        <th>Stock</th>

                        <th>Status</th>

                    </tr>

                    </thead>


                    <tbody>

                    <%
                        if (products != null && !products.isEmpty()) {

                            int count = 0;

                            for (Product product : products) {

                                if (count >= 5) {
                                    break;
                                }

                                count++;
                    %>

                    <tr>

                        <td>
                            <%= product.getId() %>
                        </td>

                        <td>
                            <strong>
                                <%= product.getName() %>
                            </strong>
                        </td>

                        <td>
                            <%= product.getCategory() %>
                        </td>

                        <td>
                            ₹<%= product.getPrice() %>
                        </td>

                        <td>
                            <%= product.getStock() %>
                        </td>

                        <td>
                            <%= product.getStatus() %>
                        </td>

                    </tr>

                    <%
                            }

                        } else {
                    %>

                    <tr>

                        <td colspan="6"
                            class="empty">

                            No products found.

                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

        </div>


        <!-- ================= RECENT USERS ================= -->

        <div class="section">

            <div class="section-header">

                <div class="section-title">
                    Recent Users
                </div>

                <a href="<%= contextPath %>/AdminServlet?action=users"
                   class="manage-btn">

                    <i class="fa-solid fa-users"></i>
                    Manage Users

                </a>

            </div>


            <div class="table-wrapper">

                <table>

                    <thead>

                    <tr>

                        <th>ID</th>

                        <th>Name</th>

                        <th>Email</th>

                        <th>Role</th>

                    </tr>

                    </thead>


                    <tbody>

                    <%
                        if (users != null && !users.isEmpty()) {

                            int count = 0;

                            for (User user : users) {

                                if (count >= 5) {
                                    break;
                                }

                                count++;

                                String userRole = user.getRole();

                                String roleClass = "status-default";

                                if (userRole != null) {

                                    if ("ADMIN".equalsIgnoreCase(userRole)) {
                                        roleClass = "status-admin";
                                    } else if ("SELLER".equalsIgnoreCase(userRole)) {
                                        roleClass = "status-seller";
                                    } else if ("BUYER".equalsIgnoreCase(userRole)) {
                                        roleClass = "status-buyer";
                                    }
                                }
                    %>

                    <tr>

                        <td>
                            <%= user.getId() %>
                        </td>

                        <td>

                            <strong>
                                <%= user.getName() %>
                            </strong>

                        </td>

                        <td>
                            <%= user.getEmail() %>
                        </td>

                        <td>

                            <span class="status <%= roleClass %>">

                                <%= userRole != null
                                        ? userRole
                                        : "UNKNOWN" %>

                            </span>

                        </td>

                    </tr>

                    <%
                            }

                        } else {
                    %>

                    <tr>

                        <td colspan="4"
                            class="empty">

                            No users found.

                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

        </div>


        <!-- ================= RECENT ORDERS ================= -->

        <div class="section">

            <div class="section-header">

                <div class="section-title">
                    Recent Orders
                </div>

                <a href="<%= contextPath %>/AdminServlet?action=orders"
                   class="manage-btn">

                    <i class="fa-solid fa-cart-shopping"></i>
                    Manage Orders

                </a>

            </div>


            <div class="table-wrapper">

                <table>

                    <thead>

                    <tr>

                        <th>ID</th>

                        <th>User ID</th>

                        <th>Total</th>

                        <th>Status</th>

                    </tr>

                    </thead>


                    <tbody>

                    <%
                        if (orders != null && !orders.isEmpty()) {

                            int count = 0;

                            for (Order order : orders) {

                                if (count >= 5) {
                                    break;
                                }

                                count++;
                    %>

                    <tr>

                        <td>
                            <%= order.getId() %>
                        </td>

                        <td>
                            <%= order.getUserId() %>
                        </td>

                        <td>
                            ₹<%= order.getTotalAmount() %>
                        </td>

                        <td>
                            <%= order.getStatus() %>
                        </td>

                    </tr>

                    <%
                            }

                        } else {
                    %>

                    <tr>

                        <td colspan="4"
                            class="empty">

                            No orders found.

                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

        </div>


    </main>

</div>

</body>

</html>