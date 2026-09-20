<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Orders | Shopzilla Admin</title>

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

        .orders-page {
            max-width: 1450px;
            margin: auto;
            padding: 35px 30px 70px;
        }


        /* HEADER */

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 28px;
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

        .back-btn {
            text-decoration: none;
            background: #111;
            color: #fff;
            padding: 12px 18px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 600;
        }

        .back-btn:hover {
            background: #333;
        }


        /* STATS */

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
            padding: 21px;
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .stat-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #f1f1f1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-change {
            font-size: 10px;
            font-weight: 700;
        }

        .up {
            color: #16803c;
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


        /* PANEL */

        .orders-panel {
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            overflow: hidden;
        }

        .panel-header {
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid #eee;
        }

        .panel-header h2 {
            margin: 0 0 5px;
            font-size: 17px;
        }

        .panel-header p {
            margin: 0;
            color: #888;
            font-size: 11px;
        }


        /* SEARCH */

        .search-box {
            width: 340px;
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
            padding: 0 14px 0 40px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            font-size: 12px;
        }

        .search-box input:focus {
            border-color: #111;
        }


        /* FILTERS */

        .filters {
            display: flex;
            gap: 8px;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 9px 15px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            font-size: 11px;
            font-weight: 600;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: #111;
            color: #fff;
            border-color: #111;
        }


        /* TABLE */

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 1050px;
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
            padding: 16px 18px;
            border-bottom: 1px solid #eee;
            font-size: 12px;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #fafafa;
        }


        /* ORDER */

        .order-id {
            font-weight: 700;
            margin-bottom: 4px;
        }

        .order-date {
            color: #999;
            font-size: 10px;
        }


        /* CUSTOMER */

        .customer {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #111;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 700;
        }

        .customer-name {
            font-weight: 700;
            margin-bottom: 4px;
        }

        .customer-email {
            color: #888;
            font-size: 10px;
        }


        /* PRODUCT */

        .product-name {
            font-weight: 600;
            max-width: 190px;
            line-height: 1.4;
        }

        .product-qty {
            color: #888;
            font-size: 10px;
            margin-top: 4px;
        }


        /* AMOUNT */

        .amount {
            font-weight: 700;
        }

        .payment {
            font-size: 10px;
            color: #777;
            margin-top: 4px;
        }


        /* STATUS */

        .status {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 9px;
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


        /* ACTIONS */

        .actions {
            display: flex;
            gap: 6px;
        }

        .action-btn {
            width: 32px;
            height: 32px;
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
            border-color: #111;
        }


        /* EMPTY */

        .no-results {
            display: none;
            text-align: center;
            padding: 60px 20px;
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
            margin: 0;
            color: #888;
            font-size: 12px;
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
            width: 100%;
            max-width: 470px;
            background: #fff;
            border-radius: 8px;
            padding: 28px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 19px;
        }

        .close-btn {
            border: 0;
            background: none;
            font-size: 23px;
            color: #777;
            cursor: pointer;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 20px;
        }

        .detail {
            background: #f7f7f7;
            padding: 13px;
            border-radius: 5px;
        }

        .detail span {
            display: block;
            color: #888;
            font-size: 9px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .detail strong {
            font-size: 12px;
        }

        .modal label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .modal select {
            width: 100%;
            height: 43px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0 12px;
            outline: none;
            margin-bottom: 18px;
        }

        .save-btn {
            width: 100%;
            height: 43px;
            background: #111;
            color: #fff;
            border: 0;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }


        /* RESPONSIVE */

        @media (max-width: 1100px) {

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 700px) {

            .orders-page {
                padding: 25px 15px 50px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .panel-header {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                width: 100%;
            }

        }

        @media (max-width: 480px) {

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 10px;
            }

            .filters {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }

            .filter-btn {
                width: 100%;
            }

            .detail-grid {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>


<body>


<!-- NAVBAR -->

<header class="navbar">

    <div class="nav-container">

        <a href="<%= ctx %>/index.jsp"
           class="logo">
            SHOPZILLA
        </a>


        <nav class="nav-links">

            <a href="<%= ctx %>/index.jsp">
                Home
            </a>

            <a href="<%= ctx %>/admin/dashboard.jsp">
                Dashboard
            </a>

            <a href="<%= ctx %>/admin/users.jsp">
                Users
            </a>

            <a href="<%= ctx %>/admin/orders.jsp"
               class="active">
                Orders
            </a>

            <a href="<%= ctx %>/admin/listings.jsp">
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


<main class="orders-page">


    <!-- HEADER -->

    <div class="page-header">

        <div>

            <h1>
                Manage Orders
            </h1>

            <p>
                Monitor and manage all Shopzilla customer orders.
            </p>

        </div>


        <a href="<%= ctx %>/admin/dashboard.jsp"
           class="back-btn">

            <i class="fa-solid fa-arrow-left"></i>

            Dashboard

        </a>

    </div>


    <!-- STATS -->

    <section class="stats-grid">


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-cart-shopping"></i>
                </div>

                <div class="stat-change up">
                    +15.2%
                </div>

            </div>

            <span>Total Orders</span>

            <strong>8,942</strong>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-clock"></i>
                </div>

                <div class="stat-change up">
                    +6.8%
                </div>

            </div>

            <span>Processing</span>

            <strong>284</strong>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-truck"></i>
                </div>

                <div class="stat-change up">
                    +10.4%
                </div>

            </div>

            <span>Shipped</span>

            <strong>621</strong>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-indian-rupee-sign"></i>
                </div>

                <div class="stat-change up">
                    +18.9%
                </div>

            </div>

            <span>Revenue</span>

            <strong>₹48.6L</strong>

        </div>


    </section>


    <!-- ORDERS PANEL -->

    <section class="orders-panel">


        <div class="panel-header">

            <div>

                <h2>
                    All Orders
                </h2>

                <p>
                    Review order information and status.
                </p>

            </div>


            <div class="search-box">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    id="orderSearch"
                    placeholder="Search order or customer..."
                    onkeyup="filterOrders()">

            </div>

        </div>


        <!-- FILTERS -->

        <div class="filters">

            <button
                class="filter-btn active"
                onclick="setFilter(this,'all')">

                All Orders

            </button>


            <button
                class="filter-btn"
                onclick="setFilter(this,'processing')">

                Processing

            </button>


            <button
                class="filter-btn"
                onclick="setFilter(this,'shipped')">

                Shipped

            </button>


            <button
                class="filter-btn"
                onclick="setFilter(this,'delivered')">

                Delivered

            </button>


            <button
                class="filter-btn"
                onclick="setFilter(this,'cancelled')">

                Cancelled

            </button>

        </div>


        <!-- TABLE -->

        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>Order</th>

                    <th>Customer</th>

                    <th>Product</th>

                    <th>Amount</th>

                    <th>Payment</th>

                    <th>Status</th>

                    <th>Action</th>

                </tr>

                </thead>


                <tbody id="ordersTable">


                <!-- ORDER 1 -->

                <tr
                    class="order-row"
                    data-status="processing"
                    data-search="sz10045 arjun kumar">

                    <td>

                        <div class="order-id">
                            #SZ10045
                        </div>

                        <div class="order-date">
                            18 Sep 2026
                        </div>

                    </td>


                    <td>

                        <div class="customer">

                            <div class="avatar">
                                AK
                            </div>

                            <div>

                                <div class="customer-name">
                                    Arjun Kumar
                                </div>

                                <div class="customer-email">
                                    arjun@email.com
                                </div>

                            </div>

                        </div>

                    </td>


                    <td>

                        <div class="product-name">
                            Premium Cotton Oversized T-Shirt
                        </div>

                        <div class="product-qty">
                            Qty: 2 · Size: L
                        </div>

                    </td>


                    <td>

                        <div class="amount">
                            ₹2,499
                        </div>

                    </td>


                    <td>

                        <div>
                            UPI
                        </div>

                        <div class="payment">
                            Paid
                        </div>

                    </td>


                    <td>

                        <span class="status processing">
                            Processing
                        </span>

                    </td>


                    <td>

                        <div class="actions">

                            <button
                                class="action-btn"
                                onclick="viewOrder(
                                    'SZ10045',
                                    'Arjun Kumar',
                                    'Premium Cotton Oversized T-Shirt',
                                    '₹2,499',
                                    'UPI',
                                    'Processing'
                                )">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </td>

                </tr>


                <!-- ORDER 2 -->

                <tr
                    class="order-row"
                    data-status="shipped"
                    data-search="sz10044 priya sharma">

                    <td>

                        <div class="order-id">
                            #SZ10044
                        </div>

                        <div class="order-date">
                            17 Sep 2026
                        </div>

                    </td>


                    <td>

                        <div class="customer">

                            <div class="avatar">
                                PS
                            </div>

                            <div>

                                <div class="customer-name">
                                    Priya Sharma
                                </div>

                                <div class="customer-email">
                                    priya@email.com
                                </div>

                            </div>

                        </div>

                    </td>


                    <td>

                        <div class="product-name">
                            Urban Runner Sneakers
                        </div>

                        <div class="product-qty">
                            Qty: 1 · Size: 8
                        </div>

                    </td>


                    <td>

                        <div class="amount">
                            ₹3,199
                        </div>

                    </td>


                    <td>

                        <div>
                            Card
                        </div>

                        <div class="payment">
                            Paid
                        </div>

                    </td>


                    <td>

                        <span class="status shipped">
                            Shipped
                        </span>

                    </td>


                    <td>

                        <div class="actions">

                            <button
                                class="action-btn"
                                onclick="viewOrder(
                                    'SZ10044',
                                    'Priya Sharma',
                                    'Urban Runner Sneakers',
                                    '₹3,199',
                                    'Card',
                                    'Shipped'
                                )">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </td>

                </tr>


                <!-- ORDER 3 -->

                <tr
                    class="order-row"
                    data-status="delivered"
                    data-search="sz10043 rahul raj">

                    <td>

                        <div class="order-id">
                            #SZ10043
                        </div>

                        <div class="order-date">
                            15 Sep 2026
                        </div>

                    </td>


                    <td>

                        <div class="customer">

                            <div class="avatar">
                                RR
                            </div>

                            <div>

                                <div class="customer-name">
                                    Rahul Raj
                                </div>

                                <div class="customer-email">
                                    rahul@email.com
                                </div>

                            </div>

                        </div>

                    </td>


                    <td>

                        <div class="product-name">
                            Classic Casual Jacket
                        </div>

                        <div class="product-qty">
                            Qty: 1 · Size: M
                        </div>

                    </td>


                    <td>

                        <div class="amount">
                            ₹1,899
                        </div>

                    </td>


                    <td>

                        <div>
                            COD
                        </div>

                        <div class="payment">
                            Paid
                        </div>

                    </td>


                    <td>

                        <span class="status delivered">
                            Delivered
                        </span>

                    </td>


                    <td>

                        <div class="actions">

                            <button
                                class="action-btn"
                                onclick="viewOrder(
                                    'SZ10043',
                                    'Rahul Raj',
                                    'Classic Casual Jacket',
                                    '₹1,899',
                                    'COD',
                                    'Delivered'
                                )">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </td>

                </tr>


                <!-- ORDER 4 -->

                <tr
                    class="order-row"
                    data-status="cancelled"
                    data-search="sz10042 divya s">

                    <td>

                        <div class="order-id">
                            #SZ10042
                        </div>

                        <div class="order-date">
                            13 Sep 2026
                        </div>

                    </td>


                    <td>

                        <div class="customer">

                            <div class="avatar">
                                DS
                            </div>

                            <div>

                                <div class="customer-name">
                                    Divya S
                                </div>

                                <div class="customer-email">
                                    divya@email.com
                                </div>

                            </div>

                        </div>

                    </td>


                    <td>

                        <div class="product-name">
                            Slim Fit Denim Jeans
                        </div>

                        <div class="product-qty">
                            Qty: 1 · Size: 32
                        </div>

                    </td>


                    <td>

                        <div class="amount">
                            ₹1,299
                        </div>

                    </td>


                    <td>

                        <div>
                            UPI
                        </div>

                        <div class="payment">
                            Refunded
                        </div>

                    </td>


                    <td>

                        <span class="status cancelled">
                            Cancelled
                        </span>

                    </td>


                    <td>

                        <div class="actions">

                            <button
                                class="action-btn"
                                onclick="viewOrder(
                                    'SZ10042',
                                    'Divya S',
                                    'Slim Fit Denim Jeans',
                                    '₹1,299',
                                    'UPI',
                                    'Cancelled'
                                )">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </td>

                </tr>


                </tbody>

            </table>


            <div class="no-results"
                 id="noResults">

                <i class="fa-solid fa-box-open"></i>

                <h3>
                    No orders found
                </h3>

                <p>
                    Try changing the search or status filter.
                </p>

            </div>

        </div>

    </section>


</main>


<!-- ORDER DETAILS MODAL -->

<div class="modal-overlay"
     id="orderModal">

    <div class="modal">


        <div class="modal-header">

            <h3>
                Order Details
            </h3>

            <button
                class="close-btn"
                onclick="closeModal()">

                &times;

            </button>

        </div>


        <div class="detail-grid">

            <div class="detail">

                <span>
                    Order ID
                </span>

                <strong id="modalOrderId">
                    #SZ10045
                </strong>

            </div>


            <div class="detail">

                <span>
                    Customer
                </span>

                <strong id="modalCustomer">
                    Arjun Kumar
                </strong>

            </div>


            <div class="detail">

                <span>
                    Product
                </span>

                <strong id="modalProduct">
                    Product
                </strong>

            </div>


            <div class="detail">

                <span>
                    Amount
                </span>

                <strong id="modalAmount">
                    ₹0
                </strong>

            </div>


            <div class="detail">

                <span>
                    Payment
                </span>

                <strong id="modalPayment">
                    UPI
                </strong>

            </div>


            <div class="detail">

                <span>
                    Current Status
                </span>

                <strong id="modalStatus">
                    Processing
                </strong>

            </div>

        </div>


        <label>
            Update Status
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


        <button
            class="save-btn"
            onclick="saveStatus()">

            Save Status

        </button>


    </div>

</div>


<script>

    let currentFilter = "all";
    let selectedOrder = "";


    function setFilter(button, filter) {

        currentFilter = filter;

        document
            .querySelectorAll(".filter-btn")
            .forEach(btn => {

                btn.classList.remove("active");

            });

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

        const rows =
            document.querySelectorAll(".order-row");

        let visible = 0;


        rows.forEach(row => {

            const status =
                row.dataset.status;

            const data =
                row.dataset.search;

            const statusMatch =
                currentFilter === "all" ||
                status === currentFilter;

            const searchMatch =
                search === "" ||
                data.includes(search);


            if (statusMatch && searchMatch) {

                row.style.display = "table-row";

                visible++;

            } else {

                row.style.display = "none";

            }

        });


        document
            .getElementById("noResults")
            .style.display =
            visible === 0
                ? "block"
                : "none";

    }


    function viewOrder(
        orderId,
        customer,
        product,
        amount,
        payment,
        status
    ) {

        selectedOrder = orderId;

        document
            .getElementById("modalOrderId")
            .textContent = "#" + orderId;

        document
            .getElementById("modalCustomer")
            .textContent = customer;

        document
            .getElementById("modalProduct")
            .textContent = product;

        document
            .getElementById("modalAmount")
            .textContent = amount;

        document
            .getElementById("modalPayment")
            .textContent = payment;

        document
            .getElementById("modalStatus")
            .textContent = status;

        document
            .getElementById("newStatus")
            .value = status.toLowerCase();

        document
            .getElementById("orderModal")
            .classList.add("show");

    }


    function closeModal() {

        document
            .getElementById("orderModal")
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

        closeModal();

    }


    document
        .getElementById("orderModal")
        .addEventListener(
            "click",
            function(event) {

                if (event.target === this) {
                    closeModal();
                }

            }
        );

</script>


</body>

</html>