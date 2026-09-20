/* =========================================================
   SHOPZILLA - CART JAVASCRIPT
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {

    initializeCart();

});


/* =========================================================
   INITIALIZE CART
   ========================================================= */

function initializeCart() {

    const quantityInputs =
        document.querySelectorAll(".cart-quantity");

    quantityInputs.forEach(function (input) {

        input.addEventListener("change", function () {
            updateCartItem(this);
        });

    });

    const removeButtons =
        document.querySelectorAll(".remove-cart-item");

    removeButtons.forEach(function (button) {

        button.addEventListener("click", function () {
            removeCartItem(this);
        });

    });

    updateCartTotal();

}


/* =========================================================
   INCREASE QUANTITY
   ========================================================= */

function increaseQuantity(button) {

    const container = button.closest(".quantity-control");

    if (!container) {
        return;
    }

    const input =
        container.querySelector(".cart-quantity");

    if (!input) {
        return;
    }

    let quantity = parseInt(input.value) || 1;

    quantity++;

    input.value = quantity;

    updateCartItem(input);

}


/* =========================================================
   DECREASE QUANTITY
   ========================================================= */

function decreaseQuantity(button) {

    const container = button.closest(".quantity-control");

    if (!container) {
        return;
    }

    const input =
        container.querySelector(".cart-quantity");

    if (!input) {
        return;
    }

    let quantity = parseInt(input.value) || 1;

    if (quantity > 1) {
        quantity--;
    }

    input.value = quantity;

    updateCartItem(input);

}


/* =========================================================
   UPDATE CART ITEM
   ========================================================= */

function updateCartItem(input) {

    let quantity = parseInt(input.value);

    if (isNaN(quantity) || quantity < 1) {
        quantity = 1;
        input.value = 1;
    }

    const cartItem =
        input.closest(".cart-item");

    if (!cartItem) {
        updateCartTotal();
        return;
    }

    const priceElement =
        cartItem.querySelector(".cart-item-price");

    const subtotalElement =
        cartItem.querySelector(".cart-item-subtotal");

    if (priceElement && subtotalElement) {

        const price =
            parseFloat(
                priceElement.dataset.price ||
                priceElement.textContent
                    .replace(/[₹,]/g, "")
            ) || 0;

        const subtotal = price * quantity;

        subtotalElement.textContent =
            formatPrice(subtotal);

    }

    updateCartTotal();

}


/* =========================================================
   REMOVE CART ITEM
   ========================================================= */

function removeCartItem(button) {

    const cartItem =
        button.closest(".cart-item");

    if (!cartItem) {
        return;
    }

    const productId =
        button.dataset.productId;

    if (productId) {

        fetch(
            "CartServlet?action=remove&productId=" +
            encodeURIComponent(productId),
            {
                method: "POST"
            }
        )
        .then(function (response) {

            if (response.ok) {

                cartItem.remove();

                updateCartTotal();

                updateCartCountFromPage();

                showShopzillaMessage(
                    "Product removed from cart."
                );

            } else {

                showShopzillaMessage(
                    "Unable to remove product."
                );

            }

        })
        .catch(function () {

            showShopzillaMessage(
                "Something went wrong."
            );

        });

    } else {

        cartItem.remove();

        updateCartTotal();

        updateCartCountFromPage();

        showShopzillaMessage(
            "Product removed from cart."
        );

    }

}


/* =========================================================
   UPDATE TOTAL
   ========================================================= */

function updateCartTotal() {

    let total = 0;

    const cartItems =
        document.querySelectorAll(".cart-item");

    cartItems.forEach(function (item) {

        const input =
            item.querySelector(".cart-quantity");

        const priceElement =
            item.querySelector(".cart-item-price");

        if (!input || !priceElement) {
            return;
        }

        const quantity =
            parseInt(input.value) || 1;

        const price =
            parseFloat(
                priceElement.dataset.price ||
                priceElement.textContent
                    .replace(/[₹,]/g, "")
            ) || 0;

        total += price * quantity;

    });

    const totalElements =
        document.querySelectorAll(
            ".cart-total-value, .cart-grand-total"
        );

    totalElements.forEach(function (element) {

        element.textContent =
            formatPrice(total);

    });

    const subtotal =
        document.querySelector(".cart-subtotal");

    if (subtotal) {
        subtotal.textContent =
            formatPrice(total);
    }

}


/* =========================================================
   UPDATE CART COUNT
   ========================================================= */

function updateCartCountFromPage() {

    const items =
        document.querySelectorAll(".cart-item");

    let count = 0;

    items.forEach(function (item) {

        const input =
            item.querySelector(".cart-quantity");

        if (input) {
            count += parseInt(input.value) || 0;
        }

    });

    updateCartCount(count);

}


/* =========================================================
   ADD PRODUCT TO CART
   ========================================================= */

function addToCart(productId, quantity) {

    quantity = quantity || 1;

    if (!productId) {

        showShopzillaMessage(
            "Product information is missing."
        );

        return;

    }

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

            showShopzillaMessage(
                "Product added to cart!"
            );

            const countElement =
                document.querySelector(".cart-count");

            if (countElement) {

                let count =
                    parseInt(countElement.textContent) || 0;

                updateCartCount(count + quantity);

            }

        } else {

            showShopzillaMessage(
                "Please login to add products."
            );

        }

    })
    .catch(function () {

        showShopzillaMessage(
            "Unable to add product to cart."
        );

    });

}


/* =========================================================
   CLEAR CART
   ========================================================= */

function clearCart() {

    if (!confirm("Remove all products from your cart?")) {
        return;
    }

    fetch(
        "CartServlet?action=clear",
        {
            method: "POST"
        }
    )
    .then(function (response) {

        if (response.ok) {

            document
                .querySelectorAll(".cart-item")
                .forEach(function (item) {
                    item.remove();
                });

            updateCartTotal();

            updateCartCount(0);

            showShopzillaMessage(
                "Cart cleared successfully."
            );

        }

    })
    .catch(function () {

        showShopzillaMessage(
            "Unable to clear cart."
        );

    });

}


/* =========================================================
   FORMAT PRICE
   ========================================================= */

function formatPrice(price) {

    const number = Number(price);

    if (isNaN(number)) {
        return "₹0";
    }

    return "₹" +
        number.toLocaleString("en-IN", {
            maximumFractionDigits: 2
        });

}


/* =========================================================
   UPDATE CART BADGE
   ========================================================= */

function updateCartCount(count) {

    document
        .querySelectorAll(".cart-count")
        .forEach(function (element) {

            element.textContent = count;

        });

}