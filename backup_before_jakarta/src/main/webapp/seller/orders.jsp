<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Seller Orders | Shopzilla</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
    <link rel="stylesheet" href="<%= ctx %>/css/navbar.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f7f7f7;
            color: #222;
            font-family: Arial, Helvetica, sans-serif;
        }

        .orders-page {
            max-width: 1400px;
            margin: 0 auto;
            padding: 35px 30px 70px;
        }

        /* HEADER */

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            gap: 20px;
        }

        .page-header h1 {
            margin: 0 0 8px;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .page-header p {
            margin: 0;
            color: #777;
            font-size: 14px;
        }

        .back-btn {
            text-decoration: none;
            color: #111;
            border: 1px solid #ddd;
            background: #fff;
            padding: 12px 18px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }

        .back-btn:hover {
            background: #111;
            color: #fff;
        }

        /* STATS */

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 28px;
        }

        .stat-card {
            background: #fff;
            border: 1px solid #e7e7e7;
            padding: 22px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 17px;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f1f1f1;
            font-size: 18px;
        }

        .stat-info span {
            display: block;
            color: #888;
            font-size: 12px;
            margin-bottom: 6px;
        }

        .stat-info strong {
            font-size: 24px;
        }

        /* FILTER SECTION */

        .filter-box {
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 22px;
        }

        .filter-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 18px;
        }

        .search-box {
            width: 350px;
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 14px;
            top: 14px;
            color: #888;
        }

        .search-box input {
            width: 100%;
            height: 42px;
            padding: 0 15px 0 40px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            font-size: 13px;
        }

        .search-box input:focus {
            border-color: #111;
        }

        .date-filter select {
            height: 42px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0 14px;
            background: #fff;
            outline: none;
        }

        .status-tabs {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .status-tab {
            border: 1px solid #ddd;
            background: #fff;
            padding: 10px 17px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }

        .status-tab:hover,
        .status-tab.active {
            background: #111;
            color: #fff;
            border-color: #111;
        }

        /* ORDERS */

        .orders-container {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .order-card {
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            overflow: hidden;
        }

        .order-top {
            padding: 18px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .order-number {
            font-size: 14px;
            font-weight: 700;
        }

        .order-date {
            color: #888;
            font-size: 12px;
            margin-top: 5px;
        }

        .status {
            padding: 7px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .processing {
            background: #fff3cd;
            color: #856404;
        }

        .shipped {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .delivered {
            background: #dcfce7;
            color: #15803d;
        }

        .cancelled {
            background: #fee2e2;
            color: #b91c1c;
        }

        .order-body {
            padding: 20px;
        }

        .customer-section {
            display: grid;
            grid-template-columns: 1.2fr 1fr 1fr 1fr;
            gap: 25px;
            margin-bottom: 20px;
        }

        .info-label {
            color: #999;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: .5px;
            margin-bottom: 6px;
        }

        .info-value {
            font-size: 13px;
            font-weight: 600;
        }

        .info-sub {
            color: #777;
            font-size: 11px;
            margin-top: 4px;
        }

        /* PRODUCT */

        .product-section {
            border-top: 1px solid #eee;
            padding-top: 18px;
        }

        .product-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .product-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .product-image {
            width: 75px;
            height: 90px;
            border-radius: 5px;
            overflow: hidden;
            background: #f3f3f3;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-name {
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .product-meta {
            font-size: 11px;
            color: #777;
            line-height: 1.7;
        }

        .product-price {
            font-size: 14px;
            font-weight: 700;
            text-align: right;
        }

        /* FOOTER */

        .order-footer {
            padding: 16px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .payment-info {
            font-size: 12px;
            color: #666;
        }

        .payment-info strong {
            color: #222;
        }

        .order-actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            border: 1px solid #ddd;
            background: #fff;
            padding: 9px 14px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 11px;
            font-weight: 600;
        }

        .action-btn:hover {
            background: #111;
            color: #fff;
            border-color: #111;
        }

        .update-btn {
            background: #111;
            color: #fff;
            border-color: #111;
        }

        .update-btn:hover {
            background: #333;
        }

        /* EMPTY */

        .no-results {
            display: none;
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 60px 20px;
            text-align: center;
        }

        .no-results i {
            font-size: 40px;
            color: #bbb;
            margin-bottom: 15px;
        }

        .no-results h3 {
            margin: 0 0 8px;
        }

        .no-results p {
            color: #888;
            font-size: 13px;
        }

        /* MODAL */

        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.55);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal {
            background: #fff;
            width: 100%;
            max-width: 450px;
            border-radius: 8px;
            padding: 28px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 20px;
        }

        .close-modal {
            border: 0;
            background: none;
            font-size: 22px;
            cursor: pointer;
            color: #777;
        }

        .modal-order-id {
            font-size: 12px;
            color: #888;
            margin-bottom: 18px;
        }

        .modal label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 7px;
        }

        .modal select {
            width: 100%;
            height: 44px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0 12px;
            outline: none;
            margin-bottom: 20px;
        }

        .save-status {
            width: 100%;
            height: 44px;
            border: 0;
            background: #111;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .save-status:hover {
            background: #333;
        }

        /* RESPONSIVE */

        @media (max-width: 1000px) {

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .customer-section {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 700px) {

            .orders-page {
                padding: 25px 15px 50px;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .stats-grid {
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }

            .stat-card {
                padding: 15px;
            }

            .stat-icon {
                width: 40px;
                height: 40px;
            }

            .stat-info strong {
                font-size: 20px;
            }

            .filter-top {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                width: 100%;
            }

            .date-filter select {
                width: 100%;
            }

            .customer-section {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .product-row {
                align-items: flex-start;
            }

            .product-price {
                font-size: 13px;
            }

            .order-footer {
                align-items: flex-start;
                flex-direction: column;
            }

            .order-actions {
                width: 100%;
            }

            .action-btn {
                flex: 1;
            }
        }

        @media (max-width: 480px) {

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .order-top {
                align-items: flex-start;
                flex-direction: column;
            }

            .product-image {
                width: 60px;
                height: 75px;
            }

            .product-name {
                font-size: 12px;
            }

            .status-tabs {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }

            .status-tab {
                text-align: center;
            }
        }

    </style>
</head>

<body>

<!-- NAVBAR -->
<header class="navbar">

    <div class="nav-container">

        <a href="<%= ctx %>/index.jsp" class="logo">
            SHOPZILLA
        </a>

        <nav class="nav-links">
            <a href="<%= ctx %>/index.jsp">Home</a>
            <a href="<%= ctx %>/buyer/products.jsp">Products</a>
            <a href="<%= ctx %>/seller/dashboard.jsp">Dashboard</a>
            <a href="<%= ctx %>/seller/orders.jsp" class="active">Orders</a>
        </nav>

        <div class="nav-icons">

            <a href="<%= ctx %>/seller/dashboard.jsp" title="Dashboard">
                <i class="fa-solid fa-chart-line"></i>
            </a>

            <a href="<%= ctx %>/LogoutServlet" title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>

        </div>

    </div>

</header>


<main class="orders-page">

    <!-- PAGE HEADER -->

    <div class="page-header">

        <div>
            <h1>Orders</h1>
            <p>Manage and track all customer orders from your store.</p>
        </div>

        <a href="<%= ctx %>/seller/dashboard.jsp" class="back-btn">
            <i class="fa-solid fa-arrow-left"></i>
            Dashboard
        </a>

    </div>


    <!-- STATS -->

    <section class="stats-grid">

        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-box"></i>
            </div>

            <div class="stat-info">
                <span>Total Orders</span>
                <strong>128</strong>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-clock"></i>
            </div>

            <div class="stat-info">
                <span>Processing</span>
                <strong>18</strong>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-truck"></i>
            </div>

            <div class="stat-info">
                <span>Shipped</span>
                <strong>32</strong>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-circle-check"></i>
            </div>

            <div class="stat-info">
                <span>Delivered</span>
                <strong>78</strong>
            </div>

        </div>

    </section>


    <!-- FILTER -->

    <section class="filter-box">

        <div class="filter-top">

            <div class="search-box">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    id="orderSearch"
                    placeholder="Search order ID or customer..."
                    onkeyup="filterOrders()">

            </div>


            <div class="date-filter">

                <select id="dateFilter" onchange="filterOrders()">

                    <option value="all">All Dates</option>
                    <option value="today">Today</option>
                    <option value="week">Last 7 Days</option>
                    <option value="month">This Month</option>

                </select>

            </div>

        </div>


        <div class="status-tabs">

            <button class="status-tab active"
                    data-status="all"
                    onclick="setStatus(this, 'all')">
                All Orders
            </button>

            <button class="status-tab"
                    data-status="processing"
                    onclick="setStatus(this, 'processing')">
                Processing
            </button>

            <button class="status-tab"
                    data-status="shipped"
                    onclick="setStatus(this, 'shipped')">
                Shipped
            </button>

            <button class="status-tab"
                    data-status="delivered"
                    onclick="setStatus(this, 'delivered')">
                Delivered
            </button>

            <button class="status-tab"
                    data-status="cancelled"
                    onclick="setStatus(this, 'cancelled')">
                Cancelled
            </button>

        </div>

    </section>


    <!-- ORDERS -->

    <section class="orders-container" id="ordersContainer">


        <!-- ORDER 1 -->

        <div class="order-card"
             data-status="processing"
             data-search="SZ10045 Arjun Kumar">

            <div class="order-top">

                <div>

                    <div class="order-number">
                        Order #SZ10045
                    </div>

                    <div class="order-date">
                        18 September 2026 · 10:42 AM
                    </div>

                </div>

                <span class="status processing">
                    Processing
                </span>

            </div>


            <div class="order-body">

                <div class="customer-section">

                    <div>
                        <div class="info-label">Customer</div>
                        <div class="info-value">Arjun Kumar</div>
                        <div class="info-sub">arjun@email.com</div>
                    </div>

                    <div>
                        <div class="info-label">Phone</div>
                        <div class="info-value">+91 98765 43210</div>
                    </div>

                    <div>
                        <div class="info-label">Delivery</div>
                        <div class="info-value">Chennai, Tamil Nadu</div>
                        <div class="info-sub">600001</div>
                    </div>

                    <div>
                        <div class="info-label">Total</div>
                        <div class="info-value">₹2,499</div>
                    </div>

                </div>


                <div class="product-section">

                    <div class="product-row">

                        <div class="product-left">

                            <div class="product-image">

                                <img
                                    src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=200&q=80"
                                    alt="T-Shirt">

                            </div>

                            <div>

                                <div class="product-name">
                                    Premium Cotton Oversized T-Shirt
                                </div>

                                <div class="product-meta">
                                    Size: L<br>
                                    Quantity: 2<br>
                                    SKU: SZ-TS-001
                                </div>

                            </div>

                        </div>

                        <div class="product-price">
                            ₹2,499
                        </div>

                    </div>

                </div>

            </div>


            <div class="order-footer">

                <div class="payment-info">
                    Payment:
                    <strong>UPI</strong>
                    · Paid
                </div>

                <div class="order-actions">

                    <button class="action-btn"
                            onclick="viewOrder('SZ10045')">
                        <i class="fa-regular fa-eye"></i>
                        View
                    </button>

                    <button class="action-btn update-btn"
                            onclick="openStatusModal('SZ10045','processing')">
                        Update Status
                    </button>

                </div>

            </div>

        </div>


        <!-- ORDER 2 -->

        <div class="order-card"
             data-status="shipped"
             data-search="SZ10044 Priya Sharma">

            <div class="order-top">

                <div>

                    <div class="order-number">
                        Order #SZ10044
                    </div>

                    <div class="order-date">
                        17 September 2026 · 04:20 PM
                    </div>

                </div>

                <span class="status shipped">
                    Shipped
                </span>

            </div>


            <div class="order-body">

                <div class="customer-section">

                    <div>
                        <div class="info-label">Customer</div>
                        <div class="info-value">Priya Sharma</div>
                        <div class="info-sub">priya@email.com</div>
                    </div>

                    <div>
                        <div class="info-label">Phone</div>
                        <div class="info-value">+91 91234 56789</div>
                    </div>

                    <div>
                        <div class="info-label">Delivery</div>
                        <div class="info-value">Bengaluru, Karnataka</div>
                        <div class="info-sub">560001</div>
                    </div>

                    <div>
                        <div class="info-label">Total</div>
                        <div class="info-value">₹3,199</div>
                    </div>

                </div>


                <div class="product-section">

                    <div class="product-row">

                        <div class="product-left">

                            <div class="product-image">

                                <img
                                    src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=200&q=80"
                                    alt="Sneakers">

                            </div>

                            <div>

                                <div class="product-name">
                                    Urban Runner Sneakers
                                </div>

                                <div class="product-meta">
                                    Size: 8<br>
                                    Quantity: 1<br>
                                    SKU: SZ-SH-002
                                </div>

                            </div>

                        </div>

                        <div class="product-price">
                            ₹3,199
                        </div>

                    </div>

                </div>

            </div>


            <div class="order-footer">

                <div class="payment-info">
                    Payment:
                    <strong>Card</strong>
                    · Paid
                </div>

                <div class="order-actions">

                    <button class="action-btn"
                            onclick="viewOrder('SZ10044')">
                        <i class="fa-regular fa-eye"></i>
                        View
                    </button>

                    <button class="action-btn update-btn"
                            onclick="openStatusModal('SZ10044','shipped')">
                        Update Status
                    </button>

                </div>

            </div>

        </div>


        <!-- ORDER 3 -->

        <div class="order-card"
             data-status="delivered"
             data-search="SZ10043 Rahul Raj">

            <div class="order-top">

                <div>

                    <div class="order-number">
                        Order #SZ10043
                    </div>

                    <div class="order-date">
                        15 September 2026 · 11:15 AM
                    </div>

                </div>

                <span class="status delivered">
                    Delivered
                </span>

            </div>


            <div class="order-body">

                <div class="customer-section">

                    <div>
                        <div class="info-label">Customer</div>
                        <div class="info-value">Rahul Raj</div>
                        <div class="info-sub">rahul@email.com</div>
                    </div>

                    <div>
                        <div class="info-label">Phone</div>
                        <div class="info-value">+91 99887 66554</div>
                    </div>

                    <div>
                        <div class="info-label">Delivery</div>
                        <div class="info-value">Coimbatore, Tamil Nadu</div>
                        <div class="info-sub">641001</div>
                    </div>

                    <div>
                        <div class="info-label">Total</div>
                        <div class="info-value">₹1,899</div>
                    </div>

                </div>


                <div class="product-section">

                    <div class="product-row">

                        <div class="product-left">

                            <div class="product-image">

                                <img
                                    src="https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=200&q=80"
                                    alt="Jacket">

                            </div>

                            <div>

                                <div class="product-name">
                                    Classic Casual Jacket
                                </div>

                                <div class="product-meta">
                                    Size: M<br>
                                    Quantity: 1<br>
                                    SKU: SZ-JK-003
                                </div>

                            </div>

                        </div>

                        <div class="product-price">
                            ₹1,899
                        </div>

                    </div>

                </div>

            </div>


            <div class="order-footer">

                <div class="payment-info">
                    Payment:
                    <strong>COD</strong>
                    · Paid
                </div>

                <div class="order-actions">

                    <button class="action-btn"
                            onclick="viewOrder('SZ10043')">
                        <i class="fa-regular fa-eye"></i>
                        View
                    </button>

                    <button class="action-btn"
                            onclick="buyAgain('SZ10043')">
                        Buy Again
                    </button>

                </div>

            </div>

        </div>


        <!-- ORDER 4 -->

        <div class="order-card"
             data-status="cancelled"
             data-search="SZ10042 Divya S">

            <div class="order-top">

                <div>

                    <div class="order-number">
                        Order #SZ10042
                    </div>

                    <div class="order-date">
                        13 September 2026 · 06:30 PM
                    </div>

                </div>

                <span class="status cancelled">
                    Cancelled
                </span>

            </div>


            <div class="order-body">

                <div class="customer-section">

                    <div>
                        <div class="info-label">Customer</div>
                        <div class="info-value">Divya S</div>
                        <div class="info-sub">divya@email.com</div>
                    </div>

                    <div>
                        <div class="info-label">Phone</div>
                        <div class="info-value">+91 90000 11223</div>
                    </div>

                    <div>
                        <div class="info-label">Delivery</div>
                        <div class="info-value">Madurai, Tamil Nadu</div>
                        <div class="info-sub">625001</div>
                    </div>

                    <div>
                        <div class="info-label">Total</div>
                        <div class="info-value">₹1,299</div>
                    </div>

                </div>


                <div class="product-section">

                    <div class="product-row">

                        <div class="product-left">

                            <div class="product-image">

                                <img
                                    src="https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=200&q=80"
                                    alt="Jeans">

                            </div>

                            <div>

                                <div class="product-name">
                                    Slim Fit Denim Jeans
                                </div>

                                <div class="product-meta">
                                    Size: 32<br>
                                    Quantity: 1<br>
                                    SKU: SZ-JN-004
                                </div>

                            </div>

                        </div>

                        <div class="product-price">
                            ₹1,299
                        </div>

                    </div>

                </div>

            </div>


            <div class="order-footer">

                <div class="payment-info">
                    Payment:
                    <strong>UPI</strong>
                    · Refunded
                </div>

                <div class="order-actions">

                    <button class="action-btn"
                            onclick="viewOrder('SZ10042')">
                        <i class="fa-regular fa-eye"></i>
                        View
                    </button>

                </div>

            </div>

        </div>

    </section>


    <div class="no-results" id="noResults">

        <i class="fa-solid fa-box-open"></i>

        <h3>No orders found</h3>

        <p>Try changing your search or order status filter.</p>

    </div>

</main>


<!-- STATUS MODAL -->

<div class="modal-overlay" id="statusModal">

    <div class="modal">

        <div class="modal-header">

            <h3>Update Order Status</h3>

            <button class="close-modal"
                    onclick="closeStatusModal()">
                &times;
            </button>

        </div>

        <div class="modal-order-id">
            Order:
            <strong id="modalOrderId">#SZ10045</strong>
        </div>

        <label for="newStatus">
            New Status
        </label>

        <select id="newStatus">

            <option value="processing">
                Processing
            </option>

            <option value="shipped">
                Shipped
            </option>

            <option value="delivered">
                Delivered
            </option>

            <option value="cancelled">
                Cancelled
            </option>

        </select>

        <button class="save-status"
                onclick="saveStatus()">
            Save Status
        </button>

    </div>

</div>


<script>

    let selectedStatus = "all";
    let selectedOrder = "";


    function setStatus(button, status) {

        selectedStatus = status;

        document
            .querySelectorAll(".status-tab")
            .forEach(tab => tab.classList.remove("active"));

        button.classList.add("active");

        filterOrders();
    }


    function filterOrders() {

        const search =
            document
                .getElementById("orderSearch")
                .value
                .toLowerCase()
                .trim();

        const cards =
            document.querySelectorAll(".order-card");

        let visibleCount = 0;

        cards.forEach(card => {

            const status =
                card.dataset.status;

            const searchData =
                card.dataset.search.toLowerCase();

            const statusMatch =
                selectedStatus === "all" ||
                status === selectedStatus;

            const searchMatch =
                search === "" ||
                searchData.includes(search);

            if (statusMatch && searchMatch) {

                card.style.display = "block";
                visibleCount++;

            } else {

                card.style.display = "none";

            }

        });


        const noResults =
            document.getElementById("noResults");

        if (visibleCount === 0) {

            noResults.style.display = "block";

        } else {

            noResults.style.display = "none";

        }

    }


    function openStatusModal(orderId, currentStatus) {

        selectedOrder = orderId;

        document
            .getElementById("modalOrderId")
            .textContent = "#" + orderId;

        document
            .getElementById("newStatus")
            .value = currentStatus;

        document
            .getElementById("statusModal")
            .classList.add("show");

    }


    function closeStatusModal() {

        document
            .getElementById("statusModal")
            .classList.remove("show");

    }


    function saveStatus() {

        const status =
            document
                .getElementById("newStatus")
                .value;

        alert(
            "Order #" +
            selectedOrder +
            " status updated to " +
            status.toUpperCase() +
            "."
        );

        closeStatusModal();

    }


    function viewOrder(orderId) {

        alert(
            "Opening order details for #" +
            orderId
        );

    }


    function buyAgain(orderId) {

        alert(
            "Buy Again selected for #" +
            orderId
        );

    }


    document
        .getElementById("statusModal")
        .addEventListener("click", function(event) {

            if (event.target === this) {
                closeStatusModal();
            }

        });

</script>

</body>
</html>