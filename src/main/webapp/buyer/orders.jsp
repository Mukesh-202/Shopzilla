<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
List<Map<String, Object>> orders =
    (List<Map<String, Object>>) session.getAttribute("orders");

if (orders == null) {
    orders = new ArrayList<>();
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Orders | Shopzilla</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/navbar.css">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/responsive.css">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #f7f7f7;
    color: #111;
}

.orders-page {
    max-width: 1100px;
    margin: auto;
    padding: 40px 5% 70px;
}

.orders-title {
    margin-bottom: 30px;
}

.orders-title h1 {
    margin: 0;
    font-size: 30px;
    font-weight: 800;
}

.orders-title p {
    margin-top: 8px;
    color: #777;
    font-size: 13px;
}

/* EMPTY ORDERS */

.empty-orders {
    background: #fff;
    border: 1px solid #e5e5e5;
    padding: 70px 20px;
    text-align: center;
}

.empty-orders i {
    font-size: 50px;
    color: #aaa;
    margin-bottom: 20px;
}

.empty-orders h2 {
    margin: 0 0 10px;
    font-size: 20px;
}

.empty-orders p {
    color: #777;
    font-size: 12px;
}

.shop-btn {
    display: inline-block;
    margin-top: 15px;
    padding: 14px 28px;
    background: #111;
    color: #fff;
    text-decoration: none;
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
}

/* ORDER CARD */

.order-card {
    background: #fff;
    border: 1px solid #e3e3e3;
    margin-bottom: 22px;
}

.order-header {
    padding: 18px 22px;
    background: #fafafa;
    border-bottom: 1px solid #eee;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.order-id {
    font-size: 12px;
    font-weight: 800;
}

.order-date {
    font-size: 10px;
    color: #777;
    margin-top: 5px;
}

.order-status {
    font-size: 10px;
    font-weight: 700;
    color: #16823b;
    text-transform: uppercase;
}

/* PRODUCTS */

.order-items {
    padding: 20px 22px;
}

.order-item {
    display: flex;
    gap: 18px;
    padding: 15px 0;
    border-bottom: 1px solid #eee;
}

.order-item:last-child {
    border-bottom: none;
}

.order-item img {
    width: 80px;
    height: 95px;
    object-fit: cover;
}

.order-item-info {
    flex: 1;
}

.order-item-info strong {
    display: block;
    font-size: 13px;
    margin-bottom: 8px;
}

.order-item-info span {
    display: block;
    color: #777;
    font-size: 11px;
    margin-bottom: 6px;
}

.order-item-price {
    font-size: 12px;
    font-weight: 700;
}

/* FOOTER */

.order-footer {
    border-top: 1px solid #eee;
    padding: 18px 22px;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.total-label {
    font-size: 11px;
    color: #777;
}

.total-price {
    font-size: 18px;
    font-weight: 800;
}

.track-btn {
    display: inline-block;
    padding: 11px 20px;
    border: 1px solid #111;
    color: #111;
    text-decoration: none;
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    cursor: pointer;
}

.track-btn:hover {
    background: #111;
    color: #fff;
}

/* RESPONSIVE */

@media (max-width: 600px) {

    .orders-page {
        padding: 25px 15px 50px;
    }

    .orders-title h1 {
        font-size: 24px;
    }

    .order-header {
        align-items: flex-start;
        gap: 10px;
    }

    .order-item img {
        width: 65px;
        height: 80px;
    }

    .order-footer {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
    }

}

</style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<header class="main-header">

    <div class="header-container">

        <a href="${pageContext.request.contextPath}/"
           class="logo">
            SHOP<span>ZILLA</span>
        </a>

        <nav class="main-nav">

            <a href="${pageContext.request.contextPath}/">
                HOME
            </a>

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Men">
                MEN
            </a>

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Women">
                WOMEN
            </a>

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Kids">
                KIDS
            </a>

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Beauty">
                BEAUTY
            </a>

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Footwear">
                FOOTWEAR
            </a>

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Accessories">
                ACCESSORIES
            </a>

        </nav>

        <div class="header-actions">

            <a href="${pageContext.request.contextPath}/auth/login.jsp">
                <i class="fa-regular fa-user"></i>
            </a>

            <a href="#">
                <i class="fa-regular fa-heart"></i>
            </a>

            <a href="${pageContext.request.contextPath}/buyer/cart.jsp">
                <i class="fa-solid fa-bag-shopping"></i>
            </a>

        </div>

    </div>

</header>


<!-- ================= ORDERS ================= -->

<main class="orders-page">

    <div class="orders-title">

        <h1>My Orders</h1>

        <p>
            Track and manage your Shopzilla orders.
        </p>

    </div>


<%
if (orders.isEmpty()) {
%>

    <!-- EMPTY ORDERS -->

    <div class="empty-orders">

        <i class="fa-solid fa-box-open"></i>

        <h2>No Orders Yet</h2>

        <p>
            You haven't placed any orders yet.
        </p>

        <a href="${pageContext.request.contextPath}/buyer/products.jsp"
           class="shop-btn">
            Continue Shopping
        </a>

    </div>

<%
} else {

    for (Map<String, Object> order : orders) {

        String orderId =
            order.get("orderId").toString();

        String status =
            order.get("status").toString();

        double orderTotal =
            ((Number) order.get("total")).doubleValue();

        Object dateObj =
            order.get("date");

        List<Map<String, Object>> items =
            (List<Map<String, Object>>) order.get("items");
%>

    <!-- ORDER CARD -->

    <div class="order-card">

        <!-- ORDER HEADER -->

        <div class="order-header">

            <div>

                <div class="order-id">
                    Order #<%= orderId %>
                </div>

                <div class="order-date">

<%
                if (dateObj != null) {
%>

                    <%= dateObj.toString() %>

<%
                }
%>

                </div>

            </div>

            <div class="order-status">

                <i class="fa-solid fa-circle-check"></i>

                <%= status %>

            </div>

        </div>


        <!-- ORDER ITEMS -->

        <div class="order-items">

<%
        if (items != null) {

            for (Map<String, Object> item : items) {

                String name =
                    item.get("name").toString();

                String image =
                    item.get("image").toString();

                double price =
                    ((Number) item.get("price")).doubleValue();

                int quantity =
                    ((Number) item.get("quantity")).intValue();

                double itemTotal =
                    price * quantity;
%>

            <div class="order-item">

                <img
                    src="<%= request.getContextPath() %>/images/<%= image %>"
                    alt="<%= name %>">

                <div class="order-item-info">

                    <strong>
                        <%= name %>
                    </strong>

                    <span>
                        Size: M
                    </span>

                    <span>
                        Quantity: <%= quantity %>
                    </span>

                    <div class="order-item-price">

                        ₹<%= String.format("%,.0f", itemTotal) %>

                    </div>

                </div>

            </div>

<%
            }
        }
%>

        </div>


        <!-- ORDER FOOTER -->

        <div class="order-footer">

            <div>

                <div class="total-label">
                    Order Total
                </div>

                <div class="total-price">
                    ₹<%= String.format("%,.0f", orderTotal) %>
                </div>

            </div>


            <!-- TRACK ORDER -->

            <a href="${pageContext.request.contextPath}/buyer/track-order.jsp?orderId=<%= orderId %>"
               class="track-btn">

                <i class="fa-solid fa-truck"></i>

                Track Order

            </a>

        </div>

    </div>

<%
    }
}
%>

</main>

</body>

</html>