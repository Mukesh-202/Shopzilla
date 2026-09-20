<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Product Details | Shopzilla</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/navbar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/products.css">

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
            background: #fff;
            color: #111;
        }

        .product-page {
            padding: 35px 5% 70px;
        }

        .breadcrumb {
            margin-bottom: 30px;
            font-size: 12px;
            color: #777;
        }

        .breadcrumb a {
            color: #555;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            color: #d4145a;
        }

        .product-details {
            display: grid;
            grid-template-columns: 55% 45%;
            gap: 45px;
            max-width: 1250px;
            margin: auto;
        }

        /* IMAGE */

        .product-gallery {
            display: grid;
            grid-template-columns: 90px 1fr;
            gap: 15px;
        }

        .thumbnail-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .thumbnail {
            width: 85px;
            height: 110px;
            border: 1px solid #ddd;
            overflow: hidden;
            cursor: pointer;
        }

        .thumbnail.active {
            border: 2px solid #111;
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .main-image {
            position: relative;
            background: #f5f5f5;
            overflow: hidden;
        }

        .main-image img {
            width: 100%;
            height: 650px;
            object-fit: cover;
            display: block;
        }

        .image-badge {
            position: absolute;
            top: 18px;
            left: 18px;
            background: #111;
            color: #fff;
            padding: 8px 12px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .image-heart {
            position: absolute;
            top: 18px;
            right: 18px;
            width: 42px;
            height: 42px;
            border: none;
            border-radius: 50%;
            background: #fff;
            cursor: pointer;
            font-size: 16px;
        }

        .image-heart:hover {
            color: #d4145a;
        }

        /* INFORMATION */

        .product-info-large {
            padding: 10px 10px 10px 0;
        }

        .brand {
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .5px;
            margin-bottom: 8px;
        }

        .product-title {
            font-size: 27px;
            font-weight: 500;
            margin: 0 0 12px;
            line-height: 1.25;
        }

        .rating {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 7px 10px;
            border: 1px solid #ddd;
            font-size: 12px;
            margin-bottom: 20px;
        }

        .rating i {
            color: #f5a623;
        }

        .price {
            font-size: 25px;
            font-weight: 800;
        }

        .old-price-large {
            margin-left: 10px;
            color: #999;
            font-size: 15px;
            text-decoration: line-through;
            font-weight: 400;
        }

        .discount-large {
            margin-left: 8px;
            color: #d4145a;
            font-size: 13px;
            font-weight: 700;
        }

        .tax-info {
            margin-top: 6px;
            color: #16823b;
            font-size: 11px;
            font-weight: 600;
        }

        .divider {
            height: 1px;
            background: #eee;
            margin: 25px 0;
        }

        .section-label {
            margin-bottom: 12px;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
        }

        /* SIZE */

        .size-options {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .size-option {
            width: 55px;
            height: 42px;
            background: #fff;
            border: 1px solid #ccc;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }

        .size-option:hover,
        .size-option.selected {
            background: #111;
            color: #fff;
            border-color: #111;
        }

        .size-guide {
            margin-left: 12px;
            font-size: 11px;
            color: #d4145a;
            text-decoration: none;
            font-weight: 700;
        }

        /* QUANTITY */

        .quantity-box {
            display: flex;
            width: 130px;
            height: 42px;
            border: 1px solid #ccc;
        }

        .quantity-box button {
            width: 40px;
            border: none;
            background: #fff;
            cursor: pointer;
            font-size: 16px;
        }

        .quantity-box input {
            width: 50px;
            border: none;
            text-align: center;
            outline: none;
            font-size: 13px;
        }

        /* BUTTONS */

        .action-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-top: 25px;
        }

        .add-cart {
            height: 52px;
            background: #111;
            color: #fff;
            border: 1px solid #111;
            cursor: pointer;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .add-cart:hover {
            background: #d4145a;
            border-color: #d4145a;
        }

        .buy-now {
            height: 52px;
            background: #fff;
            color: #111;
            border: 1px solid #111;
            cursor: pointer;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .buy-now:hover {
            background: #111;
            color: #fff;
        }

        /* DELIVERY */

        .delivery-box {
            margin-top: 25px;
            padding: 18px;
            background: #fafafa;
            border: 1px solid #eee;
        }

        .delivery-title {
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .delivery-input {
            display: flex;
            height: 42px;
        }

        .delivery-input input {
            flex: 1;
            border: 1px solid #ccc;
            padding: 0 12px;
            outline: none;
            font-size: 12px;
        }

        .delivery-input button {
            width: 80px;
            border: none;
            background: #111;
            color: #fff;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
        }

        .delivery-result {
            margin-top: 10px;
            color: #16823b;
            font-size: 11px;
            display: none;
        }

        /* BENEFITS */

        .benefits {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin-top: 20px;
        }

        .benefit {
            padding: 15px 8px;
            text-align: center;
            border: 1px solid #eee;
            font-size: 10px;
            color: #555;
        }

        .benefit i {
            display: block;
            margin-bottom: 8px;
            font-size: 17px;
            color: #111;
        }

        /* DESCRIPTION */

        .description-section {
            max-width: 1250px;
            margin: 60px auto 0;
            border-top: 1px solid #eee;
            padding-top: 35px;
        }

        .description-section h2 {
            font-size: 18px;
            text-transform: uppercase;
            margin-bottom: 15px;
        }

        .description-section p {
            max-width: 850px;
            color: #666;
            font-size: 13px;
            line-height: 1.8;
        }

        .details-list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            max-width: 700px;
            gap: 12px;
            margin-top: 20px;
        }

        .detail-item {
            padding: 12px;
            background: #fafafa;
            font-size: 12px;
        }

        .detail-item strong {
            margin-right: 5px;
        }

        @media (max-width: 900px) {

            .product-details {
                grid-template-columns: 1fr;
            }

            .main-image img {
                height: 600px;
            }

        }

        @media (max-width: 600px) {

            .product-page {
                padding: 25px 15px 50px;
            }

            .product-gallery {
                display: block;
            }

            .thumbnail-list {
                flex-direction: row;
                margin-top: 10px;
                overflow-x: auto;
            }

            .thumbnail {
                min-width: 65px;
                width: 65px;
                height: 80px;
            }

            .main-image img {
                height: 480px;
            }

            .product-title {
                font-size: 22px;
            }

            .action-buttons {
                grid-template-columns: 1fr;
            }

            .benefits {
                grid-template-columns: 1fr;
            }

            .details-list {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<header class="main-header">

    <div class="header-container">

        <a
            href="${pageContext.request.contextPath}/"
            class="logo">

            SHOP<span>ZILLA</span>

        </a>


        <nav class="main-nav">

            <a href="${pageContext.request.contextPath}/">
                HOME
            </a>

            <a href="${pageContext.request.contextPath}/ProductServlet?category=Men">
                MEN
            </a>

            <a href="${pageContext.request.contextPath}/ProductServlet?category=Women">
                WOMEN
            </a>

            <a href="${pageContext.request.contextPath}/ProductServlet?category=Kids">
                KIDS
            </a>

            <a href="${pageContext.request.contextPath}/ProductServlet?category=Beauty">
                BEAUTY
            </a>

            <a href="${pageContext.request.contextPath}/ProductServlet?category=Footwear">
                FOOTWEAR
            </a>

            <a href="${pageContext.request.contextPath}/ProductServlet?category=Accessories">
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


<!-- ================= PRODUCT PAGE ================= -->

<main class="product-page">


    <div class="breadcrumb">

        <a href="${pageContext.request.contextPath}/">
            Home
        </a>

        &nbsp; / &nbsp;

        <a href="${pageContext.request.contextPath}/buyer/products.jsp">
            Products
        </a>

        &nbsp; / &nbsp;

        Premium Fashion Product

    </div>


    <div class="product-details">


        <!-- ================= GALLERY ================= -->

        <section class="product-gallery">


            <div class="thumbnail-list">

                <div
                    class="thumbnail active"
                    onclick="changeImage(this, 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&w=900&q=85')">

                    <img
                        src="https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&w=300&q=80"
                        alt="Product">

                </div>


                <div
                    class="thumbnail"
                    onclick="changeImage(this, 'https://images.unsplash.com/photo-1496747611176-843222e1e57c?auto=format&fit=crop&w=900&q=85')">

                    <img
                        src="https://images.unsplash.com/photo-1496747611176-843222e1e57c?auto=format&fit=crop&w=300&q=80"
                        alt="Product">

                </div>


                <div
                    class="thumbnail"
                    onclick="changeImage(this, 'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?auto=format&fit=crop&w=900&q=85')">

                    <img
                        src="https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?auto=format&fit=crop&w=300&q=80"
                        alt="Product">

                </div>


                <div
                    class="thumbnail"
                    onclick="changeImage(this, 'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?auto=format&fit=crop&w=900&q=85')">

                    <img
                        src="https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?auto=format&fit=crop&w=300&q=80"
                        alt="Product">

                </div>

            </div>


            <div class="main-image">

                <span class="image-badge">
                    Bestseller
                </span>


                <button
                    class="image-heart"
                    onclick="toggleHeart(this)">

                    <i class="fa-regular fa-heart"></i>

                </button>


                <img
                    id="mainProductImage"
                    src="https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&w=900&q=85"
                    alt="Premium Fashion Product">

            </div>

        </section>


        <!-- ================= INFORMATION ================= -->

        <section class="product-info-large">


            <div class="brand">
                Shopzilla
            </div>


            <h1 class="product-title">
                Premium Casual Fashion Shirt
            </h1>


            <div class="rating">

                <span>
                    4.5
                    <i class="fa-solid fa-star"></i>
                </span>

                <span>
                    128 Ratings
                </span>

            </div>


            <div>

                <span class="price">
                    ₹1,499
                </span>

                <span class="old-price-large">
                    ₹2,499
                </span>

                <span class="discount-large">
                    40% OFF
                </span>

            </div>


            <div class="tax-info">
                Inclusive of all taxes
            </div>


            <div class="divider"></div>


            <!-- SIZE -->

            <div class="section-label">

                Select Size

                <a
                    href="#"
                    class="size-guide">

                    Size Guide

                </a>

            </div>


            <div class="size-options">

                <button
                    class="size-option"
                    onclick="selectSize(this)">
                    S
                </button>

                <button
                    class="size-option selected"
                    onclick="selectSize(this)">
                    M
                </button>

                <button
                    class="size-option"
                    onclick="selectSize(this)">
                    L
                </button>

                <button
                    class="size-option"
                    onclick="selectSize(this)">
                    XL
                </button>

                <button
                    class="size-option"
                    onclick="selectSize(this)">
                    XXL
                </button>

            </div>


            <div class="divider"></div>


            <!-- QUANTITY -->

            <div class="section-label">
                Quantity
            </div>


            <div class="quantity-box">

                <button onclick="changeQuantity(-1)">
                    −
                </button>

                <input
                    id="quantity"
                    value="1"
                    readonly>

                <button onclick="changeQuantity(1)">
                    +
                </button>

            </div>


            <!-- BUTTONS -->

            <div class="action-buttons">

                <button
                    class="add-cart"
                    onclick="addToCart()">

                    <i class="fa-solid fa-bag-shopping"></i>

                    &nbsp; Add to Cart

                </button>


                <button
                    class="buy-now"
                    onclick="buyNow()">

                    Buy Now

                </button>

            </div>


            <!-- DELIVERY -->

            <div class="delivery-box">

                <div class="delivery-title">

                    <i class="fa-solid fa-location-dot"></i>

                    &nbsp; Check Delivery

                </div>


                <div class="delivery-input">

                    <input
                        type="text"
                        id="pincode"
                        placeholder="Enter 6-digit pincode"
                        maxlength="6">

                    <button
                        onclick="checkDelivery()">

                        CHECK

                    </button>

                </div>


                <div
                    id="deliveryResult"
                    class="delivery-result">

                </div>

            </div>


            <!-- BENEFITS -->

            <div class="benefits">

                <div class="benefit">

                    <i class="fa-solid fa-truck"></i>

                    Fast Delivery

                </div>


                <div class="benefit">

                    <i class="fa-solid fa-rotate-left"></i>

                    Easy Returns

                </div>


                <div class="benefit">

                    <i class="fa-solid fa-shield-halved"></i>

                    Secure Payment

                </div>

            </div>

        </section>

    </div>


    <!-- ================= DESCRIPTION ================= -->

    <section class="description-section">

        <h2>
            Product Description
        </h2>

        <p>
            Upgrade your everyday wardrobe with this premium casual
            fashion shirt from Shopzilla. Designed for comfort and
            modern style, this versatile piece can be paired with
            jeans, trousers or casual footwear for a contemporary look.
        </p>


        <div class="details-list">

            <div class="detail-item">
                <strong>Brand:</strong>
                Shopzilla
            </div>

            <div class="detail-item">
                <strong>Category:</strong>
                Men
            </div>

            <div class="detail-item">
                <strong>Material:</strong>
                Premium Cotton
            </div>

            <div class="detail-item">
                <strong>Fit:</strong>
                Regular Fit
            </div>

            <div class="detail-item">
                <strong>Pattern:</strong>
                Solid
            </div>

            <div class="detail-item">
                <strong>Occasion:</strong>
                Casual
            </div>

        </div>

    </section>

</main>


<script>

    function changeImage(element, imageUrl) {

        document
            .getElementById("mainProductImage")
            .src = imageUrl;

        document
            .querySelectorAll(".thumbnail")
            .forEach(function(item) {

                item.classList.remove("active");

            });

        element.classList.add("active");

    }


    function toggleHeart(button) {

        const icon =
            button.querySelector("i");

        if (icon.classList.contains("fa-regular")) {

            icon.classList.remove("fa-regular");
            icon.classList.add("fa-solid");

            button.style.color = "#d4145a";

        } else {

            icon.classList.remove("fa-solid");
            icon.classList.add("fa-regular");

            button.style.color = "#111";

        }

    }


    function selectSize(button) {

        document
            .querySelectorAll(".size-option")
            .forEach(function(item) {

                item.classList.remove("selected");

            });

        button.classList.add("selected");

    }


    function changeQuantity(value) {

        const quantityInput =
            document.getElementById("quantity");

        let quantity =
            parseInt(quantityInput.value);

        quantity += value;

        if (quantity < 1) {
            quantity = 1;
        }

        if (quantity > 10) {
            quantity = 10;
        }

        quantityInput.value = quantity;

    }


    function addToCart() {

        const quantity =
            document.getElementById("quantity").value;

        alert(
            "Premium Casual Fashion Shirt added to cart. Quantity: "
            + quantity
        );

    }


    function buyNow() {

        alert(
            "Buy Now selected. Checkout module will be connected next."
        );

    }


    function checkDelivery() {

        const pincode =
            document.getElementById("pincode").value;

        const result =
            document.getElementById("deliveryResult");

        if (!/^[0-9]{6}$/.test(pincode)) {

            result.style.display = "block";

            result.style.color = "#c62828";

            result.textContent =
                "Please enter a valid 6-digit pincode.";

            return;

        }

        result.style.display = "block";

        result.style.color = "#16823b";

        result.textContent =
            "Delivery available. Estimated delivery: 3–5 working days.";

    }

</script>


</body>

</html>