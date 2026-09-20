/* =========================================================
   SHOPZILLA - MAIN JAVASCRIPT
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {

    /* ---------- Mobile Navigation ---------- */

    const mobileMenuBtn = document.querySelector(".mobile-menu-btn");
    const mobileNav = document.querySelector(".mobile-nav");

    if (mobileMenuBtn && mobileNav) {
        mobileMenuBtn.addEventListener("click", function () {
            mobileNav.classList.toggle("active");

            const icon = mobileMenuBtn.querySelector("i");

            if (icon) {
                if (mobileNav.classList.contains("active")) {
                    icon.classList.remove("fa-bars");
                    icon.classList.add("fa-times");
                } else {
                    icon.classList.remove("fa-times");
                    icon.classList.add("fa-bars");
                }
            }
        });
    }

    /* ---------- Smooth Scroll ---------- */

    document.querySelectorAll('a[href^="#"]').forEach(function (link) {

        link.addEventListener("click", function (event) {

            const targetId = this.getAttribute("href");

            if (targetId && targetId !== "#") {

                const target = document.querySelector(targetId);

                if (target) {
                    event.preventDefault();

                    target.scrollIntoView({
                        behavior: "smooth",
                        block: "start"
                    });
                }
            }
        });

    });

    /* ---------- Header Shadow on Scroll ---------- */

    const header = document.querySelector(".site-header");

    if (header) {

        window.addEventListener("scroll", function () {

            if (window.scrollY > 20) {
                header.classList.add("scrolled");
            } else {
                header.classList.remove("scrolled");
            }

        });

    }

    /* ---------- Back To Top ---------- */

    const backToTop = document.querySelector(".back-to-top");

    if (backToTop) {

        window.addEventListener("scroll", function () {

            if (window.scrollY > 500) {
                backToTop.classList.add("show");
            } else {
                backToTop.classList.remove("show");
            }

        });

        backToTop.addEventListener("click", function () {

            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });

        });
    }

    /* ---------- Newsletter ---------- */

    const newsletterForm =
        document.querySelector(".newsletter-form");

    if (newsletterForm) {

        newsletterForm.addEventListener("submit", function (event) {

            event.preventDefault();

            const emailInput =
                newsletterForm.querySelector("input[type='email']");

            if (!emailInput) {
                return;
            }

            const email = emailInput.value.trim();

            if (email === "") {
                showShopzillaMessage(
                    "Please enter your email address."
                );
                return;
            }

            showShopzillaMessage(
                "Thank you for subscribing to Shopzilla!"
            );

            emailInput.value = "";

        });

    }

    /* ---------- Image Lazy Loading ---------- */

    const images = document.querySelectorAll("img");

    images.forEach(function (image) {

        if (!image.hasAttribute("loading")) {
            image.setAttribute("loading", "lazy");
        }

    });

});


/* =========================================================
   SHOPZILLA MESSAGE
   ========================================================= */

function showShopzillaMessage(message) {

    let messageBox =
        document.querySelector(".shopzilla-message");

    if (!messageBox) {

        messageBox = document.createElement("div");

        messageBox.className = "shopzilla-message";

        document.body.appendChild(messageBox);

    }

    messageBox.textContent = message;

    messageBox.classList.add("show");

    setTimeout(function () {

        messageBox.classList.remove("show");

    }, 2500);
}


/* =========================================================
   CONFIRM LOGOUT
   ========================================================= */

function confirmLogout() {

    return confirm(
        "Are you sure you want to logout from Shopzilla?"
    );

}


/* =========================================================
   FORMAT PRICE
   ========================================================= */

function formatPrice(price) {

    const number = Number(price);

    if (isNaN(number)) {
        return "₹0";
    }

    return "₹" + number.toLocaleString("en-IN");

}


/* =========================================================
   UPDATE CART COUNT
   ========================================================= */

function updateCartCount(count) {

    const cartCounts =
        document.querySelectorAll(".cart-count");

    cartCounts.forEach(function (element) {

        element.textContent = count;

    });

}


/* =========================================================
   SEARCH VALIDATION
   ========================================================= */

function validateSearch() {

    const searchInput =
        document.querySelector(".nav-search input");

    if (!searchInput) {
        return true;
    }

    const value = searchInput.value.trim();

    if (value.length === 0) {

        showShopzillaMessage(
            "Please enter a product to search."
        );

        searchInput.focus();

        return false;
    }

    return true;

}