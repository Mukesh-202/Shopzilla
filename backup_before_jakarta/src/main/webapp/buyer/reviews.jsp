<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Reviews & Ratings | Shopzilla</title>

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

        .reviews-page {
            max-width: 1200px;
            margin: auto;
            padding: 35px 5% 70px;
        }

        .reviews-header {
            margin-bottom: 30px;
        }

        .reviews-header h1 {
            margin: 0;
            font-size: 30px;
            font-weight: 800;
        }

        .reviews-header p {
            margin-top: 8px;
            color: #777;
            font-size: 13px;
        }

        .review-layout {
            display: grid;
            grid-template-columns: 330px 1fr;
            gap: 25px;
            align-items: start;
        }

        .review-box {
            background: #fff;
            border: 1px solid #e5e5e5;
            padding: 25px;
        }

        .review-box h2 {
            margin: 0 0 22px;
            font-size: 17px;
            text-transform: uppercase;
        }

        .rating-summary {
            text-align: center;
            padding-bottom: 22px;
            border-bottom: 1px solid #eee;
        }

        .rating-number {
            font-size: 45px;
            font-weight: 800;
            line-height: 1;
        }

        .stars {
            margin: 10px 0;
            color: #f4b400;
            font-size: 19px;
        }

        .rating-summary p {
            margin: 0;
            color: #777;
            font-size: 10px;
        }

        .rating-bars {
            margin-top: 22px;
        }

        .rating-bar {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 10px;
        }

        .rating-bar span {
            width: 25px;
            font-size: 10px;
        }

        .bar {
            flex: 1;
            height: 6px;
            background: #eee;
            overflow: hidden;
        }

        .bar-fill {
            height: 100%;
            background: #111;
        }

        .percentage {
            width: 32px;
            text-align: right;
            font-size: 9px;
            color: #777;
        }

        .write-review {
            margin-top: 25px;
        }

        .form-group {
            margin-bottom: 17px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            height: 42px;
            border: 1px solid #ccc;
            padding: 0 11px;
            outline: none;
            font-size: 11px;
            background: #fff;
        }

        .form-group textarea {
            width: 100%;
            height: 105px;
            border: 1px solid #ccc;
            padding: 11px;
            resize: vertical;
            outline: none;
            font-size: 11px;
            font-family: Arial, sans-serif;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #111;
        }

        .star-selector {
            display: flex;
            gap: 6px;
            margin-top: 4px;
        }

        .star-selector i {
            font-size: 24px;
            color: #ccc;
            cursor: pointer;
        }

        .star-selector i.active {
            color: #f4b400;
        }

        .submit-review {
            width: 100%;
            height: 45px;
            border: none;
            background: #111;
            color: #fff;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            cursor: pointer;
        }

        .submit-review:hover {
            background: #d4145a;
        }

        .review-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .customer-review {
            background: #fff;
            border: 1px solid #e5e5e5;
            padding: 22px;
        }

        .customer-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }

        .customer-name {
            font-size: 12px;
            font-weight: 800;
        }

        .verified {
            display: block;
            margin-top: 5px;
            color: #16823b;
            font-size: 9px;
        }

        .review-stars {
            color: #f4b400;
            font-size: 13px;
        }

        .review-date {
            margin-top: 5px;
            color: #999;
            font-size: 9px;
        }

        .review-product {
            font-size: 10px;
            font-weight: 700;
            margin-bottom: 9px;
        }

        .review-title {
            font-size: 13px;
            font-weight: 800;
            margin-bottom: 7px;
        }

        .review-text {
            margin: 0;
            color: #555;
            font-size: 11px;
            line-height: 1.7;
        }

        .review-helpful {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 17px;
            padding-top: 14px;
            border-top: 1px solid #eee;
        }

        .review-helpful span {
            color: #777;
            font-size: 9px;
        }

        .helpful-btn {
            border: 1px solid #ddd;
            background: #fff;
            padding: 6px 10px;
            cursor: pointer;
            font-size: 9px;
        }

        .helpful-btn:hover {
            border-color: #111;
        }

        .review-product-card {
            display: flex;
            gap: 12px;
            background: #fafafa;
            padding: 12px;
            margin-bottom: 20px;
        }

        .review-product-card img {
            width: 60px;
            height: 75px;
            object-fit: cover;
        }

        .review-product-info {
            align-self: center;
        }

        .review-product-info strong {
            display: block;
            font-size: 11px;
            margin-bottom: 6px;
        }

        .review-product-info span {
            color: #777;
            font-size: 9px;
        }

        .success-message {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .65);
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .success-card {
            width: 400px;
            max-width: 90%;
            background: #fff;
            padding: 40px 25px;
            text-align: center;
        }

        .success-card i {
            color: #16823b;
            font-size: 48px;
            margin-bottom: 15px;
        }

        .success-card h2 {
            margin: 0 0 10px;
            font-size: 21px;
        }

        .success-card p {
            color: #777;
            font-size: 11px;
            line-height: 1.6;
        }

        .success-card button {
            margin-top: 12px;
            padding: 12px 24px;
            border: none;
            background: #111;
            color: #fff;
            font-size: 10px;
            font-weight: 700;
            cursor: pointer;
        }

        @media (max-width: 850px) {

            .review-layout {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 600px) {

            .reviews-page {
                padding: 25px 15px 50px;
            }

            .reviews-header h1 {
                font-size: 24px;
            }

            .customer-top {
                flex-direction: column;
                gap: 10px;
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


<!-- ================= PAGE ================= -->

<main class="reviews-page">


    <div class="reviews-header">

        <h1>
            Reviews & Ratings
        </h1>

        <p>
            Share your shopping experience and help other customers.
        </p>

    </div>


    <div class="review-layout">


        <!-- ================= LEFT ================= -->

        <aside>


            <div class="review-box">


                <h2>
                    Customer Rating
                </h2>


                <div class="rating-summary">

                    <div class="rating-number">
                        4.6
                    </div>

                    <div class="stars">
                        ★★★★★
                    </div>

                    <p>
                        Based on 128 verified reviews
                    </p>

                </div>


                <div class="rating-bars">


                    <div class="rating-bar">

                        <span>5★</span>

                        <div class="bar">
                            <div
                                class="bar-fill"
                                style="width:82%">
                            </div>
                        </div>

                        <span class="percentage">
                            82%
                        </span>

                    </div>


                    <div class="rating-bar">

                        <span>4★</span>

                        <div class="bar">
                            <div
                                class="bar-fill"
                                style="width:11%">
                            </div>
                        </div>

                        <span class="percentage">
                            11%
                        </span>

                    </div>


                    <div class="rating-bar">

                        <span>3★</span>

                        <div class="bar">
                            <div
                                class="bar-fill"
                                style="width:4%">
                            </div>
                        </div>

                        <span class="percentage">
                            4%
                        </span>

                    </div>


                    <div class="rating-bar">

                        <span>2★</span>

                        <div class="bar">
                            <div
                                class="bar-fill"
                                style="width:2%">
                            </div>
                        </div>

                        <span class="percentage">
                            2%
                        </span>

                    </div>


                    <div class="rating-bar">

                        <span>1★</span>

                        <div class="bar">
                            <div
                                class="bar-fill"
                                style="width:1%">
                            </div>
                        </div>

                        <span class="percentage">
                            1%
                        </span>

                    </div>


                </div>

            </div>


            <!-- WRITE REVIEW -->

            <div class="review-box write-review">

                <h2>
                    Write a Review
                </h2>


                <div class="review-product-card">

                    <img
                        src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=200&q=80"
                        alt="T Shirt">

                    <div class="review-product-info">

                        <strong>
                            Essential Cotton T-Shirt
                        </strong>

                        <span>
                            Order #SZ390821
                        </span>

                    </div>

                </div>


                <div class="form-group">

                    <label>
                        Your Rating
                    </label>

                    <div
                        class="star-selector"
                        id="starSelector">

                        <i
                            class="fa-solid fa-star"
                            data-rating="1"></i>

                        <i
                            class="fa-solid fa-star"
                            data-rating="2"></i>

                        <i
                            class="fa-solid fa-star"
                            data-rating="3"></i>

                        <i
                            class="fa-solid fa-star"
                            data-rating="4"></i>

                        <i
                            class="fa-solid fa-star"
                            data-rating="5"></i>

                    </div>

                </div>


                <div class="form-group">

                    <label>
                        Review Title
                    </label>

                    <input
                        type="text"
                        id="reviewTitle"
                        placeholder="Example: Great quality!">

                </div>


                <div class="form-group">

                    <label>
                        Your Review
                    </label>

                    <textarea
                        id="reviewText"
                        placeholder="Tell us about your product experience..."></textarea>

                </div>


                <button
                    class="submit-review"
                    onclick="submitReview()">

                    Submit Review

                </button>


            </div>


        </aside>


        <!-- ================= RIGHT ================= -->

        <section class="review-list">


            <!-- REVIEW 1 -->

            <div class="customer-review">

                <div class="customer-top">

                    <div>

                        <div class="customer-name">
                            Arjun
                        </div>

                        <span class="verified">
                            <i class="fa-solid fa-circle-check"></i>
                            Verified Buyer
                        </span>

                    </div>


                    <div>

                        <div class="review-stars">
                            ★★★★★
                        </div>

                        <div class="review-date">
                            12 September 2026
                        </div>

                    </div>

                </div>


                <div class="review-product">
                    Essential Cotton T-Shirt
                </div>

                <div class="review-title">
                    Excellent quality and fit
                </div>

                <p class="review-text">
                    The material is very comfortable and the fitting
                    is exactly as shown. Delivery was also quick.
                    Good value for money.
                </p>


                <div class="review-helpful">

                    <span>
                        Was this review helpful?
                    </span>

                    <button
                        class="helpful-btn"
                        onclick="helpful(this)">

                        <i class="fa-regular fa-thumbs-up"></i>
                        Yes

                    </button>

                    <button
                        class="helpful-btn"
                        onclick="helpful(this)">

                        No

                    </button>

                </div>

            </div>


            <!-- REVIEW 2 -->

            <div class="customer-review">

                <div class="customer-top">

                    <div>

                        <div class="customer-name">
                            Priya
                        </div>

                        <span class="verified">
                            <i class="fa-solid fa-circle-check"></i>
                            Verified Buyer
                        </span>

                    </div>


                    <div>

                        <div class="review-stars">
                            ★★★★☆
                        </div>

                        <div class="review-date">
                            8 September 2026
                        </div>

                    </div>

                </div>


                <div class="review-product">
                    Premium Casual Fashion Shirt
                </div>

                <div class="review-title">
                    Stylish and comfortable
                </div>

                <p class="review-text">
                    The shirt looks premium and feels comfortable.
                    Colour is also very close to the product images.
                    Slightly loose fit for me.
                </p>


                <div class="review-helpful">

                    <span>
                        Was this review helpful?
                    </span>

                    <button
                        class="helpful-btn"
                        onclick="helpful(this)">

                        <i class="fa-regular fa-thumbs-up"></i>
                        Yes

                    </button>

                    <button
                        class="helpful-btn"
                        onclick="helpful(this)">

                        No

                    </button>

                </div>

            </div>


            <!-- REVIEW 3 -->

            <div class="customer-review">

                <div class="customer-top">

                    <div>

                        <div class="customer-name">
                            Karthik
                        </div>

                        <span class="verified">
                            <i class="fa-solid fa-circle-check"></i>
                            Verified Buyer
                        </span>

                    </div>


                    <div>

                        <div class="review-stars">
                            ★★★★★
                        </div>

                        <div class="review-date">
                            2 September 2026
                        </div>

                    </div>

                </div>


                <div class="review-product">
                    Urban Running Sneakers
                </div>

                <div class="review-title">
                    Very good sneakers
                </div>

                <p class="review-text">
                    Lightweight and comfortable for daily use.
                    The sole has good grip and the design looks great.
                </p>


                <div class="review-helpful">

                    <span>
                        Was this review helpful?
                    </span>

                    <button
                        class="helpful-btn"
                        onclick="helpful(this)">

                        <i class="fa-regular fa-thumbs-up"></i>
                        Yes

                    </button>

                    <button
                        class="helpful-btn"
                        onclick="helpful(this)">

                        No

                    </button>

                </div>

            </div>


        </section>


    </div>


</main>


<!-- ================= SUCCESS ================= -->

<div
    class="success-message"
    id="successMessage">


    <div class="success-card">

        <i class="fa-solid fa-circle-check"></i>

        <h2>
            Review Submitted!
        </h2>

        <p>
            Thank you for sharing your experience with Shopzilla.
        </p>

        <button onclick="closeSuccess()">
            Continue
        </button>

    </div>

</div>


<script>

    let selectedRating = 0;


    const stars =
        document.querySelectorAll(
            "#starSelector i"
        );


    stars.forEach(function(star) {

        star.addEventListener(
            "click",
            function() {

                selectedRating =
                    parseInt(
                        this.getAttribute("data-rating")
                    );

                stars.forEach(function(item) {

                    const rating =
                        parseInt(
                            item.getAttribute("data-rating")
                        );

                    if (rating <= selectedRating) {

                        item.classList.add("active");

                    } else {

                        item.classList.remove("active");

                    }

                });

            }
        );

    });


    function submitReview() {

        const title =
            document.getElementById("reviewTitle")
                .value.trim();

        const review =
            document.getElementById("reviewText")
                .value.trim();


        if (selectedRating === 0) {

            alert("Please select a rating.");

            return;

        }


        if (title === "") {

            alert("Please enter a review title.");

            return;

        }


        if (review === "") {

            alert("Please write your review.");

            return;

        }


        document.getElementById("successMessage")
            .style.display = "flex";

    }


    function closeSuccess() {

        document.getElementById("successMessage")
            .style.display = "none";

        document.getElementById("reviewTitle")
            .value = "";

        document.getElementById("reviewText")
            .value = "";

        selectedRating = 0;

        stars.forEach(function(star) {

            star.classList.remove("active");

        });

    }


    function helpful(button) {

        button.innerHTML =
            '<i class="fa-solid fa-check"></i> Thank you';

        button.disabled = true;

    }

</script>


</body>

</html>