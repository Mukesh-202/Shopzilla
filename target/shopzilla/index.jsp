<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <title>SHOPZILLA - Fashion & Lifestyle</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #fff;
            color: #111;
        }

        /* ================= NAVBAR ================= */

        nav {
            height: 70px;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 30px;
            border-bottom: 1px solid #eee;
            position: relative;
            z-index: 10;
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            margin-right: 10px;
        }

        nav a {
            color: #111;
            text-decoration: none;
            font-size: 12px;
            font-weight: bold;
        }

        nav a:hover {
            color: #777;
        }

        /* ================= HERO ================= */

        .hero {
            height: 420px;

            /* Premium grey gradient */
            background:
                radial-gradient(
                    circle at 75% 30%,
                    #8a8a8a 0%,
                    transparent 35%
                ),
                linear-gradient(
                    120deg,
                    #171717 0%,
                    #3d3d3d 50%,
                    #888 100%
                );

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;
            text-align: left;
        }

        .hero-content {
            width: 700px;
            margin-left: 100px;
        }

        .hero-small {
            font-size: 10px;
            letter-spacing: 5px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .hero h1 {
            font-size: 48px;
            line-height: 0.95;
            margin: 0 0 20px;
            font-weight: 900;
        }

        .hero p {
            font-size: 14px;
            margin-bottom: 25px;
        }

        .hero-buttons a {
            display: inline-block;
            padding: 13px 25px;
            margin-right: 8px;
            text-decoration: none;
            font-size: 11px;
            font-weight: bold;
            color: #111;
            background: white;
        }

        .hero-buttons a:hover {
            background: #111;
            color: white;
        }

        /* ================= FEATURES ================= */

        .features {
            height: 80px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 90px;
            border-bottom: 1px solid #eee;
        }

        .feature {
            text-align: center;
            font-size: 10px;
        }

        .feature strong {
            display: block;
            font-size: 11px;
            margin-bottom: 5px;
        }

        .feature span {
            color: #999;
            font-size: 9px;
        }

        /* ================= CATEGORIES ================= */

        .categories {
            padding: 55px 40px 80px;
            text-align: center;
        }

        .section-small {
            font-size: 9px;
            letter-spacing: 4px;
            color: #aaa;
            margin-bottom: 8px;
        }

        .categories h2 {
            font-size: 25px;
            margin: 0 0 8px;
        }

        .section-description {
            color: #aaa;
            font-size: 10px;
            margin-bottom: 30px;
        }

        .category-grid {
            max-width: 700px;
            margin: auto;

            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
        }

        .category-card {
            height: 200px;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            color: white;
            background: #ddd;
        }

        .category-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .category-card:hover img {
            transform: scale(1.05);
        }

        .category-overlay {
            position: absolute;
            left: 15px;
            bottom: 15px;
            text-align: left;
            z-index: 2;
        }

        .category-overlay small {
            font-size: 8px;
            letter-spacing: 2px;
        }

        .category-overlay h3 {
            margin: 5px 0;
            font-size: 17px;
        }

        .category-overlay span {
            font-size: 8px;
        }

        .category-card::after {
            content: "";
            position: absolute;
            inset: 0;

            background: linear-gradient(
                transparent 30%,
                rgba(0,0,0,0.65)
            );
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 800px) {

            nav {
                gap: 12px;
                padding: 0 10px;
            }

            nav a {
                font-size: 9px;
            }

            .logo {
                font-size: 16px;
            }

            .hero-content {
                width: 90%;
                margin-left: 0;
            }

            .hero h1 {
                font-size: 36px;
            }

            .features {
                gap: 20px;
            }

            .category-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

    </style>

</head>


<body>

<!-- ================= NAVBAR ================= -->

<nav>

    <div class="logo">
        SHOPZILLA
    </div>

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


<!-- ================= HERO ================= -->

<section class="hero">

    <div class="hero-content">

        <div class="hero-small">
            NEW SEASON
        </div>

        <h1>
            STYLE THAT<br>
            DEFINES YOU
        </h1>

        <p>
            Discover the latest fashion, footwear and lifestyle essentials at Shopzilla.
        </p>

        <div class="hero-buttons">

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Men">
                SHOP MEN
            </a>

            <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Women">
                SHOP WOMEN
            </a>

        </div>

    </div>

</section>


<!-- ================= FEATURES ================= -->

<section class="features">

    <div class="feature">
        <strong>🚚 FREE SHIPPING</strong>
        <span>On orders above ₹999</span>
    </div>

    <div class="feature">
        <strong>↩ EASY RETURNS</strong>
        <span>Hassle-free returns</span>
    </div>

    <div class="feature">
        <strong>🛡 SECURE PAYMENT</strong>
        <span>100% secure checkout</span>
    </div>

    <div class="feature">
        <strong>🎧 24/7 SUPPORT</strong>
        <span>We're here to help</span>
    </div>

</section>


<!-- ================= CATEGORIES ================= -->

<section class="categories">

    <div class="section-small">
        EXPLORE
    </div>

    <h2>
        SHOP BY CATEGORIES
    </h2>

    <div class="section-description">
        Discover something for every style
    </div>


    <div class="category-grid">


        <!-- MEN -->

        <a class="category-card"
           href="${pageContext.request.contextPath}/buyer/products.jsp?category=Men">

            <img src="${pageContext.request.contextPath}/images/men1.jpg"
                 alt="Men">

            <div class="category-overlay">
                <small>01</small>
                <h3>MEN</h3>
                <span>EXPLORE COLLECTION</span>
            </div>

        </a>


        <!-- WOMEN -->

        <a class="category-card"
           href="${pageContext.request.contextPath}/buyer/products.jsp?category=Women">

            <img src="${pageContext.request.contextPath}/images/women1.jpg"
                 alt="Women">

            <div class="category-overlay">
                <small>02</small>
                <h3>WOMEN</h3>
                <span>EXPLORE COLLECTION</span>
            </div>

        </a>


        <!-- KIDS -->

        <a class="category-card"
           href="${pageContext.request.contextPath}/buyer/products.jsp?category=Kids">

            <img src="${pageContext.request.contextPath}/images/kids1.jpg"
                 alt="Kids">

            <div class="category-overlay">
                <small>03</small>
                <h3>KIDS</h3>
                <span>EXPLORE COLLECTION</span>
            </div>

        </a>


        <!-- FOOTWEAR -->

        <a class="category-card"
           href="${pageContext.request.contextPath}/buyer/products.jsp?category=Footwear">

            <img src="${pageContext.request.contextPath}/images/footwear1.jpg"
                 alt="Footwear">

            <div class="category-overlay">
                <small>04</small>
                <h3>FOOTWEAR</h3>
                <span>EXPLORE COLLECTION</span>
            </div>

        </a>


        <!-- BEAUTY -->

        <a class="category-card"
           href="${pageContext.request.contextPath}/buyer/products.jsp?category=Beauty">

            <img src="${pageContext.request.contextPath}/images/beauty1.webp"
                 alt="Beauty">

            <div class="category-overlay">
                <small>05</small>
                <h3>BEAUTY</h3>
                <span>EXPLORE COLLECTION</span>
            </div>

        </a>


        <!-- ACCESSORIES -->

        <a class="category-card"
           href="${pageContext.request.contextPath}/buyer/products.jsp?category=Accessories">

            <img src="${pageContext.request.contextPath}/images/accessories2.webp"
                 alt="Accessories">

            <div class="category-overlay">
                <small>06</small>
                <h3>ACCESSORIES</h3>
                <span>EXPLORE COLLECTION</span>
            </div>

        </a>


    </div>

</section>


<!-- ================= LUMA ================= -->

<jsp:include page="/luma.jsp" />


</body>

</html>