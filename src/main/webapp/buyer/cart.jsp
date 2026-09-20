<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.*" %>

<%
    // =========================
    // GET PRODUCT FROM REQUEST
    // =========================

    String productName = request.getParameter("name");
    String productPrice = request.getParameter("price");
    String productImage = request.getParameter("image");

    // =========================
    // GET CART FROM SESSION
    // =========================

    List<Map<String, Object>> cart =
        (List<Map<String, Object>>) session.getAttribute("cart");

    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }

    // =========================
    // ADD PRODUCT TO CART
    // =========================

    if (productName != null &&
        productPrice != null &&
        productImage != null &&
        !productName.trim().isEmpty()) {

        boolean found = false;

        for (Map<String, Object> item : cart) {

            if (item.get("name").toString().equals(productName)) {

                int oldQty = (Integer) item.get("quantity");

                item.put("quantity", oldQty + 1);

                found = true;
                break;
            }
        }

        if (!found) {

            Map<String, Object> item = new HashMap<>();

            item.put("name", productName);
            item.put("price", Double.parseDouble(productPrice));
            item.put("image", productImage);
            item.put("quantity", 1);

            cart.add(item);
        }
    }

    // =========================
    // REMOVE PRODUCT
    // =========================

    String removeIndex = request.getParameter("remove");

    if (removeIndex != null) {

        try {

            int index = Integer.parseInt(removeIndex);

            if (index >= 0 && index < cart.size()) {
                cart.remove(index);
            }

        } catch (Exception e) {
            // ignore invalid index
        }
    }

    // =========================
    // CALCULATE SUBTOTAL
    // =========================

    double subtotal = 0;

    for (Map<String, Object> item : cart) {

        double price = (Double) item.get("price");
        int quantity = (Integer) item.get("quantity");

        subtotal += price * quantity;
    }

    double delivery = 0;
    double discount = 0;
    double total = subtotal - discount;
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Shopping Bag | Shopzilla</title>

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

        .cart-page {
            padding: 40px 5% 70px;
            min-height: 80vh;
        }

        .cart-header {
            margin-bottom: 30px;
        }

        .cart-header h1 {
            margin: 0;
            font-size: 30px;
            font-weight: 800;
        }

        .cart-header p {
            margin-top: 8px;
            color: #777;
            font-size: 13px;
        }

        .cart-layout {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 30px;
            max-width: 1250px;
            margin: auto;
        }

        .cart-items {
            background: #fff;
            border: 1px solid #eee;
        }

        .cart-item {
            display: grid;
            grid-template-columns: 125px 1fr auto;
            gap: 20px;
            padding: 20px;
            border-bottom: 1px solid #eee;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 125px;
            height: 160px;
            background: #f5f5f5;
            overflow: hidden;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .item-info {
            padding-top: 3px;
        }

        .item-brand {
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            margin-bottom: 7px;
        }

        .item-name {
            font-size: 15px;
            margin-bottom: 9px;
        }

        .item-size {
            color: #777;
            font-size: 11px;
            margin-bottom: 15px;
        }

        .quantity-control {
            display: flex;
            width: 110px;
            height: 34px;
            border: 1px solid #ccc;
        }

        .quantity-control button {
            width: 32px;
            border: none;
            background: #fff;
            cursor: pointer;
        }

        .quantity-control input {
            width: 44px;
            border: none;
            text-align: center;
            outline: none;
            font-size: 12px;
        }

        .item-actions {
            margin-top: 15px;
            display: flex;
            gap: 15px;
        }

        .item-actions button {
            border: none;
            background: transparent;
            padding: 0;
            color: #555;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
        }

        .item-actions button:hover {
            color: #d4145a;
        }

        .item-price {
            text-align: right;
            min-width: 100px;
        }

        .current-price {
            font-size: 16px;
            font-weight: 800;
        }

        .summary {
            background: #fff;
            border: 1px solid #eee;
            padding: 25px;
            height: fit-content;
            position: sticky;
            top: 90px;
        }

        .summary h2 {
            margin: 0 0 25px;
            font-size: 17px;
            text-transform: uppercase;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 13px;
            color: #555;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            border-top: 1px solid #eee;
            padding-top: 18px;
            margin-top: 18px;
            font-size: 17px;
            font-weight: 800;
        }

        .coupon {
            display: flex;
            margin: 22px 0;
            height: 42px;
        }

        .coupon input {
            flex: 1;
            border: 1px solid #ccc;
            padding: 0 10px;
            outline: none;
            font-size: 11px;
        }

        .coupon button {
            width: 75px;
            border: none;
            background: #111;
            color: #fff;
            font-size: 10px;
            font-weight: 700;
            cursor: pointer;
        }

        .checkout-btn {
            width: 100%;
            height: 50px;
            border: none;
            background: #111;
            color: #fff;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            cursor: pointer;
        }

        .checkout-btn:hover {
            background: #d4145a;
        }

        .continue-shopping {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #555;
            font-size: 11px;
            font-weight: 700;
            text-decoration: none;
            text-transform: uppercase;
        }

        .secure-note {
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1px solid #eee;
            text-align: center;
            color: #777;
            font-size: 10px;
        }

        .secure-note i {
            margin-right: 5px;
            color: #16823b;
        }

        .empty-cart {
            background: #fff;
            border: 1px solid #eee;
            text-align: center;
            padding: 80px 20px;
        }

        .empty-cart i {
            font-size: 50px;
            color: #bbb;
            margin-bottom: 20px;
        }

        .empty-cart h2 {
            margin: 0 0 10px;
            font-size: 22px;
        }

        .empty-cart p {
            color: #777;
            font-size: 13px;
            margin-bottom: 25px;
        }

        .shop-btn {
            display: inline-block;
            padding: 13px 25px;
            background: #111;
            color: #fff;
            text-decoration: none;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        @media (max-width: 900px) {

            .cart-layout {
                grid-template-columns: 1fr;
            }

            .summary {
                position: static;
            }
        }

        @media (max-width: 600px) {

            .cart-page {
                padding: 25px 15px 50px;
            }

            .cart-header h1 {
                font-size: 24px;
            }

            .cart-item {
                grid-template-columns: 90px 1fr;
                gap: 15px;
                padding: 15px;
            }

            .item-image {
                width: 90px;
                height: 120px;
            }

            .item-price {
                grid-column: 2;
                text-align: left;
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


<!-- ================= CART ================= -->

<main class="cart-page">

    <div class="cart-header">

        <h1>Shopping Bag</h1>

        <p>Review your items before checkout.</p>

    </div>


<%
    if (cart.isEmpty()) {
%>

    <!-- ================= EMPTY CART ================= -->

    <div class="empty-cart">

        <i class="fa-solid fa-bag-shopping"></i>

        <h2>Your bag is empty</h2>

        <p>
            Looks like you haven't added anything to your bag yet.
        </p>

        <a
            href="${pageContext.request.contextPath}/buyer/products.jsp"
            class="shop-btn">
            Start Shopping
        </a>

    </div>

<%
    } else {
%>

    <!-- ================= CART LAYOUT ================= -->

    <div class="cart-layout">

        <!-- ================= CART ITEMS ================= -->

        <section class="cart-items">

<%
            for (int i = 0; i < cart.size(); i++) {

                Map<String, Object> item = cart.get(i);

                String name = item.get("name").toString();
                String image = item.get("image").toString();

                double price = (Double) item.get("price");

                int quantity =
                    (Integer) item.get("quantity");
%>

            <div class="cart-item">

                <div class="item-image">

                    <img
                        src="<%= request.getContextPath() %>/images/<%= image %>"
                        alt="<%= name %>">

                </div>


                <div class="item-info">

                    <div class="item-brand">
                        SHOPZILLA
                    </div>

                    <div class="item-name">
                        <%= name %>
                    </div>

                    <div class="item-size">
                        Size: M
                    </div>


                    <div class="quantity-control">

                        <button type="button"
                                onclick="changeQuantity(<%= i %>, -1)">
                            −
                        </button>

                        <input
                            type="text"
                            value="<%= quantity %>"
                            readonly>

                        <button type="button"
                                onclick="changeQuantity(<%= i %>, 1)">
                            +
                        </button>

                    </div>


                    <div class="item-actions">

                        <button
                            type="button"
                            onclick="removeItem(<%= i %>)">

                            <i class="fa-regular fa-trash-can"></i>
                            REMOVE

                        </button>

                        <button type="button">

                            <i class="fa-regular fa-heart"></i>
                            SAVE FOR LATER

                        </button>

                    </div>

                </div>


                <div class="item-price">

                    <span class="current-price">

                        ₹<%= String.format("%,.0f", price) %>

                    </span>

                </div>

            </div>

<%
            }
%>

        </section>


        <!-- ================= ORDER SUMMARY ================= -->

        <aside class="summary">

            <h2>Order Summary</h2>


            <div class="summary-row">

                <span>Subtotal</span>

                <span>
                    ₹<%= String.format("%,.0f", subtotal) %>
                </span>

            </div>


            <div class="summary-row">

                <span>Delivery</span>

                <span>FREE</span>

            </div>


            <div class="coupon">

                <input
                    type="text"
                    id="coupon"
                    placeholder="Enter coupon code">

                <button onclick="applyCoupon()">
                    APPLY
                </button>

            </div>


            <div class="summary-total">

                <span>Total</span>

                <span>
                    ₹<%= String.format("%,.0f", total) %>
                </span>

            </div>


            <button
                class="checkout-btn"
                onclick="goToCheckout()">

                PROCEED TO CHECKOUT

            </button>


            <a
                href="${pageContext.request.contextPath}/buyer/products.jsp"
                class="continue-shopping">

                <i class="fa-solid fa-arrow-left"></i>

                &nbsp; CONTINUE SHOPPING

            </a>


            <div class="secure-note">

                <i class="fa-solid fa-lock"></i>

                Secure and encrypted checkout

            </div>

        </aside>

    </div>

<%
    }
%>

</main>


<script>

    function changeQuantity(index, change) {

        window.location.href =
            "${pageContext.request.contextPath}/buyer/cart.jsp"
            + "?index=" + index
            + "&change=" + change;
    }


    function removeItem(index) {

        window.location.href =
            "${pageContext.request.contextPath}/buyer/cart.jsp"
            + "?remove=" + index;
    }


    function applyCoupon() {

        const coupon =
            document.getElementById("coupon").value
            .trim()
            .toUpperCase();

        if (coupon === "") {

            alert("Please enter a coupon code.");

            return;
        }

        if (coupon === "SHOP10") {

            alert("Coupon applied!");

        } else {

            alert("Invalid coupon code.");

        }
    }


    function goToCheckout() {

        window.location.href =
            "${pageContext.request.contextPath}/buyer/checkout.jsp";

    }

</script>

</body>

</html>