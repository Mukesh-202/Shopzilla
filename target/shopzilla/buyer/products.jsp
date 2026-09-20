<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.shopzilla.model.Product" %>
<%@ page import="com.shopzilla.service.ProductService" %>

<%
    String category = request.getParameter("category");

    if (category == null || category.trim().isEmpty()) {
        category = "All";
    }

    String[] names;
    String[] prices;
    String[] images;
    String[] badges;

    // ================= MEN =================
    if (category.equalsIgnoreCase("Men")) {

        names = new String[]{
            "Black T-Shirt",
            "Blue Jeans",
            "White Shirt",
            "Hoodie",
            "Sneakers",
            "Coat"
        };

        prices = new String[]{
            "899",
            "1499",
            "999",
            "1199",
            "1999",
            "1799"
        };

        images = new String[]{
            "men1.jpg",
            "men2.jpg",
            "men3.webp",
            "men4.jpg",
            "men5.webp",
            "men6.jpg"
        };

        badges = new String[]{
            "New",
            "Bestseller",
            "New",
            "Trending",
            "Bestseller",
            "New"
        };

    // ================= WOMEN =================
    } else if (category.equalsIgnoreCase("Women")) {

        names = new String[]{
            "Red Dress",
            "Women Top",
            "Women Jeans",
            "Women Heels",
            "Hand Bag"
        };

        prices = new String[]{
            "1299",
            "899",
            "1499",
            "1899",
            "799"
        };

        images = new String[]{
            "women1.jpg",
            "women2.webp",
            "women3.jpg",
            "women4.jpg",
            "women5.webp"
        };

        badges = new String[]{
            "Trending",
            "New",
            "Bestseller",
            "New",
            "Sale"
        };

    // ================= KIDS =================
    } else if (category.equalsIgnoreCase("Kids")) {

        names = new String[]{
            "Kids T-Shirt",
            "Kids Jeans",
            "Kids Dress",
            "Kids Sneakers",
            "Kids Backpack"
        };

        prices = new String[]{
            "599",
            "899",
            "999",
            "1199",
            "699"
        };

        images = new String[]{
            "kids1.jpg",
            "kids2.webp",
            "kids3.webp",
            "kids4.webp",
            "kids5.jpg"
        };

        badges = new String[]{
            "New",
            "Bestseller",
            "Trending",
            "New",
            "Sale"
        };

    // ================= FOOTWEAR =================
    } else if (category.equalsIgnoreCase("Footwear")) {

        names = new String[]{
            "Running Shoes",
            "Casual Sneakers",
            "Sports Shoes",
            "Women Heels",
            "Sandals"
        };

        prices = new String[]{
            "1999",
            "1799",
            "2299",
            "1899",
            "799"
        };

        images = new String[]{
            "footwear1.jpg",
            "footwear2.jpg",
            "footwear3.webp",
            "footwear4.jpg",
            "footwear5.jpg"
        };

        badges = new String[]{
            "Bestseller",
            "New",
            "Trending",
            "New",
            "Sale"
        };

    // ================= BEAUTY =================
    } else if (category.equalsIgnoreCase("Beauty")) {

        names = new String[]{
            "Face Cream",
            "Lipstick",
            "Makeup Kit",
            "Perfume",
            "Makeup Brushes Set"
        };

        prices = new String[]{
            "699",
            "499",
            "1299",
            "999",
            "599"
        };

        images = new String[]{
            "beauty1.webp",
            "beauty2.jpg",
            "beauty3.webp",
            "beauty4.webp",
            "beauty5.jpg"
        };

        badges = new String[]{
            "New",
            "Trending",
            "Bestseller",
            "New",
            "Sale"
        };

    // ================= ACCESSORIES =================
    } else if (category.equalsIgnoreCase("Accessories")) {

        names = new String[]{
            "Hand Bag",
            "Watch",
            "Sunglasses",
            "Backpack",
            "Wallet"
        };

        prices = new String[]{
            "799",
            "2499",
            "599",
            "999",
            "699"
        };

        images = new String[]{
            "accessories1.webp",
            "accessories2.webp",
            "accessories3.jpg",
            "accessories4.webp",
            "accessories5.jpg"
        };

        badges = new String[]{
            "Sale",
            "Trending",
            "New",
            "Bestseller",
            "New"
        };

    // ================= ALL PRODUCTS =================
    } else {

        names = new String[]{
            "Black T-Shirt",
            "Blue Jeans",
            "White Shirt",
            "Red Dress",
            "Sneakers",
            "Hand Bag",
            "Hoodie",
            "Watch",
            "Sunglasses",
            "Backpack",
            "Coat"
        };

        prices = new String[]{
            "899",
            "1499",
            "999",
            "1299",
            "1999",
            "799",
            "1199",
            "2499",
            "599",
            "999",
            "1799"
        };

        images = new String[]{
            "men1.jpg",
            "men2.jpg",
            "men3.webp",
            "women1.jpg",
            "men5.webp",
            "accessories1.webp",
            "men4.jpg",
            "accessories2.webp",
            "accessories3.jpg",
            "accessories4.webp",
            "men6.jpg"
        };

        badges = new String[]{
            "New",
            "Bestseller",
            "New",
            "Trending",
            "Bestseller",
            "Sale",
            "New",
            "Trending",
            "Sale",
            "Bestseller",
            "New"
        };
    }

    // ==========================================================
    // DATABASE PRODUCTS
    // ==========================================================

    ProductService productService = new ProductService();

    List<Product> dbProducts = productService.getAllProducts();

    List<Product> approvedProducts = new ArrayList<Product>();

    if (dbProducts != null) {

        for (Product p : dbProducts) {

            if (p == null) {
                continue;
            }

            if (!"APPROVED".equalsIgnoreCase(p.getStatus())) {
                continue;
            }

            String productCategory = p.getCategory();

            if (category.equalsIgnoreCase("All")
                    || (productCategory != null
                    && productCategory.equalsIgnoreCase(category))) {

                approvedProducts.add(p);
            }
        }
    }

    // ==========================================================
    // PREVENT DUPLICATE PRODUCT NAMES
    // ==========================================================

    Set<String> existingProductNames =
            new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);

    for (String name : names) {

        if (name != null) {
            existingProductNames.add(name.trim());
        }
    }

    List<Product> displayDbProducts =
            new ArrayList<Product>();

    for (Product product : approvedProducts) {

        if (product == null || product.getName() == null) {
            continue;
        }

        String dbProductName =
                product.getName().trim();

        if (!existingProductNames.contains(dbProductName)) {

            displayDbProducts.add(product);

            existingProductNames.add(dbProductName);
        }
    }

    int totalProductCount =
            names.length + displayDbProducts.size();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Shop Products | Shopzilla</title>

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

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/luma.css">


<style>

/* =====================================================
   MAIN PAGE
===================================================== */

.products-page {
    background: #fff;
    min-height: 100vh;
}


/* =====================================================
   HEADER
===================================================== */

.shop-header {
    padding: 45px 5% 25px;
    border-bottom: 1px solid #eee;
}

.shop-header h1 {
    margin: 0;
    font-size: 32px;
    font-weight: 800;
}

.shop-header p {
    margin-top: 8px;
    color: #777;
    font-size: 13px;
}


/* =====================================================
   SHOP LAYOUT
===================================================== */

.shop-layout {
    display: grid;
    grid-template-columns: 200px minmax(0, 1fr);
    gap: 35px;
    padding: 30px 5%;
    align-items: start;
}


/* =====================================================
   FILTERS - CLEAN LEFT ALIGNMENT
===================================================== */

.filters {
    width: 100%;
    border-right: 1px solid #eee;
    padding: 0 25px 0 0;
    margin: 0;
    box-sizing: border-box;
}

.filter-title {
    margin: 0 0 28px 0;
    padding: 0;
    font-size: 14px;
    font-weight: 800;
    text-transform: uppercase;
    color: #111;
    line-height: 1;
}

.filter-group {
    width: 100%;
    margin: 0 0 30px 0;
    padding: 0;
}

.filter-group h3 {
    margin: 0 0 14px 0;
    padding: 0;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    color: #111;
    line-height: 1;
}


/* =====================================================
   CATEGORY
===================================================== */

.category-options {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 9px;
    margin: 0;
    padding: 0;
}

.category-options a {
    display: block;
    width: auto;
    margin: 0;
    padding: 0 !important;
    color: #555;
    text-decoration: none;
    font-size: 13px;
    line-height: 20px;
    text-align: left;
    cursor: pointer;
}

.category-options a:hover {
    color: #111;
}


/* =====================================================
   CHECKBOX FILTERS
===================================================== */

.checkbox-options {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
    margin: 0;
    padding: 0;
}

.filter-checkbox {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
    min-height: 20px;
    margin: 0;
    padding: 0;
    color: #555;
    font-size: 13px;
    line-height: 20px;
    text-align: left;
    cursor: pointer;
    box-sizing: border-box;
}

.filter-checkbox input {
    width: 14px;
    height: 14px;
    min-width: 14px;
    margin: 0 9px 0 0;
    padding: 0;
    flex: 0 0 14px;
    cursor: pointer;
    accent-color: #111;
}

.filter-checkbox span {
    display: block;
    margin: 0;
    padding: 0;
    white-space: nowrap;
    line-height: 20px;
}

.filter-checkbox:hover {
    color: #111;
}


/* =====================================================
   TOOLBAR
===================================================== */

.shop-toolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    gap: 15px;
}

.result-count {
    color: #666;
    font-size: 13px;
}

.sort-select {
    width: 158px;
    height: 40px;
    border: 1px solid #ddd;
    padding: 0 12px;
    background: #fff;
    font-size: 12px;
    outline: none;
    cursor: pointer;
}

.sort-select:focus {
    border-color: #111;
}


/* =====================================================
   PRODUCT GRID
===================================================== */

.product-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.product-card {
    position: relative;
    background: #fff;
    overflow: hidden;
}

.product-card.hidden-product {
    display: none !important;
}


/* =====================================================
   PRODUCT IMAGE
===================================================== */

.product-image {
    position: relative;
    width: 100%;
    aspect-ratio: 3 / 4;
    background: #f5f5f5;
    overflow: hidden;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
    transition: transform .4s ease;
}

.product-card:hover .product-image img {
    transform: scale(1.04);
}


/* =====================================================
   BADGE
===================================================== */

.product-badge {
    position: absolute;
    left: 10px;
    top: 10px;
    background: #111;
    color: #fff;
    padding: 6px 9px;
    font-size: 9px;
    font-weight: 700;
    text-transform: uppercase;
    z-index: 2;
}


/* =====================================================
   WISHLIST
===================================================== */

.wishlist-btn {
    position: absolute;
    right: 10px;
    top: 10px;
    width: 34px;
    height: 34px;
    border: none;
    border-radius: 50%;
    background: rgba(255,255,255,.95);
    cursor: pointer;
    z-index: 5;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #111;
    transition: .2s ease;
}

.wishlist-btn:hover {
    transform: scale(1.08);
}

.wishlist-btn i {
    font-size: 16px;
    transition: .2s ease;
}

.wishlist-btn.active {
    color: #d4145a;
}

.wishlist-btn.active i {
    color: #d4145a;
}


/* =====================================================
   PRODUCT INFO
===================================================== */

.product-info {
    padding: 13px 2px 5px;
}

.product-brand {
    font-size: 11px;
    font-weight: 800;
    text-transform: uppercase;
    color: #222;
}

.product-name {
    margin-top: 5px;
    font-size: 13px;
    color: #555;
}

.product-price {
    margin-top: 8px;
    font-size: 14px;
    font-weight: 800;
}


/* =====================================================
   ADD TO CART
===================================================== */

.add-cart-btn {
    width: 100%;
    margin-top: 12px;
    height: 40px;
    border: 1px solid #111;
    background: #111;
    color: #fff;
    cursor: pointer;
    font-size: 11px;
    font-weight: 800;
    text-transform: uppercase;
    transition: .25s;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    box-sizing: border-box;
}

.add-cart-btn:hover {
    background: #d4145a;
    border-color: #d4145a;
    color: #fff;
}


/* =====================================================
   NO RESULTS
===================================================== */

.no-results {
    display: none;
    grid-column: 1 / -1;
    text-align: center;
    padding: 70px 20px;
    color: #777;
}

.no-results i {
    font-size: 40px;
    margin-bottom: 15px;
    color: #ccc;
}

.no-results h3 {
    margin: 0 0 8px;
    color: #111;
}


/* =====================================================
   MOBILE
===================================================== */

.mobile-filter {
    display: none;
}


@media (max-width: 900px) {

    .shop-layout {
        grid-template-columns: 180px 1fr;
        gap: 25px;
    }

    .product-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}


@media (max-width: 650px) {

    .shop-header {
        padding: 30px 20px 20px;
    }

    .shop-header h1 {
        font-size: 25px;
    }

    .shop-layout {
        display: block;
        padding: 20px;
    }

    .filters {
        display: none;
    }

    .mobile-filter {
        display: block;
        width: 100%;
        margin-bottom: 20px;
        padding: 12px;
        background: #111;
        color: #fff;
        border: none;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
    }

    .product-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
    }

    .shop-toolbar {
        margin-bottom: 18px;
    }

    .sort-select {
        width: 145px;
        height: 38px;
        padding: 0 8px;
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

            <a href="${pageContext.request.contextPath}/buyer/wishlist.jsp">
                <i class="fa-regular fa-heart"></i>
            </a>

            <a href="${pageContext.request.contextPath}/buyer/cart.jsp">
                <i class="fa-solid fa-bag-shopping"></i>
            </a>

        </div>

    </div>

</header>


<!-- ================= MAIN ================= -->

<main class="products-page">


    <section class="shop-header">

        <h1>
            <%= category.equalsIgnoreCase("All")
                    ? "Shop All Products"
                    : category %>
        </h1>

        <p>
            Discover the latest fashion,
            footwear, beauty and lifestyle products.
        </p>

    </section>


    <div class="shop-layout">


        <!-- ================= FILTERS ================= -->

        <aside class="filters">

            <div class="filter-title">
                Filters
            </div>


            <!-- CATEGORY -->

            <div class="filter-group">

                <h3>Category</h3>

                <div class="category-options">

                    <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Men">
                        Men
                    </a>

                    <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Women">
                        Women
                    </a>

                    <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Kids">
                        Kids
                    </a>

                    <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Beauty">
                        Beauty
                    </a>

                    <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Footwear">
                        Footwear
                    </a>

                    <a href="${pageContext.request.contextPath}/buyer/products.jsp?category=Accessories">
                        Accessories
                    </a>

                </div>

            </div>


            <!-- PRICE -->

            <div class="filter-group">

                <h3>Price</h3>

                <div class="checkbox-options">

                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="price-filter"
                               value="under999">

                        <span>Under ₹999</span>

                    </label>


                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="price-filter"
                               value="999-1999">

                        <span>₹999 - ₹1,999</span>

                    </label>


                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="price-filter"
                               value="2000-4999">

                        <span>₹2,000 - ₹4,999</span>

                    </label>


                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="price-filter"
                               value="5000plus">

                        <span>₹5,000+</span>

                    </label>

                </div>

            </div>


            <!-- SIZE -->

            <div class="filter-group">

                <h3>Size</h3>

                <div class="checkbox-options">

                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="size-filter"
                               value="S">

                        <span>S</span>

                    </label>


                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="size-filter"
                               value="M">

                        <span>M</span>

                    </label>


                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="size-filter"
                               value="L">

                        <span>L</span>

                    </label>


                    <label class="filter-checkbox">

                        <input type="checkbox"
                               class="size-filter"
                               value="XL">

                        <span>XL</span>

                    </label>

                </div>

            </div>

        </aside>


        <!-- ================= PRODUCTS ================= -->

        <section class="products-section">


            <button class="mobile-filter"
                    type="button"
                    onclick="alert('Filter options are available on desktop view.')">

                <i class="fa-solid fa-filter"></i>

                FILTER & SORT

            </button>


            <div class="shop-toolbar">

                <span class="result-count"
                      id="resultCount">

                    Showing <%= totalProductCount %> products

                </span>


                <select class="sort-select"
                        id="sortSelect">

                    <option value="default">
                        Sort By
                    </option>

                    <option value="newest">
                        Newest
                    </option>

                    <option value="low">
                        Price: Low to High
                    </option>

                    <option value="high">
                        Price: High to Low
                    </option>

                    <option value="discount">
                        Discount
                    </option>

                </select>

            </div>


            <div class="product-grid"
                 id="productGrid">


<%
    // ==========================================================
    // EXISTING HARDCODED PRODUCTS
    // ==========================================================

    for (int i = 0; i < names.length; i++) {

        String sizeData;

        if (names[i].equals("Black T-Shirt")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Blue Jeans")) {
            sizeData = "M,L,XL";
        }

        else if (names[i].equals("White Shirt")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Hoodie")) {
            sizeData = "M,L,XL";
        }

        else if (names[i].equals("Sneakers")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Coat")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Red Dress")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Women Top")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Women Jeans")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Women Heels")) {
            sizeData = "S,M";
        }

        else if (names[i].equals("Hand Bag")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Kids T-Shirt")) {
            sizeData = "S,M";
        }

        else if (names[i].equals("Kids Jeans")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Kids Dress")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Kids Sneakers")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Kids Backpack")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Running Shoes")) {
            sizeData = "M,L,XL";
        }

        else if (names[i].equals("Casual Sneakers")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Sports Shoes")) {
            sizeData = "M,L,XL";
        }

        else if (names[i].equals("Sandals")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Face Cream")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Lipstick")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Makeup Kit")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Perfume")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Makeup Brushes Set")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Watch")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Sunglasses")) {
            sizeData = "S,M,L";
        }

        else if (names[i].equals("Backpack")) {
            sizeData = "S,M,L,XL";
        }

        else if (names[i].equals("Wallet")) {
            sizeData = "S,M,L";
        }

        else {
            sizeData = "S,M,L,XL";
        }


        int discount = 0;

        if (badges[i].equalsIgnoreCase("Sale")) {
            discount = 30;
        }

        else if (badges[i].equalsIgnoreCase("Bestseller")) {
            discount = 20;
        }

        else if (badges[i].equalsIgnoreCase("Trending")) {
            discount = 15;
        }

        else if (badges[i].equalsIgnoreCase("New")) {
            discount = 10;
        }

%>


                <article class="product-card"
                         data-price="<%= prices[i] %>"
                         data-size="<%= sizeData %>"
                         data-discount="<%= discount %>"
                         data-original="<%= i %>">


                    <div class="product-image">


                        <span class="product-badge">
                            <%= badges[i] %>
                        </span>


                        <!-- WISHLIST -->

                        <button class="wishlist-btn"
                                type="button"
                                onclick="toggleWishlist(this)"
                                data-name="<%= names[i] %>"
                                data-price="<%= prices[i] %>"
                                data-image="<%= images[i] %>">

                            <i class="fa-regular fa-heart"></i>

                        </button>


                        <!-- PRODUCT IMAGE -->

                        <img src="<%= request.getContextPath() %>/images/<%= images[i] %>"
                             alt="<%= names[i] %>"
                             loading="lazy">

                    </div>


                    <div class="product-info">

                        <div class="product-brand">
                            Shopzilla
                        </div>

                        <div class="product-name">
                            <%= names[i] %>
                        </div>

                        <div class="product-price">
                            ₹<%= prices[i] %>
                        </div>


                        <!-- ADD TO CART -->

                        <a href="${pageContext.request.contextPath}/buyer/cart.jsp?name=<%= java.net.URLEncoder.encode(names[i], "UTF-8") %>&price=<%= prices[i] %>&image=<%= java.net.URLEncoder.encode(images[i], "UTF-8") %>"
                           class="add-cart-btn">

                            ADD TO CART

                        </a>

                    </div>

                </article>


<%
    }
%>


<%
    // ==========================================================
    // DATABASE PRODUCTS
    // ==========================================================

    int dbIndex = 1000;

    for (Product product : displayDbProducts) {

        String dbName = product.getName();

        double dbProductPrice = product.getPrice();

        String dbPrice =
                String.valueOf((int) dbProductPrice);


        /*
         * DO NOT assign a default image.
         *
         * If image_url is empty,
         * product will not show an unrelated image.
         */

        String dbImage = product.getImageUrl();

        if (dbImage == null) {
            dbImage = "";
        }

        dbImage = dbImage.trim();


        String dbSizeData = "S,M,L,XL";

        int dbDiscount = 0;

        double dbMrp = product.getMrp();

        if (dbMrp > dbProductPrice && dbMrp > 0) {

            dbDiscount = (int) Math.round(
                ((dbMrp - dbProductPrice) / dbMrp) * 100
            );
        }


        /*
         * IMAGE URL
         *
         * URL -> use directly
         * filename -> /images/filename
         *
         * Empty -> no image
         */

        String dbImageUrl = "";

        if (!dbImage.isEmpty()) {

            if (dbImage.startsWith("http://")
                    || dbImage.startsWith("https://")
                    || dbImage.startsWith("/")) {

                dbImageUrl = dbImage;

            } else {

                dbImageUrl =
                        request.getContextPath()
                        + "/images/"
                        + dbImage;
            }
        }

%>


                <article class="product-card"
                         data-price="<%= dbProductPrice %>"
                         data-size="<%= dbSizeData %>"
                         data-discount="<%= dbDiscount %>"
                         data-original="<%= dbIndex++ %>">


                    <div class="product-image">


                        <span class="product-badge">
                            New
                        </span>


                        <!-- WISHLIST -->

                        <button class="wishlist-btn"
                                type="button"
                                onclick="toggleWishlist(this)"
                                data-name="<%= dbName %>"
                                data-price="<%= dbPrice %>"
                                data-image="<%= dbImage %>">

                            <i class="fa-regular fa-heart"></i>

                        </button>


                        <!-- DATABASE PRODUCT IMAGE -->

<%
                        /*
                         * ONLY display an image if the database
                         * actually contains an image.
                         *
                         * NO men1.jpg fallback.
                         */

                        if (!dbImageUrl.isEmpty()) {
%>

                            <img src="<%= dbImageUrl %>"
                                 alt="<%= dbName %>"
                                 loading="lazy"
                                 onerror="this.style.display='none';">

<%
                        }
%>


                    </div>


                    <div class="product-info">

                        <div class="product-brand">
                            Shopzilla
                        </div>

                        <div class="product-name">
                            <%= dbName %>
                        </div>

                        <div class="product-price">
                            ₹<%= dbPrice %>
                        </div>


                        <!-- ADD TO CART -->

                        <a href="<%= request.getContextPath() %>/buyer/cart.jsp?name=<%= java.net.URLEncoder.encode(dbName, "UTF-8") %>&price=<%= dbPrice %>&image=<%= java.net.URLEncoder.encode(dbImage, "UTF-8") %>"
                           class="add-cart-btn">

                            ADD TO CART

                        </a>

                    </div>

                </article>


<%
    }
%>


                <!-- NO RESULTS -->

                <div class="no-results"
                     id="noResults">

                    <i class="fa-solid fa-box-open"></i>

                    <h3>
                        No products found
                    </h3>

                    <p>
                        Try changing your filters.
                    </p>

                </div>


            </div>

        </section>

    </div>

</main>


<!-- ================= LUMA ================= -->

<jsp:include page="/luma.jsp" />


<!-- =====================================================
     FILTER + SORT JAVASCRIPT
===================================================== -->

<script>

document.addEventListener(
    "DOMContentLoaded",
    function() {

        const productGrid =
            document.getElementById("productGrid");

        const resultCount =
            document.getElementById("resultCount");

        const noResults =
            document.getElementById("noResults");

        const sortSelect =
            document.getElementById("sortSelect");

        const priceFilters =
            document.querySelectorAll(".price-filter");

        const sizeFilters =
            document.querySelectorAll(".size-filter");

        const cards =
            Array.from(
                document.querySelectorAll(".product-card")
            );


        /* =========================================
           FILTER PRODUCTS
        ========================================= */

        function filterProducts() {

            const selectedPrices =
                Array.from(priceFilters)
                .filter(function(checkbox) {

                    return checkbox.checked;

                })
                .map(function(checkbox) {

                    return checkbox.value;

                });


            const selectedSizes =
                Array.from(sizeFilters)
                .filter(function(checkbox) {

                    return checkbox.checked;

                })
                .map(function(checkbox) {

                    return checkbox.value;

                });


            let visibleCards = [];


            cards.forEach(function(card) {

                const price =
                    Number(
                        card.getAttribute("data-price")
                    );


                const sizes =
                    (card.getAttribute("data-size") || "")
                    .split(",");


                let priceMatch = true;


                if (selectedPrices.length > 0) {

                    priceMatch =
                        selectedPrices.some(
                            function(range) {

                                if (range === "under999") {

                                    return price < 999;
                                }


                                if (range === "999-1999") {

                                    return price >= 999 &&
                                           price <= 1999;
                                }


                                if (range === "2000-4999") {

                                    return price >= 2000 &&
                                           price <= 4999;
                                }


                                if (range === "5000plus") {

                                    return price >= 5000;
                                }


                                return false;
                            }
                        );
                }


                let sizeMatch = true;


                if (selectedSizes.length > 0) {

                    sizeMatch =
                        selectedSizes.some(
                            function(size) {

                                return sizes.includes(size);

                            }
                        );
                }


                if (priceMatch && sizeMatch) {

                    card.classList.remove(
                        "hidden-product"
                    );

                    visibleCards.push(card);

                } else {

                    card.classList.add(
                        "hidden-product"
                    );
                }

            });


            resultCount.textContent =
                "Showing " +
                visibleCards.length +
                " products";


            if (visibleCards.length === 0) {

                noResults.style.display =
                    "block";

            } else {

                noResults.style.display =
                    "none";
            }

        }


        /* =========================================
           SORT PRODUCTS
        ========================================= */

        function sortProducts() {

            const value =
                sortSelect.value;


            const sortedCards =
                cards.slice();


            if (value === "low") {

                sortedCards.sort(
                    function(a, b) {

                        return Number(
                            a.getAttribute("data-price")
                        )
                        -
                        Number(
                            b.getAttribute("data-price")
                        );

                    }
                );

            }

            else if (value === "high") {

                sortedCards.sort(
                    function(a, b) {

                        return Number(
                            b.getAttribute("data-price")
                        )
                        -
                        Number(
                            a.getAttribute("data-price")
                        );

                    }
                );

            }

            else if (value === "discount") {

                sortedCards.sort(
                    function(a, b) {

                        return Number(
                            b.getAttribute("data-discount")
                        )
                        -
                        Number(
                            a.getAttribute("data-discount")
                        );

                    }
                );

            }

            else {

                sortedCards.sort(
                    function(a, b) {

                        return Number(
                            a.getAttribute("data-original")
                        )
                        -
                        Number(
                            b.getAttribute("data-original")
                        );

                    }
                );
            }


            sortedCards.forEach(
                function(card) {

                    productGrid.appendChild(card);

                }
            );


            productGrid.appendChild(
                noResults
            );


            filterProducts();
        }


        /* =========================================
           PRICE FILTER EVENTS
        ========================================= */

        priceFilters.forEach(
            function(checkbox) {

                checkbox.addEventListener(
                    "change",
                    function() {

                        filterProducts();

                    }
                );

            }
        );


        /* =========================================
           SIZE FILTER EVENTS
        ========================================= */

        sizeFilters.forEach(
            function(checkbox) {

                checkbox.addEventListener(
                    "change",
                    function() {

                        filterProducts();

                    }
                );

            }
        );


        /* =========================================
           SORT EVENT
        ========================================= */

        sortSelect.addEventListener(
            "change",
            function() {

                sortProducts();

            }
        );


        /* =========================================
           INITIAL
        ========================================= */

        filterProducts();

    }
);


/* =====================================================
   WISHLIST
===================================================== */

function getWishlist() {

    try {

        const data =
            localStorage.getItem(
                "shopzillaWishlist"
            );


        if (!data) {

            return [];
        }


        const list =
            JSON.parse(data);


        if (!Array.isArray(list)) {

            return [];
        }


        return list;

    } catch (error) {

        return [];
    }
}


/* =====================================================
   SAVE WISHLIST
===================================================== */

function saveWishlist(list) {

    localStorage.setItem(
        "shopzillaWishlist",
        JSON.stringify(list)
    );
}


/* =====================================================
   TOGGLE WISHLIST
===================================================== */

function toggleWishlist(button) {

    const name =
        button.getAttribute(
            "data-name"
        );


    const price =
        button.getAttribute(
            "data-price"
        );


    const image =
        button.getAttribute(
            "data-image"
        ) || "";


    const icon =
        button.querySelector("i");


    if (!name || !price) {

        alert(
            "Product information missing."
        );

        return;
    }


    let wishlist =
        getWishlist();


    const index =
        wishlist.findIndex(
            function(item) {

                return item &&
                       item.name === name;

            }
        );


    /* ================= ADD ================= */

    if (index === -1) {

        wishlist.push({

            name: String(name),

            price: String(price),

            image: String(image)

        });


        icon.classList.remove(
            "fa-regular"
        );

        icon.classList.add(
            "fa-solid"
        );

        button.classList.add(
            "active"
        );

    }


    /* ================= REMOVE ================= */

    else {

        wishlist.splice(
            index,
            1
        );


        icon.classList.remove(
            "fa-solid"
        );

        icon.classList.add(
            "fa-regular"
        );

        button.classList.remove(
            "active"
        );
    }


    saveWishlist(
        wishlist
    );
}


/* =====================================================
   LOAD HEART STATUS
===================================================== */

document.addEventListener(
    "DOMContentLoaded",
    function() {

        const wishlist =
            getWishlist();


        document
            .querySelectorAll(
                ".wishlist-btn"
            )
            .forEach(
                function(button) {

                    const name =
                        button.getAttribute(
                            "data-name"
                        );


                    const exists =
                        wishlist.some(
                            function(item) {

                                return item &&
                                       item.name === name;

                            }
                        );


                    if (exists) {

                        const icon =
                            button.querySelector(
                                "i"
                            );


                        icon.classList.remove(
                            "fa-regular"
                        );

                        icon.classList.add(
                            "fa-solid"
                        );

                        button.classList.add(
                            "active"
                        );
                    }

                }
            );

    }
);

</script>


<!-- LUMA JS -->

<script src="${pageContext.request.contextPath}/luma.js"></script>


</body>

</html>