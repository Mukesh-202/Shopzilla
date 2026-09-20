<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Wishlist - Shopzilla</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            color: #111;
        }

        .navbar {
            height: 70px;
            background: white;
            display: flex;
            align-items: center;
            padding: 0 48px;
            border-bottom: 1px solid #eee;
        }

        .logo {
            color: #111;
            text-decoration: none;
            font-size: 26px;
            font-weight: 800;
        }

        .nav-right {
            margin-left: auto;
            display: flex;
            gap: 28px;
        }

        .nav-right a {
            color: #111;
            text-decoration: none;
            font-size: 20px;
        }

        .nav-right .active-heart {
            color: #d4145a;
        }

        .page {
            padding: 45px;
        }

        .title {
            text-align: center;
            margin-bottom: 35px;
        }

        .title h1 {
            margin: 0;
            font-size: 34px;
        }

        .title p {
            color: #777;
            margin-top: 8px;
        }

        #wishlist-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
        }

        .wishlist-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 18px rgba(0,0,0,.08);
        }

        .wishlist-image {
            width: 100%;
            height: 280px;
            background: #eee;
        }

        .wishlist-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .wishlist-info {
            padding: 18px;
        }

        .wishlist-name {
            font-size: 17px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .wishlist-price {
            font-size: 18px;
            font-weight: 800;
            margin-bottom: 16px;
        }

        .wishlist-buttons {
            display: flex;
            gap: 8px;
        }

        .wishlist-cart,
        .wishlist-remove {
            flex: 1;
            height: 42px;
            border-radius: 7px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
        }

        .wishlist-cart {
            background: #111;
            color: white;
            border: 1px solid #111;
        }

        .wishlist-remove {
            background: white;
            color: #d4145a;
            border: 1px solid #d4145a;
        }

        #empty-wishlist {
            display: none;
            text-align: center;
            padding: 100px 20px;
        }

        #empty-wishlist i {
            font-size: 60px;
            color: #ccc;
        }

        #empty-wishlist h2 {
            margin: 20px 0 8px;
        }

        #empty-wishlist p {
            color: #777;
        }

        .shop-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 13px 25px;
            background: #111;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        @media(max-width: 1000px) {

            #wishlist-grid {
                grid-template-columns: repeat(3, 1fr);
            }

        }

        @media(max-width: 700px) {

            .page {
                padding: 25px 15px;
            }

            #wishlist-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media(max-width: 450px) {

            #wishlist-grid {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>


<body>


<div class="navbar">

    <a class="logo"
       href="${pageContext.request.contextPath}/">
        SHOPZILLA
    </a>

    <div class="nav-right">

        <a href="${pageContext.request.contextPath}/buyer/products.jsp">
            <i class="fa-solid fa-bag-shopping"></i>
        </a>

        <a class="active-heart"
           href="${pageContext.request.contextPath}/buyer/wishlist.jsp">
            <i class="fa-solid fa-heart"></i>
        </a>

    </div>

</div>


<div class="page">


    <div class="title">

        <h1>Wishlist</h1>

        <p>Your favorite products</p>

    </div>


    <div id="wishlist-grid"></div>


    <div id="empty-wishlist">

        <i class="fa-regular fa-heart"></i>

        <h2>Your wishlist is empty</h2>

        <p>Add products to your wishlist and they will appear here.</p>

        <a class="shop-btn"
           href="${pageContext.request.contextPath}/buyer/products.jsp">
            SHOP PRODUCTS
        </a>

    </div>


</div>


<script>

/* =========================================
   GET DATA
========================================= */

function getWishlist() {

    try {

        const data =
            localStorage.getItem("shopzillaWishlist");

        if (!data) {
            return [];
        }

        const list = JSON.parse(data);

        if (!Array.isArray(list)) {
            return [];
        }

        return list;

    } catch (e) {

        return [];

    }

}


/* =========================================
   SAVE DATA
========================================= */

function saveWishlist(list) {

    localStorage.setItem(
        "shopzillaWishlist",
        JSON.stringify(list)
    );

}


/* =========================================
   DISPLAY
========================================= */

function displayWishlist() {

    const grid =
        document.getElementById("wishlist-grid");

    const empty =
        document.getElementById("empty-wishlist");


    let wishlist =
        getWishlist();


    /*
       Remove broken old records.
       A valid product MUST have:
       name + price + image
    */

    wishlist = wishlist.filter(function(item) {

        return item &&
               item.name &&
               item.price &&
               item.image;

    });


    saveWishlist(wishlist);


    grid.innerHTML = "";


    if (wishlist.length === 0) {

        grid.style.display = "none";

        empty.style.display = "block";

        return;

    }


    grid.style.display = "grid";

    empty.style.display = "none";


    const contextPath =
        "<%= request.getContextPath() %>";


    wishlist.forEach(function(item, index) {


        const card =
            document.createElement("div");

        card.className =
            "wishlist-card";


        const image =
            contextPath +
            "/images/" +
            item.image;


        const cartUrl =
            contextPath +
            "/buyer/cart.jsp" +
            "?name=" +
            encodeURIComponent(item.name) +
            "&price=" +
            encodeURIComponent(item.price) +
            "&image=" +
            encodeURIComponent(item.image);


        card.innerHTML =

            '<div class="wishlist-image">' +

                '<img src="' + image + '"' +
                     ' alt="' + item.name + '">' +

            '</div>' +

            '<div class="wishlist-info">' +

                '<div class="wishlist-name">' +
                    item.name +
                '</div>' +

                '<div class="wishlist-price">' +
                    '₹' + item.price +
                '</div>' +

                '<div class="wishlist-buttons">' +

                    '<a class="wishlist-cart"' +
                       ' href="' + cartUrl + '">' +
                        'ADD TO CART' +
                    '</a>' +

                    '<button class="wishlist-remove"' +
                            ' type="button"' +
                            ' onclick="removeWishlist(' + index + ')">' +
                        'REMOVE' +
                    '</button>' +

                '</div>' +

            '</div>';


        grid.appendChild(card);

    });

}


/* =========================================
   REMOVE
========================================= */

function removeWishlist(index) {

    let wishlist =
        getWishlist();

    wishlist.splice(index, 1);

    saveWishlist(wishlist);

    displayWishlist();

}


/* =========================================
   START
========================================= */

displayWishlist();

</script>


</body>

</html>