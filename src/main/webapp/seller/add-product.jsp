<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Add Product | Shopzilla</title>

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
            background: #f6f6f6;
            color: #111;
            font-family: Arial, Helvetica, sans-serif;
        }

        .add-page {
            max-width: 1150px;
            margin: auto;
            padding: 35px 5% 70px;
        }

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading h1 {
            margin: 0;
            font-size: 29px;
            font-weight: 800;
        }

        .page-heading p {
            margin: 7px 0 0;
            color: #777;
            font-size: 11px;
        }

        .breadcrumb {
            margin-bottom: 18px;
            font-size: 9px;
            color: #888;
        }

        .breadcrumb a {
            color: #111;
            text-decoration: none;
            font-weight: 700;
        }

        .form-layout {
            display: grid;
            grid-template-columns: 1fr 330px;
            gap: 22px;
            align-items: start;
        }

        .form-card {
            background: #fff;
            border: 1px solid #e4e4e4;
            padding: 25px;
            margin-bottom: 20px;
        }

        .form-card h2 {
            margin: 0 0 22px;
            font-size: 14px;
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

        .form-group:last-child {
            margin-bottom: 0;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-size: 9px;
            font-weight: 800;
            text-transform: uppercase;
        }

        input,
        select,
        textarea {
            width: 100%;
            border: 1px solid #ccc;
            outline: none;
            background: #fff;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 11px;
        }

        input,
        select {
            height: 43px;
            padding: 0 11px;
        }

        textarea {
            height: 115px;
            padding: 11px;
            resize: vertical;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #111;
        }

        .input-prefix {
            display: flex;
        }

        .input-prefix span {
            height: 43px;
            display: flex;
            align-items: center;
            padding: 0 12px;
            background: #f3f3f3;
            border: 1px solid #ccc;
            border-right: none;
            font-size: 11px;
        }

        .input-prefix input {
            flex: 1;
        }

        .image-upload {
            border: 1px dashed #bbb;
            min-height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 25px;
            cursor: pointer;
            background: #fafafa;
        }

        .image-upload i {
            font-size: 30px;
            margin-bottom: 12px;
        }

        .image-upload strong {
            font-size: 11px;
        }

        .image-upload span {
            margin-top: 6px;
            color: #888;
            font-size: 8px;
        }

        .image-upload input {
            display: none;
        }

        .image-preview {
            width: 100%;
            max-height: 220px;
            object-fit: contain;
            display: none;
            margin-bottom: 10px;
        }

        .checkbox-row {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .checkbox-item {
            border: 1px solid #ddd;
            padding: 9px 12px;
            cursor: pointer;
            font-size: 9px;
        }

        .checkbox-item input {
            width: auto;
            height: auto;
            margin-right: 5px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 5px;
        }

        .btn {
            height: 45px;
            padding: 0 25px;
            border: none;
            cursor: pointer;
            font-size: 9px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .btn-primary {
            background: #111;
            color: #fff;
        }

        .btn-primary:hover {
            background: #d4145a;
        }

        .btn-secondary {
            background: #fff;
            color: #111;
            border: 1px solid #ccc;
        }

        .side-card {
            background: #fff;
            border: 1px solid #e4e4e4;
            padding: 22px;
            margin-bottom: 20px;
        }

        .side-card h3 {
            margin: 0 0 18px;
            font-size: 13px;
            text-transform: uppercase;
        }

        .tip {
            display: flex;
            gap: 11px;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }

        .tip:last-child {
            border-bottom: none;
        }

        .tip i {
            width: 28px;
            height: 28px;
            background: #f2f2f2;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
        }

        .tip strong {
            display: block;
            font-size: 9px;
            margin-bottom: 4px;
        }

        .tip span {
            color: #777;
            font-size: 8px;
            line-height: 1.5;
        }

        .required {
            color: #d4145a;
        }

        .success-box {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.65);
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .success-content {
            background: #fff;
            width: 400px;
            max-width: 90%;
            padding: 40px 25px;
            text-align: center;
        }

        .success-content i {
            font-size: 45px;
            color: #16823b;
            margin-bottom: 15px;
        }

        .success-content h2 {
            margin: 0 0 8px;
            font-size: 20px;
        }

        .success-content p {
            color: #777;
            font-size: 10px;
            line-height: 1.6;
        }

        .success-content button {
            margin-top: 10px;
            padding: 12px 22px;
            background: #111;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 9px;
            font-weight: 700;
        }

        @media (max-width: 850px) {
            .form-layout {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 600px) {
            .add-page {
                padding: 25px 15px 50px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .form-card {
                padding: 18px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- NAVBAR -->

<header class="main-header">

    <div class="header-container">

        <a href="${pageContext.request.contextPath}/" class="logo">
            SHOP<span>ZILLA</span>
        </a>

        <nav class="main-nav">

            <a href="${pageContext.request.contextPath}/">HOME</a>

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

            <a href="${pageContext.request.contextPath}/buyer/cart.jsp">
                <i class="fa-solid fa-bag-shopping"></i>
            </a>

        </div>

    </div>

</header>


<!-- PAGE -->

<main class="add-page">


    <div class="breadcrumb">

        <a href="${pageContext.request.contextPath}/seller/dashboard.jsp">
            Seller Dashboard
        </a>

        &nbsp; / &nbsp;

        Add Product

    </div>


    <div class="page-heading">

        <h1>
            Add New Product
        </h1>

        <p>
            Add a new product to your Shopzilla store.
        </p>

    </div>


    <form id="productForm"
          onsubmit="submitProduct(event)">


        <div class="form-layout">


            <!-- LEFT -->

            <div>


                <!-- BASIC INFORMATION -->

                <div class="form-card">

                    <h2>
                        Product Information
                    </h2>


                    <div class="form-group">

                        <label>
                            Product Name <span class="required">*</span>
                        </label>

                        <input
                            type="text"
                            id="productName"
                            placeholder="Enter product name"
                            required>

                    </div>


                    <div class="form-row">

                        <div class="form-group">

                            <label>
                                Category <span class="required">*</span>
                            </label>

                            <select id="category" required>

                                <option value="">
                                    Select Category
                                </option>

                                <option>Men</option>
                                <option>Women</option>
                                <option>Kids</option>
                                <option>Beauty</option>
                                <option>Footwear</option>
                                <option>Accessories</option>

                            </select>

                        </div>


                        <div class="form-group">

                            <label>
                                Sub Category
                            </label>

                            <select id="subcategory">

                                <option value="">
                                    Select Sub Category
                                </option>

                                <option>T-Shirts</option>
                                <option>Shirts</option>
                                <option>Jeans</option>
                                <option>Dresses</option>
                                <option>Jackets</option>
                                <option>Sneakers</option>
                                <option>Sandals</option>
                                <option>Bags</option>
                                <option>Watches</option>

                            </select>

                        </div>

                    </div>


                    <div class="form-group">

                        <label>
                            Description <span class="required">*</span>
                        </label>

                        <textarea
                            id="description"
                            placeholder="Describe your product, material, fit, features, etc."
                            required></textarea>

                    </div>

                </div>


                <!-- PRICE / STOCK -->

                <div class="form-card">

                    <h2>
                        Price & Inventory
                    </h2>


                    <div class="form-row">

                        <div class="form-group">

                            <label>
                                Selling Price <span class="required">*</span>
                            </label>

                            <div class="input-prefix">

                                <span>₹</span>

                                <input
                                    type="number"
                                    id="price"
                                    min="1"
                                    placeholder="799"
                                    required>

                            </div>

                        </div>


                        <div class="form-group">

                            <label>
                                MRP
                            </label>

                            <div class="input-prefix">

                                <span>₹</span>

                                <input
                                    type="number"
                                    id="mrp"
                                    min="1"
                                    placeholder="999">

                            </div>

                        </div>

                    </div>


                    <div class="form-row">

                        <div class="form-group">

                            <label>
                                Stock Quantity <span class="required">*</span>
                            </label>

                            <input
                                type="number"
                                id="stock"
                                min="0"
                                placeholder="50"
                                required>

                        </div>


                        <div class="form-group">

                            <label>
                                SKU
                            </label>

                            <input
                                type="text"
                                id="sku"
                                placeholder="SZ-MEN-001">

                        </div>

                    </div>

                </div>


                <!-- SIZE -->

                <div class="form-card">

                    <h2>
                        Available Sizes
                    </h2>

                    <div class="checkbox-row">

                        <label class="checkbox-item">
                            <input type="checkbox" value="XS">
                            XS
                        </label>

                        <label class="checkbox-item">
                            <input type="checkbox" value="S">
                            S
                        </label>

                        <label class="checkbox-item">
                            <input type="checkbox" value="M">
                            M
                        </label>

                        <label class="checkbox-item">
                            <input type="checkbox" value="L">
                            L
                        </label>

                        <label class="checkbox-item">
                            <input type="checkbox" value="XL">
                            XL
                        </label>

                        <label class="checkbox-item">
                            <input type="checkbox" value="XXL">
                            XXL
                        </label>

                        <label class="checkbox-item">
                            <input type="checkbox" value="FREE SIZE">
                            FREE SIZE
                        </label>

                    </div>

                </div>


                <!-- ACTIONS -->

                <div class="form-actions">

                    <button
                        type="submit"
                        class="btn btn-primary">

                        <i class="fa-solid fa-plus"></i>
                        &nbsp; Add Product

                    </button>


                    <a
                        href="${pageContext.request.contextPath}/seller/dashboard.jsp"
                        class="btn btn-secondary"
                        style="display:flex;align-items:center;justify-content:center;text-decoration:none;">

                        Cancel

                    </a>

                </div>


            </div>


            <!-- RIGHT -->

            <aside>


                <!-- IMAGE -->

                <div class="form-card">

                    <h2>
                        Product Image
                    </h2>


                    <label
                        class="image-upload"
                        for="productImage">

                        <img
                            id="imagePreview"
                            class="image-preview"
                            alt="Product Preview">

                        <i
                            class="fa-solid fa-cloud-arrow-up"
                            id="uploadIcon">
                        </i>

                        <strong id="uploadText">
                            Upload Product Image
                        </strong>

                        <span>
                            JPG, JPEG, PNG • Max 5MB
                        </span>

                        <input
                            type="file"
                            id="productImage"
                            accept="image/png,image/jpeg,image/jpg"
                            onchange="previewImage(event)">

                    </label>

                </div>


                <!-- TIPS -->

                <div class="side-card">

                    <h3>
                        Seller Tips
                    </h3>


                    <div class="tip">

                        <i class="fa-solid fa-camera"></i>

                        <div>

                            <strong>
                                Use clear images
                            </strong>

                            <span>
                                Upload high-quality product images
                                with good lighting.
                            </span>

                        </div>

                    </div>


                    <div class="tip">

                        <i class="fa-solid fa-pen"></i>

                        <div>

                            <strong>
                                Write clear details
                            </strong>

                            <span>
                                Mention material, fit, colour and
                                important features.
                            </span>

                        </div>

                    </div>


                    <div class="tip">

                        <i class="fa-solid fa-tag"></i>

                        <div>

                            <strong>
                                Set competitive pricing
                            </strong>

                            <span>
                                Add accurate selling price and MRP
                                information.
                            </span>

                        </div>

                    </div>


                    <div class="tip">

                        <i class="fa-solid fa-boxes-stacked"></i>

                        <div>

                            <strong>
                                Keep stock updated
                            </strong>

                            <span>
                                Maintain correct inventory to avoid
                                cancelled orders.
                            </span>

                        </div>

                    </div>

                </div>


            </aside>


        </div>


    </form>


</main>


<!-- SUCCESS -->

<div
    class="success-box"
    id="successBox">

    <div class="success-content">

        <i class="fa-solid fa-circle-check"></i>

        <h2>
            Product Added!
        </h2>

        <p>
            Your product has been added successfully
            in demo mode.
        </p>

        <button onclick="goDashboard()">
            Go to Dashboard
        </button>

    </div>

</div>


<script>

    function previewImage(event) {

        const file =
            event.target.files[0];

        if (!file) {
            return;
        }

        if (file.size > 5 * 1024 * 1024) {

            alert("Image size must be less than 5MB.");

            event.target.value = "";

            return;
        }

        const preview =
            document.getElementById("imagePreview");

        const icon =
            document.getElementById("uploadIcon");

        const text =
            document.getElementById("uploadText");

        preview.src =
            URL.createObjectURL(file);

        preview.style.display =
            "block";

        icon.style.display =
            "none";

        text.innerText =
            file.name;

    }


    function submitProduct(event) {

        event.preventDefault();

        const name =
            document.getElementById("productName")
                .value.trim();

        const category =
            document.getElementById("category")
                .value;

        const description =
            document.getElementById("description")
                .value.trim();

        const price =
            document.getElementById("price")
                .value;

        const stock =
            document.getElementById("stock")
                .value;


        if (name === "") {

            alert("Please enter product name.");

            return;

        }


        if (category === "") {

            alert("Please select a category.");

            return;

        }


        if (description === "") {

            alert("Please enter product description.");

            return;

        }


        if (price <= 0) {

            alert("Please enter a valid price.");

            return;

        }


        if (stock < 0) {

            alert("Stock cannot be negative.");

            return;

        }


        document.getElementById("successBox")
            .style.display = "flex";

    }


    function goDashboard() {

        window.location.href =
            "${pageContext.request.contextPath}/seller/dashboard.jsp";

    }

</script>


</body>

</html>