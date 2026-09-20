<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
/* ================= CART SESSION ================= */

List<Map<String, Object>> cart =
        (List<Map<String, Object>>) session.getAttribute("cart");

if (cart == null) {
    cart = new ArrayList<>();
    session.setAttribute("cart", cart);
}

/* ================= TOTAL ================= */

double subtotal = 0;

for (Map<String, Object> item : cart) {

    double price = ((Number) item.get("price")).doubleValue();
    int quantity = ((Number) item.get("quantity")).intValue();

    subtotal += price * quantity;
}

double delivery = 0;
double discount = 0;
double total = subtotal - discount;


/* ================= PLACE ORDER ================= */

String placeOrder = request.getParameter("placeOrder");

boolean orderPlaced = false;
String orderId = "";

if ("true".equals(placeOrder) && !cart.isEmpty()) {

    orderId = "SZ" + (100000 + new Random().nextInt(900000));

    List<Map<String, Object>> orders =
            (List<Map<String, Object>>) session.getAttribute("orders");

    if (orders == null) {
        orders = new ArrayList<>();
    }

    /* Copy cart items */

    List<Map<String, Object>> orderItems = new ArrayList<>();

    for (Map<String, Object> cartItem : cart) {

        Map<String, Object> item = new HashMap<>();

        item.put("name", cartItem.get("name"));
        item.put("price", cartItem.get("price"));
        item.put("image", cartItem.get("image"));
        item.put("quantity", cartItem.get("quantity"));

        orderItems.add(item);
    }

    /* Create order */

    Map<String, Object> order = new HashMap<>();

    order.put("orderId", orderId);
    order.put("items", orderItems);
    order.put("subtotal", subtotal);
    order.put("delivery", delivery);
    order.put("discount", discount);
    order.put("total", total);
    order.put("status", "PROCESSING");
    order.put("date", new Date());

    orders.add(0, order);

    session.setAttribute("orders", orders);

    /* Clear cart */

    cart.clear();
    session.setAttribute("cart", cart);

    orderPlaced = true;

    subtotal = 0;
    total = 0;
%>
<%
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Checkout | Shopzilla</title>

    <!-- QR CODE LIBRARY -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

    <!-- CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/navbar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/responsive.css">

    <!-- FONT AWESOME -->
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

        .checkout-page {
            max-width: 1250px;
            margin: auto;
            padding: 35px 5% 70px;
        }

        .checkout-title {
            margin-bottom: 30px;
        }

        .checkout-title h1 {
            margin: 0;
            font-size: 30px;
            font-weight: 800;
        }

        .checkout-title p {
            margin-top: 8px;
            color: #777;
            font-size: 13px;
        }

        .checkout-layout {
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 30px;
        }

        .checkout-left {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .checkout-box {
            background: #fff;
            border: 1px solid #e5e5e5;
            padding: 25px;
        }

        .box-title {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 22px;
        }

        .box-title span {
            width: 28px;
            height: 28px;
            background: #111;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 700;
        }

        .box-title h2 {
            margin: 0;
            font-size: 16px;
            text-transform: uppercase;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 17px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            height: 44px;
            border: 1px solid #ccc;
            padding: 0 12px;
            outline: none;
            font-size: 12px;
            background: #fff;
        }

        .form-group textarea {
            width: 100%;
            height: 80px;
            border: 1px solid #ccc;
            padding: 12px;
            outline: none;
            resize: vertical;
            font-size: 12px;
            font-family: Arial, sans-serif;
        }

        .address-type {
            display: flex;
            gap: 10px;
            margin-top: 5px;
        }

        .address-type label {
            border: 1px solid #ddd;
            padding: 10px 18px;
            cursor: pointer;
            font-size: 11px;
            font-weight: 700;
        }

        .payment-option {
            border: 1px solid #ddd;
            margin-bottom: 12px;
            padding: 17px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .payment-option:hover {
            border-color: #111;
        }

        .payment-icon {
            width: 35px;
            text-align: center;
            font-size: 19px;
        }

        .payment-details strong {
            display: block;
            font-size: 12px;
            margin-bottom: 4px;
        }

        .payment-details small {
            color: #777;
            font-size: 10px;
        }

        /* ================= UPI ================= */

        #upiSection {
            display: none;
            margin-top: 15px;
            padding: 25px;
            border: 1px solid #ddd;
            background: #fafafa;
            text-align: center;
        }

        #upiSection h3 {
            margin-top: 0;
            font-size: 16px;
        }

        #qrcode {
            display: inline-block;
            padding: 10px;
            background: white;
            border: 1px solid #ddd;
        }

        .upi-amount {
            margin-top: 15px;
            font-size: 18px;
            font-weight: 800;
        }

        .upi-id {
            color: #666;
            font-size: 12px;
            margin-top: 7px;
        }

        /* ================= CARD ================= */

        #cardSection {
            display: none;
            margin-top: 15px;
            padding: 20px;
            border: 1px solid #ddd;
            background: #fafafa;
        }

        #cardSection h3 {
            margin-top: 0;
            font-size: 14px;
        }

        .card-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .card-field {
            margin-bottom: 14px;
        }

        .card-field label {
            display: block;
            margin-bottom: 6px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .card-field input {
            width: 100%;
            height: 42px;
            border: 1px solid #ccc;
            padding: 0 10px;
            outline: none;
            font-size: 12px;
        }

        .cod-note {
            background: #f8f8f8;
            padding: 12px;
            font-size: 10px;
            color: #666;
            margin-top: 10px;
        }

        /* ================= SUMMARY ================= */

        .summary {
            background: #fff;
            border: 1px solid #e5e5e5;
            padding: 25px;
            height: fit-content;
            position: sticky;
            top: 90px;
        }

        .summary h2 {
            margin: 0 0 22px;
            font-size: 17px;
            text-transform: uppercase;
        }

        .summary-product {
            display: flex;
            gap: 12px;
            padding-bottom: 17px;
            border-bottom: 1px solid #eee;
            margin-bottom: 17px;
        }

        .summary-product img {
            width: 65px;
            height: 80px;
            object-fit: cover;
        }

        .summary-product-info {
            flex: 1;
        }

        .summary-product-info strong {
            display: block;
            font-size: 11px;
            margin-bottom: 5px;
        }

        .summary-product-info span {
            display: block;
            font-size: 10px;
            color: #777;
            margin-bottom: 5px;
        }

        .summary-product-price {
            font-size: 11px;
            font-weight: 700;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 14px;
            font-size: 12px;
            color: #555;
        }

        .summary-row.discount {
            color: #16823b;
        }

        .summary-total {
            border-top: 1px solid #ddd;
            margin-top: 18px;
            padding-top: 18px;
            display: flex;
            justify-content: space-between;
            font-size: 17px;
            font-weight: 800;
        }

        .place-order {
            width: 100%;
            height: 52px;
            margin-top: 23px;
            border: none;
            background: #111;
            color: #fff;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            cursor: pointer;
        }

        .place-order:hover {
            background: #d4145a;
        }

        .secure-checkout {
            text-align: center;
            margin-top: 17px;
            color: #777;
            font-size: 10px;
        }

        .back-cart {
            display: inline-block;
            margin-top: 15px;
            color: #555;
            text-decoration: none;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
        }

        /* ================= SUCCESS ================= */

        .success-message {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.65);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .success-card {
            width: 420px;
            max-width: 90%;
            background: #fff;
            text-align: center;
            padding: 40px 25px;
        }

        .success-card i {
            font-size: 50px;
            color: #16823b;
            margin-bottom: 18px;
        }

        .success-card h2 {
            margin: 0 0 10px;
            font-size: 22px;
        }

        .success-card p {
            color: #777;
            font-size: 12px;
            line-height: 1.6;
        }

        .success-card button {
            margin-top: 15px;
            padding: 13px 25px;
            border: none;
            background: #111;
            color: #fff;
            font-size: 10px;
            font-weight: 700;
            cursor: pointer;
        }

        @media (max-width: 900px) {

            .checkout-layout {
                grid-template-columns: 1fr;
            }

            .summary {
                position: static;
            }
        }

        @media (max-width: 600px) {

            .checkout-page {
                padding: 25px 15px 50px;
            }

            .checkout-title h1 {
                font-size: 24px;
            }

            .checkout-box {
                padding: 18px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .form-group.full {
                grid-column: auto;
            }

            .card-row {
                grid-template-columns: 1fr;
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


<!-- ================= CHECKOUT ================= -->

<main class="checkout-page">

    <div class="checkout-title">

        <h1>Checkout</h1>

        <p>Complete your order securely.</p>

    </div>


    <div class="checkout-layout">


        <!-- ================= LEFT ================= -->

        <div class="checkout-left">


            <!-- DELIVERY ADDRESS -->

            <section class="checkout-box">

                <div class="box-title">

                    <span>1</span>

                    <h2>Delivery Address</h2>

                </div>


                <div class="form-row">


                    <div class="form-group">

                        <label>Full Name</label>

                        <input type="text"
                               id="fullName"
                               placeholder="Enter your full name">

                    </div>


                    <div class="form-group">

                        <label>Mobile Number</label>

                        <input type="tel"
                               id="mobile"
                               placeholder="10 digit mobile number"
                               maxlength="10">

                    </div>


                    <div class="form-group full">

                        <label>Address</label>

                        <textarea id="address"
                                  placeholder="House No, Street, Area"></textarea>

                    </div>


                    <div class="form-group">

                        <label>City</label>

                        <input type="text"
                               id="city"
                               placeholder="City">

                    </div>


                    <div class="form-group">

                        <label>State</label>

                        <select id="state">

                            <option value="">
                                Select State
                            </option>

                            <option>Tamil Nadu</option>
                            <option>Kerala</option>
                            <option>Karnataka</option>
                            <option>Andhra Pradesh</option>
                            <option>Telangana</option>
                            <option>Maharashtra</option>
                            <option>Delhi</option>
                            <option>Other</option>

                        </select>

                    </div>


                    <div class="form-group">

                        <label>Pincode</label>

                        <input type="text"
                               id="pincode"
                               placeholder="6 digit pincode"
                               maxlength="6">

                    </div>


                    <div class="form-group">

                        <label>Address Type</label>

                        <div class="address-type">

                            <label>

                                <input type="radio"
                                       name="addressType"
                                       value="Home"
                                       checked>

                                Home

                            </label>


                            <label>

                                <input type="radio"
                                       name="addressType"
                                       value="Work">

                                Work

                            </label>

                        </div>

                    </div>

                </div>

            </section>


            <!-- ================= PAYMENT ================= -->

            <section class="checkout-box">

                <div class="box-title">

                    <span>2</span>

                    <h2>Payment Method</h2>

                </div>


                <!-- UPI -->

                <label class="payment-option">

                    <input type="radio"
                           name="payment"
                           value="UPI"
                           checked
                           onclick="selectPayment('UPI')">

                    <div class="payment-icon">

                        <i class="fa-solid fa-mobile-screen-button"></i>

                    </div>

                    <div class="payment-details">

                        <strong>UPI</strong>

                        <small>
                            Google Pay, PhonePe, Paytm and more
                        </small>

                    </div>

                </label>


                <!-- UPI QR -->

                <div id="upiSection">

                    <h3>Scan & Pay</h3>

                    <div id="qrcode"></div>

                    <div class="upi-amount">

                        Amount:
                        ₹<%= String.format("%,.2f", total) %>

                    </div>

                    <div class="upi-id">

                        UPI ID:
                        shopzilla@upi

                    </div>

                    <p style="font-size:10px;color:#777;">
                        Scan this QR using your UPI app.
                    </p>

                </div>


                <!-- CARD -->

                <label class="payment-option">

                    <input type="radio"
                           name="payment"
                           value="CARD"
                           onclick="selectPayment('CARD')">

                    <div class="payment-icon">

                        <i class="fa-regular fa-credit-card"></i>

                    </div>

                    <div class="payment-details">

                        <strong>Credit / Debit Card</strong>

                        <small>
                            Visa, Mastercard, RuPay and more
                        </small>

                    </div>

                </label>


                <!-- CARD DETAILS -->

                <div id="cardSection">

                    <h3>Card Details</h3>


                    <div class="card-field">

                        <label>Card Holder Name</label>

                        <input type="text"
                               id="cardName"
                               placeholder="Name on card"
                               maxlength="50">

                    </div>


                    <div class="card-field">

                        <label>Card Number</label>

                        <input type="text"
                               id="cardNumber"
                               placeholder="1234 5678 9012 3456"
                               maxlength="19"
                               oninput="formatCardNumber(this)">

                    </div>


                    <div class="card-row">

                        <div class="card-field">

                            <label>Expiry</label>

                            <input type="text"
                                   id="expiry"
                                   placeholder="MM/YY"
                                   maxlength="5"
                                   oninput="formatExpiry(this)">

                        </div>


                        <div class="card-field">

                            <label>CVV</label>

                            <input type="password"
                                   id="cvv"
                                   placeholder="123"
                                   maxlength="3">

                        </div>

                    </div>

                    <p style="font-size:10px;color:#777;">
                        Demo checkout only. Card details are not stored.
                    </p>

                </div>


                <!-- COD -->

                <label class="payment-option">

                    <input type="radio"
                           name="payment"
                           value="COD"
                           onclick="selectPayment('COD')">

                    <div class="payment-icon">

                        <i class="fa-solid fa-money-bill"></i>

                    </div>

                    <div class="payment-details">

                        <strong>Cash on Delivery</strong>

                        <small>
                            Pay when your order arrives
                        </small>

                    </div>

                </label>


                <div class="cod-note">

                    <i class="fa-solid fa-circle-info"></i>

                    This is a demo checkout.
                    No real payment will be processed.

                </div>

            </section>

        </div>


        <!-- ================= RIGHT SUMMARY ================= -->

        <aside class="summary">

            <h2>Order Summary</h2>


            <%
            if (!cart.isEmpty()) {

                for (Map<String, Object> item : cart) {

                    String name = item.get("name").toString();

                    String image = item.get("image").toString();

                    double price =
                            ((Number) item.get("price")).doubleValue();

                    int quantity =
                            ((Number) item.get("quantity")).intValue();
            %>


            <div class="summary-product">

                <img src="<%= request.getContextPath() %>/images/<%= image %>"
                     alt="<%= name %>">


                <div class="summary-product-info">

                    <strong>
                        <%= name %>
                    </strong>

                    <span>
                        Size: M | Qty: <%= quantity %>
                    </span>

                    <div class="summary-product-price">

                        ₹<%= String.format("%,.0f",
                                price * quantity) %>

                    </div>

                </div>

            </div>


            <%
                }
            } else {
            %>


            <p style="font-size:12px;color:#777;">
                Your cart is empty.
            </p>


            <%
            }
            %>


            <!-- SUBTOTAL -->

            <div class="summary-row">

                <span>Subtotal</span>

                <span>
                    ₹<%= String.format("%,.0f", subtotal) %>
                </span>

            </div>


            <!-- DELIVERY -->

            <div class="summary-row">

                <span>Delivery</span>

                <span>FREE</span>

            </div>


            <!-- DISCOUNT -->

            <div class="summary-row discount">

                <span>Discount</span>

                <span>
                    -₹<%= String.format("%,.0f", discount) %>
                </span>

            </div>


            <!-- TOTAL -->

            <div class="summary-total">

                <span>Total</span>

                <span>
                    ₹<%= String.format("%,.0f", total) %>
                </span>

            </div>


            <%
            if (!cart.isEmpty()) {
            %>

            <button class="place-order"
                    onclick="placeOrder()">

                <i class="fa-solid fa-lock"></i>

                &nbsp; Place Order

            </button>

            <%
            }
            %>


            <div class="secure-checkout">

                <i class="fa-solid fa-shield-halved"></i>

                Safe & Secure Checkout

            </div>


            <a href="${pageContext.request.contextPath}/buyer/cart.jsp"
               class="back-cart">

                <i class="fa-solid fa-arrow-left"></i>

                &nbsp; Back to Bag

            </a>

        </aside>

    </div>

</main>


<!-- ================= SUCCESS POPUP ================= -->

<%
if (orderPlaced) {
%>

<div class="success-message"
     id="successMessage">

    <div class="success-card">

        <i class="fa-solid fa-circle-check"></i>

        <h2>
            Order Placed Successfully!
        </h2>

        <p>
            Thank you for shopping with Shopzilla.
            Your order has been placed successfully.
        </p>

        <p>

            Order ID:

            <strong>
                <%= orderId %>
            </strong>

        </p>


        <button onclick="goToOrders()">

            View My Orders

        </button>

    </div>

</div>

<%
}
%>


<script>

/* ================= UPI ================= */

const totalAmount = <%= total %>;

const merchantUPI = "shopzilla@upi";


function generateQR() {

    const qrBox =
        document.getElementById("qrcode");

    qrBox.innerHTML = "";

    const upiURL =
        "upi://pay" +
        "?pa=" + encodeURIComponent(merchantUPI) +
        "&pn=" + encodeURIComponent("Shopzilla") +
        "&am=" + totalAmount.toFixed(2) +
        "&cu=INR";


    new QRCode(qrBox, {

        text: upiURL,

        width: 180,

        height: 180

    });

}


/* ================= PAYMENT SELECTION ================= */

function selectPayment(type) {

    const upiSection =
        document.getElementById("upiSection");

    const cardSection =
        document.getElementById("cardSection");


    if (type === "UPI") {

        upiSection.style.display = "block";

        cardSection.style.display = "none";

        generateQR();

    }

    else if (type === "CARD") {

        upiSection.style.display = "none";

        cardSection.style.display = "block";

    }

    else {

        upiSection.style.display = "none";

        cardSection.style.display = "none";

    }

}


/* ================= CARD NUMBER FORMAT ================= */

function formatCardNumber(input) {

    let value =
        input.value.replace(/\D/g, "");

    value =
        value.substring(0, 16);

    let formatted =
        value.match(/.{1,4}/g);

    input.value =
        formatted ? formatted.join(" ") : "";

}


/* ================= EXPIRY FORMAT ================= */

function formatExpiry(input) {

    let value =
        input.value.replace(/\D/g, "");

    value =
        value.substring(0, 4);

    if (value.length >= 3) {

        value =
            value.substring(0, 2)
            + "/"
            + value.substring(2);

    }

    input.value = value;

}


/* ================= PLACE ORDER ================= */

function placeOrder() {

    const name =
        document.getElementById("fullName")
            .value.trim();


    const mobile =
        document.getElementById("mobile")
            .value.trim();


    const address =
        document.getElementById("address")
            .value.trim();


    const city =
        document.getElementById("city")
            .value.trim();


    const state =
        document.getElementById("state")
            .value;


    const pincode =
        document.getElementById("pincode")
            .value.trim();


    if (name === "") {

        alert("Please enter your full name.");

        return;

    }


    if (!/^[0-9]{10}$/.test(mobile)) {

        alert("Please enter a valid 10 digit mobile number.");

        return;

    }


    if (address === "") {

        alert("Please enter your delivery address.");

        return;

    }


    if (city === "") {

        alert("Please enter your city.");

        return;

    }


    if (state === "") {

        alert("Please select your state.");

        return;

    }


    if (!/^[0-9]{6}$/.test(pincode)) {

        alert("Please enter a valid 6 digit pincode.");

        return;

    }


    const paymentElement =
        document.querySelector(
            'input[name="payment"]:checked'
        );


    if (!paymentElement) {

        alert("Please select a payment method.");

        return;

    }


    const payment =
        paymentElement.value;


    /* ================= CARD VALIDATION ================= */

    if (payment === "CARD") {

        const cardName =
            document.getElementById("cardName")
                .value.trim();


        const cardNumber =
            document.getElementById("cardNumber")
                .value.replace(/\s/g, "");


        const expiry =
            document.getElementById("expiry")
                .value.trim();


        const cvv =
            document.getElementById("cvv")
                .value.trim();


        if (cardName === "") {

            alert("Please enter card holder name.");

            return;

        }


        if (!/^[0-9]{16}$/.test(cardNumber)) {

            alert("Please enter a valid 16 digit card number.");

            return;

        }


        if (!/^(0[1-9]|1[0-2])\/[0-9]{2}$/.test(expiry)) {

            alert("Please enter valid expiry date MM/YY.");

            return;

        }


        if (!/^[0-9]{3}$/.test(cvv)) {

            alert("Please enter valid 3 digit CVV.");

            return;

        }

    }


    /* ================= UPI ================= */

    if (payment === "UPI") {

        alert(
            "Please scan the UPI QR code and complete the demo payment."
        );

    }


    console.log("Customer:", name);
    console.log("Mobile:", mobile);
    console.log("Address:", address);
    console.log("City:", city);
    console.log("State:", state);
    console.log("Pincode:", pincode);
    console.log("Payment:", payment);


    /*
       Demo checkout:
       No real payment processing.
       Server saves order in session.
    */

    window.location.href =
        "${pageContext.request.contextPath}/buyer/checkout.jsp?placeOrder=true";

}


/* ================= MY ORDERS ================= */

function goToOrders() {

    window.location.href =
        "${pageContext.request.contextPath}/buyer/orders.jsp";

}


/* ================= DEFAULT PAYMENT ================= */

document.addEventListener("DOMContentLoaded", function() {

    selectPayment("UPI");

});

</script>


</body>

</html>