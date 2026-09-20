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

    <title>Admin Dashboard | Shopzilla</title>

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

        .admin-page {
            max-width: 1450px;
            margin: auto;
            padding: 35px 30px 70px;
        }

        /* HEADER */

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            gap: 20px;
        }

        .page-header h1 {
            margin: 0 0 7px;
            font-size: 32px;
            letter-spacing: -.5px;
        }

        .page-header p {
            margin: 0;
            color: #777;
            font-size: 14px;
        }

        .admin-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #111;
            color: #fff;
            padding: 11px 17px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 600;
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
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 22px;
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .stat-icon {
            width: 46px;
            height: 46px;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f1f1f1;
            border-radius: 50%;
            font-size: 18px;
        }

        .stat-change {
            font-size: 11px;
            font-weight: 600;
        }

        .up {
            color: #16803c;
        }

        .down {
            color: #c62828;
        }

        .stat-card span {
            display: block;
            color: #888;
            font-size: 12px;
            margin-bottom: 7px;
        }

        .stat-card h2 {
            margin: 0;
            font-size: 27px;
        }

        /* GRID */

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1.7fr 1fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        .panel {
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
        }

        .panel-header h3 {
            margin: 0;
            font-size: 16px;
        }

        .panel-header a {
            color: #111;
            text-decoration: none;
            font-size: 11px;
            font-weight: 600;
        }

        .panel-body {
            padding: 20px;
        }

        /* SALES CHART */

        .chart {
            height: 250px;
            display: flex;
            align-items: flex-end;
            gap: 18px;
            padding: 15px 5px 0;
        }

        .bar-item {
            flex: 1;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            align-items: center;
            gap: 8px;
        }

        .bar {
            width: 100%;
            max-width: 45px;
            background: #111;
            border-radius: 4px 4px 0 0;
            min-height: 10px;
        }

        .bar-label {
            font-size: 10px;
            color: #777;
        }

        /* RECENT ORDERS */

        .order-list {
            display: flex;
            flex-direction: column;
        }

        .order-row {
            display: grid;
            grid-template-columns: 1fr auto auto;
            gap: 15px;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }

        .order-row:last-child {
            border-bottom: 0;
        }

        .order-id {
            font-size: 12px;
            font-weight: 700;
        }

        .order-customer {
            font-size: 10px;
            color: #888;
            margin-top: 4px;
        }

        .order-amount {
            font-size: 12px;
            font-weight: 700;
        }

        .status {
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

        /* QUICK ACTIONS */

        .quick-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
        }

        .quick-card {
            text-decoration: none;
            color: #222;
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 22px;
            transition: .2s;
        }

        .quick-card:hover {
            border-color: #111;
            transform: translateY(-2px);
        }

        .quick-icon {
            width: 43px;
            height: 43px;
            background: #f2f2f2;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }

        .quick-card h4 {
            margin: 0 0 6px;
            font-size: 13px;
        }

        .quick-card p {
            margin: 0;
            font-size: 10px;
            color: #888;
            line-height: 1.5;
        }

        /* ACTIVITY */

        .activity-list {
            display: flex;
            flex-direction: column;
        }

        .activity {
            display: flex;
            align-items: flex-start;
            gap: 13px;
            padding: 14px 0;
            border-bottom: 1px solid #eee;
        }

        .activity:last-child {
            border-bottom: 0;
        }

        .activity-icon {
            width: 35px;
            height: 35px;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f2f2f2;
            border-radius: 50%;
            font-size: 12px;
        }

        .activity-text {
            font-size: 12px;
            line-height: 1.5;
        }

        .activity-text strong {
            font-weight: 700;
        }

        .activity-time {
            color: #999;
            font-size: 10px;
            margin-top: 3px;
        }

        /* ALERT */

        .alert-box {
            background: #111;
            color: #fff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .alert-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .alert-icon {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #333;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .alert-box h4 {
            margin: 0 0 5px;
            font-size: 14px;
        }

        .alert-box p {
            margin: 0;
            font-size: 11px;
            color: #ccc;
        }

        .alert-btn {
            text-decoration: none;
            background: #fff;
            color: #111;
            padding: 10px 15px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 700;
            white-space: nowrap;
        }

        /* RESPONSIVE */

        @media (max-width: 1100px) {

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .quick-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 700px) {

            .admin-page {
                padding: 25px 15px 50px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .stats-grid {
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }

            .stat-card {
                padding: 16px;
            }

            .stat-card h2 {
                font-size: 22px;
            }

            .chart {
                gap: 8px;
            }

            .order-row {
                grid-template-columns: 1fr auto;
            }

            .order-row .status {
                grid-column: 2;
                grid-row: 1;
            }

            .order-amount {
                grid-column: 1;
                grid-row: 2;
            }

            .quick-grid {
                grid-template-columns: 1fr 1fr;
            }

            .alert-box {
                align-items: flex-start;
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .quick-grid {
                grid-template-columns: 1fr;
            }

            .chart {
                height: 200px;
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

            <a href="<%= ctx %>/buyer/products.jsp">
                Products
            </a>

            <a href="<%= ctx %>/admin/dashboard.jsp"
               class="active">
                Admin
            </a>

            <a href="<%= ctx %>/admin/users.jsp">
                Users
            </a>

            <a href="<%= ctx %>/admin/orders.jsp">
                Orders
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


<main class="admin-page">


    <!-- HEADER -->

    <div class="page-header">

        <div>

            <h1>
                Admin Dashboard
            </h1>

            <p>
                Manage Shopzilla users, products, orders and platform activity.
            </p>

        </div>

        <div class="admin-badge">

            <i class="fa-solid fa-shield-halved"></i>

            ADMIN PANEL

        </div>

    </div>


    <!-- ALERT -->

    <div class="alert-box">

        <div class="alert-left">

            <div class="alert-icon">

                <i class="fa-solid fa-triangle-exclamation"></i>

            </div>

            <div>

                <h4>
                    7 listings require moderation
                </h4>

                <p>
                    Review newly submitted products before they become visible.
                </p>

            </div>

        </div>

        <a href="<%= ctx %>/admin/listings.jsp"
           class="alert-btn">

            Review Listings

        </a>

    </div>


    <!-- STATS -->

    <section class="stats-grid">


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-users"></i>
                </div>

                <div class="stat-change up">
                    +12.4%
                </div>

            </div>

            <span>Total Users</span>

            <h2>4,286</h2>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <div class="stat-icon">
                    <i class="fa-solid fa-box"></i>
                </div>

                <div class="stat-change up">
                    +8.7%
                </div>

            </div>

            <span>Total Products</span>

            <h2>2,154</h2>

        </div>


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

            <h2>8,942</h2>

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

            <span>Total Revenue</span>

            <h2>₹48.6L</h2>

        </div>


    </section>


    <!-- SALES + ACTIVITY -->

    <section class="dashboard-grid">


        <!-- SALES -->

        <div class="panel">

            <div class="panel-header">

                <h3>
                    Sales Overview
                </h3>

                <a href="#">
                    Last 7 Days
                    <i class="fa-solid fa-chevron-down"></i>
                </a>

            </div>

            <div class="panel-body">

                <div class="chart">

                    <div class="bar-item">
                        <div class="bar"
                             style="height:42%;"></div>
                        <div class="bar-label">Mon</div>
                    </div>

                    <div class="bar-item">
                        <div class="bar"
                             style="height:65%;"></div>
                        <div class="bar-label">Tue</div>
                    </div>

                    <div class="bar-item">
                        <div class="bar"
                             style="height:51%;"></div>
                        <div class="bar-label">Wed</div>
                    </div>

                    <div class="bar-item">
                        <div class="bar"
                             style="height:78%;"></div>
                        <div class="bar-label">Thu</div>
                    </div>

                    <div class="bar-item">
                        <div class="bar"
                             style="height:60%;"></div>
                        <div class="bar-label">Fri</div>
                    </div>

                    <div class="bar-item">
                        <div class="bar"
                             style="height:92%;"></div>
                        <div class="bar-label">Sat</div>
                    </div>

                    <div class="bar-item">
                        <div class="bar"
                             style="height:73%;"></div>
                        <div class="bar-label">Sun</div>
                    </div>

                </div>

            </div>

        </div>


        <!-- ACTIVITY -->

        <div class="panel">

            <div class="panel-header">

                <h3>
                    Recent Activity
                </h3>

                <a href="#">
                    View All
                </a>

            </div>

            <div class="panel-body">

                <div class="activity-list">


                    <div class="activity">

                        <div class="activity-icon">
                            <i class="fa-solid fa-user-plus"></i>
                        </div>

                        <div class="activity-text">

                            <strong>
                                New seller registered
                            </strong>

                            <div>
                                Fashion Hub joined Shopzilla.
                            </div>

                            <div class="activity-time">
                                12 minutes ago
                            </div>

                        </div>

                    </div>


                    <div class="activity">

                        <div class="activity-icon">
                            <i class="fa-solid fa-box"></i>
                        </div>

                        <div class="activity-text">

                            <strong>
                                New products submitted
                            </strong>

                            <div>
                                5 products are waiting for review.
                            </div>

                            <div class="activity-time">
                                35 minutes ago
                            </div>

                        </div>

                    </div>


                    <div class="activity">

                        <div class="activity-icon">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </div>

                        <div class="activity-text">

                            <strong>
                                Orders increased
                            </strong>

                            <div>
                                46 new orders received today.
                            </div>

                            <div class="activity-time">
                                1 hour ago
                            </div>

                        </div>

                    </div>


                    <div class="activity">

                        <div class="activity-icon">
                            <i class="fa-solid fa-star"></i>
                        </div>

                        <div class="activity-text">

                            <strong>
                                New review reported
                            </strong>

                            <div>
                                A customer reported a review.
                            </div>

                            <div class="activity-time">
                                2 hours ago
                            </div>

                        </div>

                    </div>


                </div>

            </div>

        </div>


    </section>


    <!-- QUICK ACTIONS -->

    <div class="panel"
         style="margin-bottom:25px;">

        <div class="panel-header">

            <h3>
                Quick Management
            </h3>

        </div>

        <div class="panel-body">

            <div class="quick-grid">


                <a href="<%= ctx %>/admin/users.jsp"
                   class="quick-card">

                    <div class="quick-icon">
                        <i class="fa-solid fa-users"></i>
                    </div>

                    <h4>
                        Manage Users
                    </h4>

                    <p>
                        View buyers and sellers and manage accounts.
                    </p>

                </a>


                <a href="<%= ctx %>/admin/orders.jsp"
                   class="quick-card">

                    <div class="quick-icon">
                        <i class="fa-solid fa-receipt"></i>
                    </div>

                    <h4>
                        Manage Orders
                    </h4>

                    <p>
                        Monitor orders and update order information.
                    </p>

                </a>


                <a href="<%= ctx %>/admin/listings.jsp"
                   class="quick-card">

                    <div class="quick-icon">
                        <i class="fa-solid fa-box-open"></i>
                    </div>

                    <h4>
                        Product Listings
                    </h4>

                    <p>
                        Approve, reject and moderate seller products.
                    </p>

                </a>


                <a href="<%= ctx %>/buyer/products.jsp"
                   class="quick-card">

                    <div class="quick-icon">
                        <i class="fa-solid fa-store"></i>
                    </div>

                    <h4>
                        View Store
                    </h4>

                    <p>
                        Open the Shopzilla customer storefront.
                    </p>

                </a>


            </div>

        </div>

    </div>


    <!-- RECENT ORDERS -->

    <section class="panel">

        <div class="panel-header">

            <h3>
                Recent Orders
            </h3>

            <a href="<%= ctx %>/admin/orders.jsp">
                View All Orders
            </a>

        </div>


        <div class="order-list">


            <div class="order-row">

                <div>

                    <div class="order-id">
                        #SZ10045
                    </div>

                    <div class="order-customer">
                        Arjun Kumar · 18 Sep 2026
                    </div>

                </div>

                <div class="order-amount">
                    ₹2,499
                </div>

                <span class="status processing">
                    Processing
                </span>

            </div>


            <div class="order-row">

                <div>

                    <div class="order-id">
                        #SZ10044
                    </div>

                    <div class="order-customer">
                        Priya Sharma · 17 Sep 2026
                    </div>

                </div>

                <div class="order-amount">
                    ₹3,199
                </div>

                <span class="status shipped">
                    Shipped
                </span>

            </div>


            <div class="order-row">

                <div>

                    <div class="order-id">
                        #SZ10043
                    </div>

                    <div class="order-customer">
                        Rahul Raj · 15 Sep 2026
                    </div>

                </div>

                <div class="order-amount">
                    ₹1,899
                </div>

                <span class="status delivered">
                    Delivered
                </span>

            </div>


            <div class="order-row">

                <div>

                    <div class="order-id">
                        #SZ10042
                    </div>

                    <div class="order-customer">
                        Divya S · 13 Sep 2026
                    </div>

                </div>

                <div class="order-amount">
                    ₹1,299
                </div>

                <span class="status delivered">
                    Delivered
                </span>

            </div>


        </div>

    </section>


</main>


</body>

</html>