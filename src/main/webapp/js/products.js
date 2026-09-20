/* =========================================================
   SHOPZILLA - PRODUCTS JAVASCRIPT
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {

    initializeProductPage();

});


/* =========================================================
   INITIALIZE PRODUCT PAGE
   ========================================================= */

function initializeProductPage() {

    initializeWishlist();

    initializeQuickAdd();

    initializeSizeSelection();

    initializeProductFilters();

    initializeProductSearch();

}


/* =========================================================
   WISHLIST
   ========================================================= */

function initializeWishlist() {

    const wishlistButtons =
        document.querySelectorAll(
            ".product-wishlist"
        );

    wishlistButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            toggleWishlist(this);

        });

    });

}


function toggleWishlist(button) {

    const icon =
        button.querySelector("i");

    const active =
        button.classList.toggle("active");

    if (icon) {

        if (active) {

            icon.classList.remove("far");
            icon.classList.add("fas");

            showProductMessage(
                "Added to wishlist."
            );

        } else {

            icon.classList.remove("fas");
            icon.classList.add("far");

            showProductMessage(
                "Removed from wishlist."
            );

        }

    }

}


/* =========================================================
   QUICK ADD
   ========================================================= */

function initializeQuickAdd() {

    const buttons =
        document.querySelectorAll(".quick-add");

    buttons.forEach(function (button) {

        button.addEventListener("click", function () {

            const productId =
                this.dataset.productId;

            if (!productId) {

                showProductMessage(
                    "Product information is missing."
                );

                return;

            }

            addProductToCart(productId, 1);

        });

    });

}


/* =========================================================
   ADD PRODUCT TO CART
   ========================================================= */

function addProductToCart(productId, quantity) {

    quantity = quantity || 1;

    fetch(
        "CartServlet?action=add&productId=" +
        encodeURIComponent(productId) +
        "&quantity=" +
        encodeURIComponent(quantity),
        {
            method: "POST"
        }
    )
    .then(function (response) {

        if (response.ok) {

            showProductMessage(
                "Product added to cart!"
            );

            updateProductCartCount(quantity);

        } else if (response.status === 401) {

            showProductMessage(
                "Please login to add products."
            );

        } else {

            showProductMessage(
                "Unable to add product."
            );

        }

    })
    .catch(function () {

        showProductMessage(
            "Something went wrong."
        );

    });

}


/* =========================================================
   CART COUNT
   ========================================================= */

function updateProductCartCount(amount) {

    const badges =
        document.querySelectorAll(".cart-count");

    badges.forEach(function (badge) {

        let current =
            parseInt(badge.textContent) || 0;

        badge.textContent =
            current + amount;

    });

}


/* =========================================================
   SIZE SELECTION
   ========================================================= */

function initializeSizeSelection() {

    const sizeButtons =
        document.querySelectorAll(".size-option");

    sizeButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            sizeButtons.forEach(function (item) {

                item.classList.remove("active");

            });

            this.classList.add("active");

        });

    });

}


/* =========================================================
   PRODUCT FILTERS
   ========================================================= */

function initializeProductFilters() {

    const filterButtons =
        document.querySelectorAll(".filter-btn");

    filterButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            filterButtons.forEach(function (item) {

                item.classList.remove("active");

            });

            this.classList.add("active");

            const category =
                this.dataset.category;

            if (category) {

                filterProducts(category);

            }

        });

    });

}


/* =========================================================
   FILTER PRODUCTS
   ========================================================= */

function filterProducts(category) {

    const products =
        document.querySelectorAll(".product-card");

    let visibleProducts = 0;

    products.forEach(function (product) {

        const productCategory =
            product.dataset.category;

        if (
            category === "all" ||
            !category ||
            productCategory === category
        ) {

            product.style.display = "";

            visibleProducts++;

        } else {

            product.style.display = "none";

        }

    });

    updateEmptyProductMessage(
        visibleProducts
    );

}


/* =========================================================
   EMPTY PRODUCT MESSAGE
   ========================================================= */

function updateEmptyProductMessage(count) {

    let emptyMessage =
        document.querySelector(
            ".filter-empty-message"
        );

    if (count === 0) {

        if (!emptyMessage) {

            emptyMessage =
                document.createElement("div");

            emptyMessage.className =
                "filter-empty-message";

            emptyMessage.innerHTML =
                "<h3>No products found</h3>" +
                "<p>Try another category.</p>";

            const grid =
                document.querySelector(".product-grid");

            if (grid) {

                grid.parentNode.insertBefore(
                    emptyMessage,
                    grid.nextSibling
                );

            }

        }

        emptyMessage.style.display = "block";

    } else if (emptyMessage) {

        emptyMessage.style.display = "none";

    }

}


/* =========================================================
   PRODUCT SEARCH
   ========================================================= */

function initializeProductSearch() {

    const searchInput =
        document.querySelector(
            ".product-search-input"
        );

    if (!searchInput) {
        return;
    }

    searchInput.addEventListener(
        "input",
        function () {

            searchProducts(
                this.value.trim().toLowerCase()
            );

        }
    );

}


function searchProducts(searchTerm) {

    const products =
        document.querySelectorAll(".product-card");

    let visibleProducts = 0;

    products.forEach(function (product) {

        const nameElement =
            product.querySelector(".product-name");

        const brandElement =
            product.querySelector(".product-brand");

        const name =
            nameElement
                ? nameElement.textContent.toLowerCase()
                : "";

        const brand =
            brandElement
                ? brandElement.textContent.toLowerCase()
                : "";

        if (
            searchTerm === "" ||
            name.includes(searchTerm) ||
            brand.includes(searchTerm)
        ) {

            product.style.display = "";

            visibleProducts++;

        } else {

            product.style.display = "none";

        }

    });

    updateEmptyProductMessage(
        visibleProducts
    );

}


/* =========================================================
   SORT PRODUCTS
   ========================================================= */

function sortProducts(value) {

    const grid =
        document.querySelector(".product-grid");

    if (!grid) {
        return;
    }

    const products =
        Array.from(
            grid.querySelectorAll(".product-card")
        );

    products.sort(function (a, b) {

        const priceA =
            getProductPrice(a);

        const priceB =
            getProductPrice(b);

        if (value === "price-low") {
            return priceA - priceB;
        }

        if (value === "price-high") {
            return priceB - priceA;
        }

        return 0;

    });

    products.forEach(function (product) {

        grid.appendChild(product);

    });

}


function getProductPrice(product) {

    const priceElement =
        product.querySelector(".current-price");

    if (!priceElement) {
        return 0;
    }

    return parseFloat(
        priceElement.textContent
            .replace(/[₹,]/g, "")
    ) || 0;

}


/* =========================================================
   PRODUCT MESSAGE
   ========================================================= */

function showProductMessage(message) {

    if (typeof showShopzillaMessage === "function") {

        showShopzillaMessage(message);

        return;

    }

    alert(message);

}