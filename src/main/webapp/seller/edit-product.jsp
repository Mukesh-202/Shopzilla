<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Product | Shopzilla</title>

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

        .edit-page {
            max-width: 1150px;
            margin: auto;
            padding: 35px 5% 70px;
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

        .product-id {
            display: inline-block;
            margin-top: 9px;
            padding: 6px 9px;
            background: #111;
            color: #fff;
            font-size: 8px;
            font-weight: 700;
        }

        .edit-layout {
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

        .image-box {
            background: #fff;
            border: 1px solid #e4e4e4;
            padding: 20px;
            margin-bottom: 20px;
        }

        .image-box h2 {
            margin: 0 0 18px;
            font-size: 14px;
            text-transform: uppercase;
        }

        .current-image {
            width: 100%;
            height: 350px;
            object-fit: cover;
            display: block;
            margin-bottom: 15px;
        }

        .change-image {
            border: 1px dashed #aaa;
            min-height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 7px;
            cursor: pointer;
            background: #fafafa;
            text-align: center;
            padding: 15px;
        }

        .change-image i {
            font-size: 22px;
        }

        .change-image strong {
            font-size: 9px;
        }

        .change-image span {
            color: #888;
            font-size: 7px;
        }

        .change-image input {
            display: none;
        }

        .new-preview {
            width: 100%;
            max-height: 220px;
            object-fit: contain;
            display: none;
            margin-bottom: 10px;
        }

        .checkbox-row {
            display: flex;
            gap: 8px;
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

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-row span {
            color: #777;
            font-size: 9px;
        }

        .info-row strong {
            font-size: 9px;
        }

        .active {
            color: #16823b;
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
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
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

        .delete-section {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .delete-section h3 {
            margin: 0 0 7px;
            font-size: 11px;
        }

        .delete-section p {
            margin: 0 0 13px;
            color: #777;
            font-size: 9px;
            line-height: 1.5;
        }

        .delete-product {
            border: 1px solid #d4145a;
            color: #d4145a;
            background: #fff;
            padding: 10px 15px;
            font-size: 9px;
            font-weight: 800;
            cursor: pointer;
            text-transform: uppercase;
        }

        .delete-product:hover {
            background: #d4145a;
            color: #fff;
        }

        .success-box,
        .delete-box {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.65);
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .modal-content {
            background: #fff;
            width: 400px;
            max-width: 90%;
            padding: 40px 25px;
            text-align: center;
        }

        .modal-content i {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .success-icon {
            color: #16823b;
        }

        .delete-icon {
            color: #d4145a;
        }

        .modal-content h2 {
            margin: 0 0 9px;
            font-size: 20px;
        }

        .modal-content p {
            color: #777;
            font-size: 10px;
            line-height: 1.6;
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 18px;
        }

        .modal-buttons button {
            padding: 11px 20px;
            border: none;
            cursor: pointer;
            font-size: 9px;
            font-weight: 800;
        }

        .modal-primary {
            background: #111;
            color: #fff;
        }

        .modal-secondary {
            background: #eee;
            color: #111;
        }

        .modal-danger {
            background: #d4145a;
            color: #fff;
        }

        @media (max-width: 850px) {

            .edit-layout {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 600px) {

            .edit-page {
                padding: 25px 15px 50px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .form-card,
            .image-box,
            .side-card {
                padding: 18px;
            }

            .current-image {
                height: 300px;
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

            <a href="${pageContext.request.contextPath}/buyer/cart.jsp">
                <i class="fa-solid fa-bag-shopping"></i>
            </a>

        </div>

    </div>

</header>


<!-- ================= PAGE ================= -->

<main class="edit-page">


    <div class="breadcrumb">

        <a href="${pageContext.request.contextPath}/seller/dashboard.jsp">
            Seller Dashboard
        </a>

        &nbsp; / &nbsp;

        Edit Product

    </div>


    <div class="page-heading">

        <h1>
            Edit Product
        </h1>

        <p>
            Update your product information, pricing and inventory.
        </p>

        <span class="product-id">
            PRODUCT ID: #SZ1001
        </span>

    </div>


    <form
        id="editProductForm"
        onsubmit="updateProduct(event)">


        <div class="edit-layout">


            <!-- ================= LEFT ================= -->

            <div>


                <!-- PRODUCT INFORMATION -->

                <div class="form-card">

                    <h2>
                        Product Information
                    </h2>


                    <div class="form-group">

                        <label>
                            Product Name
                        </label>

                        <input
                            type="text"
                            id="productName"
                            value="Essential Cotton T-Shirt"
                            required>

                    </div>


                    <div class="form-row">


                        <div class="form-group">

                            <label>
                                Category
                            </label>

                            <select id="category">

                                <option selected>
                                    Men
                                </option>

                                <option>
                                    Women
                                </option>

                                <option>
                                    Kids
                                </option>

                                <option>
                                    Beauty
                                </option>

                                <option>
                                    Footwear
                                </option>

                                <option>
                                    Accessories
                                </option>

                            </select>

                        </div>


                        <div class="form-group">

                            <label>
                                Sub Category
                            </label>

                            <select id="subcategory">

                                <option selected>
                                    T-Shirts
                                </option>

                                <option>
                                    Shirts
                                </option>

                                <option>
                                    Jeans
                                </option>

                                <option>
                                    Jackets
                                </option>

                                <option>
                                    Dresses
                                </option>

                                <option>
                                    Sneakers
                                </option>

                                <option>
                                    Bags
                                </option>

                                <option>
                                    Watches
                                </option>

                            </select>

                        </div>


                    </div>


                    <div class="form-group">

                        <label>
                            Description
                        </label>

                        <textarea
                            id="description"
                            required>Premium everyday cotton T-shirt with a comfortable regular fit. Suitable for casual and daily wear.</textarea>

                    </div>

                </div>


                <!-- PRICE -->

                <div class="form-card">

                    <h2>
                        Price & Inventory
                    </h2>


                    <div class="form-row">


                        <div class="form-group">

                            <label>
                                Selling Price
                            </label>

                            <div class="input-prefix">

                                <span>₹</span>

                                <input
                                    type="number"
                                    id="price"
                                    value="799"
                                    min="1"
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
                                    value="999"
                                    min="1">

                            </div>

                        </div>


                    </div>


                    <div class="form-row">


                        <div class="form-group">

                            <label>
                                Stock Quantity
                            </label>

                            <input
                                type="number"
                                id="stock"
                                value="42"
                                min="0"
                                required>

                        </div>


                        <div class="form-group">

                            <label>
                                SKU
                            </label>

                            <input
                                type="text"
                                id="sku"
                                value="SZ-MEN-001">

                        </div>


                    </div>

                </div>


                <!-- SIZES -->

                <div class="form-card">

                    <h2>
                        Available Sizes
                    </h2>


                    <div class="checkbox-row">


                        <label class="checkbox-item">

                            <input
                                type="checkbox"
                                checked
                                value="S">

                            S

                        </label>


                        <label class="checkbox-item">

                            <input
                                type="checkbox"
                                checked
                                value="M">

                            M

                        </label>


                        <label class="checkbox-item">

                            <input
                                type="checkbox"
                                checked
                                value="L">

                            L

                        </label>


                        <label class="checkbox-item">

                            <input
                                type="checkbox"
                                checked
                                value="XL">

                            XL

                        </label>


                        <label class="checkbox-item">

                            <input
                                type="checkbox"
                                value="XXL">

                            XXL

                        </label>


                    </div>

                </div>


                <!-- ACTION -->

                <div class="form-actions">


                    <button
                        type="submit"
                        class="btn btn-primary">

                        <i class="fa-solid fa-floppy-disk"></i>
                        &nbsp; Save Changes

                    </button>


                    <a
                        href="${pageContext.request.contextPath}/seller/dashboard.jsp"
                        class="btn btn-secondary">

                        Cancel

                    </a>


                </div>


                <!-- DELETE -->

                <div class="delete-section">

                    <h3>
                        Delete Product
                    </h3>

                    <p>
                        Deleting this product will remove it from your
                        store. This action should only be used when
                        the product is no longer available.
                    </p>


                    <button
                        type="button"
                        class="delete-product"
                        onclick="showDeleteModal()">

                        <i class="fa-solid fa-trash"></i>
                        &nbsp; Delete Product

                    </button>

                </div>


            </div>


            <!-- ================= RIGHT ================= -->

            <aside>


                <!-- IMAGE -->

                <div class="image-box">

                    <h2>
                        Product Image
                    </h2>


                    <img
                        id="currentImage"
                        class="current-image"
                        src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=80"
                        alt="Product">


                    <img
                        id="newPreview"
                        class="new-preview"
                        alt="New Product Image">


                    <label
                        class="change-image"
                        for="newImage">

                        <i
                            class="fa-solid fa-camera">
                        </i>

                        <strong>
                            Change Product Image
                        </strong>

                        <span>
                            JPG, JPEG, PNG • Max 5MB
                        </span>

                        <input
                            type="file"
                            id="newImage"
                            accept="image/jpeg,image/jpg,image/png"
                            onchange="previewImage(event)">

                    </label>

                </div>


                <!-- PRODUCT INFO -->

                <div class="side-card">

                    <h3>
                        Product Information
                    </h3>


                    <div class="info-row">

                        <span>
                            Product ID
                        </span>

                        <strong>
                            #SZ1001
                        </strong>

                    </div>


                    <div class="info-row">

                        <span>
                            Status
                        </span>

                        <strong class="active">
                            Active
                        </strong>

                    </div>


                    <div class="info-row">

                        <span>
                            Created
                        </span>

                        <strong>
                            10 Sep 2026
                        </strong>

                    </div>


                    <div class="info-row">

                        <span>
                            Last Updated
                        </span>

                        <strong>
                            18 Sep 2026
                        </strong>

                    </div>


                    <div class="info-row">

                        <span>
                            Rating
                        </span>

                        <strong>
                            ★ 4.6
                        </strong>

                    </div>


                    <div class="info-row">

                        <span>
                            Reviews
                        </span>

                        <strong>
                            38
                        </strong>

                    </div>


                </div>


            </aside>


        </div>


    </form>


</main>


<!-- ================= SUCCESS MODAL ================= -->

<div
    class="success-box"
    id="successBox">


    <div class="modal-content">

        <i
            class="fa-solid fa-circle-check success-icon">
        </i>

        <h2>
            Product Updated!
        </h2>

        <p>
            Your product information has been updated successfully
            in demo mode.
        </p>

        <div class="modal-buttons">

            <button
                class="modal-primary"
                onclick="goDashboard()">

                Go to Dashboard

            </button>

        </div>

    </div>

</div>


<!-- ================= DELETE MODAL ================= -->

<div
    class="delete-box"
    id="deleteBox">


    <div class="modal-content">

        <i
            class="fa-solid fa-triangle-exclamation delete-icon">
        </i>

        <h2>
            Delete Product?
        </h2>

        <p>
            Are you sure you want to delete
            <strong>Essential Cotton T-Shirt</strong>?
            This action cannot be undone.
        </p>


        <div class="modal-buttons">

            <button
                class="modal-secondary"
                onclick="closeDeleteModal()">

                Cancel

            </button>


            <button
                class="modal-danger"
                onclick="deleteProduct()">

                Delete

            </button>

        </div>

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


        const currentImage =
            document.getElementById("currentImage");

        const newPreview =
            document.getElementById("newPreview");


        newPreview.src =
            URL.createObjectURL(file);

        newPreview.style.display =
            "block";

        currentImage.style.display =
            "none";

    }


    function updateProduct(event) {

        event.preventDefault();


        const name =
            document.getElementById("productName")
                .value.trim();

        const description =
            document.getElementById("description")
                .value.trim();

        const price =
            Number(
                document.getElementById("price").value
            );

        const mrp =
            Number(
                document.getElementById("mrp").value
            );

        const stock =
            Number(
                document.getElementById("stock").value
            );


        if (name === "") {

            alert("Please enter product name.");

            return;

        }


        if (description === "") {

            alert("Please enter description.");

            return;

        }


        if (price <= 0) {

            alert("Please enter a valid selling price.");

            return;

        }


        if (mrp > 0 && mrp < price) {

            alert("MRP should be greater than or equal to selling price.");

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


    function showDeleteModal() {

        document.getElementById("deleteBox")
            .style.display = "flex";

    }


    function closeDeleteModal() {

        document.getElementById("deleteBox")
            .style.display = "none";

    }


    function deleteProduct() {

        document.getElementById("deleteBox")
            .style.display = "none";


        alert(
            "Product deleted successfully in demo mode."
        );


        window.location.href =
            "${pageContext.request.contextPath}/seller/dashboard.jsp";

    }


</script>


</body>

</html>

