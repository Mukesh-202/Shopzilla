function toggleLuma() {

    const chat = document.getElementById("luma-chat");

    if (chat.style.display === "block") {
        chat.style.display = "none";
    } else {
        chat.style.display = "block";
    }
}


/* ================= VOICE SEARCH ================= */

function startLumaVoice() {

    const SpeechRecognition =
        window.SpeechRecognition ||
        window.webkitSpeechRecognition;

    if (!SpeechRecognition) {
        alert("Voice search is not supported in this browser.");
        return;
    }

    const recognition = new SpeechRecognition();

    recognition.lang = "en-IN";
    recognition.continuous = false;
    recognition.interimResults = false;

    const input = document.getElementById("luma-input");

    recognition.start();

    input.placeholder = "Listening...";

    recognition.onresult = function(event) {

        const text =
            event.results[0][0].transcript;

        input.value = text;

        input.placeholder = "Search products...";

        lumaSearch();
    };

    recognition.onerror = function() {

        input.placeholder =
            "Search products...";
    };

    recognition.onend = function() {

        input.placeholder =
            "Search products...";
    };
}


/* ================= PRODUCT SEARCH ================= */

function lumaSearch() {

    const input =
        document.getElementById("luma-input");

    const messageBox =
        document.getElementById("luma-messages");

    const query =
        input.value.trim().toLowerCase();

    if (query === "") {
        return;
    }


    /* User message */

    messageBox.innerHTML += `
        <div class="luma-message">
            You: ${escapeLumaText(query)}
        </div>
    `;


    /* Product database */

    const products = [

        {
            name: "Black T-Shirt",
            price: 899,
            image: "men1.jpg"
        },

        {
            name: "Blue Jeans",
            price: 1499,
            image: "men2.jpg"
        },

        {
            name: "White Shirt",
            price: 999,
            image: "men3.webp"
        },

        {
            name: "Hoodie",
            price: 1199,
            image: "men4.jpg"
        },

        {
            name: "Sneakers",
            price: 1999,
            image: "men5.webp"
        },

        {
            name: "Red Dress",
            price: 1299,
            image: "women1.jpg"
        },

        {
            name: "Women Top",
            price: 899,
            image: "women2.webp"
        },

        {
            name: "Women Jeans",
            price: 1499,
            image: "women3.jpg"
        },

        {
            name: "Women Heels",
            price: 1899,
            image: "women4.jpg"
        },

        {
            name: "Hand Bag",
            price: 799,
            image: "women5.webp"
        },

        {
            name: "Kids T-Shirt",
            price: 599,
            image: "kids1.jpg"
        },

        {
            name: "Kids Jeans",
            price: 899,
            image: "kids2.webp"
        },

        {
            name: "Kids Dress",
            price: 999,
            image: "kids3.webp"
        },

        {
            name: "Kids Sneakers",
            price: 1199,
            image: "kids4.webp"
        },

        {
            name: "Kids Backpack",
            price: 699,
            image: "kids5.jpg"
        },

        {
            name: "Running Shoes",
            price: 1999,
            image: "footwear1.jpg"
        },

        {
            name: "Casual Sneakers",
            price: 1799,
            image: "footwear2.jpg"
        },

        {
            name: "Sports Shoes",
            price: 2299,
            image: "footwear3.webp"
        },

        {
            name: "Sandals",
            price: 799,
            image: "footwear5.jpg"
        },

        {
            name: "Face Cream",
            price: 699,
            image: "beauty1.webp"
        },

        {
            name: "Lipstick",
            price: 499,
            image: "beauty2.jpg"
        },

        {
            name: "Makeup Kit",
            price: 1299,
            image: "beauty3.webp"
        },

        {
            name: "Perfume",
            price: 999,
            image: "beauty4.webp"
        },

        {
            name: "Makeup Brushes Set",
            price: 599,
            image: "beauty5.jpg"
        },

        {
            name: "Watch",
            price: 2499,
            image: "accessories2.webp"
        },

        {
            name: "Sunglasses",
            price: 599,
            image: "accessories3.jpg"
        },

        {
            name: "Backpack",
            price: 999,
            image: "accessories4.webp"
        },

        {
            name: "Wallet",
            price: 699,
            image: "accessories5.jpg"
        }

    ];


    /* ================= SEARCH ================= */

    let results = products.filter(function(product) {

        return product.name
            .toLowerCase()
            .includes(query);

    });


    /* Category search */

    if (
        query.includes("men") ||
        query.includes("mens")
    ) {

        results = products.filter(function(product) {

            return [
                "black t-shirt",
                "blue jeans",
                "white shirt",
                "hoodie",
                "sneakers"
            ].includes(
                product.name.toLowerCase()
            );

        });

    }


    if (query.includes("women")) {

        results = products.filter(function(product) {

            return [
                "red dress",
                "women top",
                "women jeans",
                "women heels",
                "hand bag"
            ].includes(
                product.name.toLowerCase()
            );

        });

    }


    if (query.includes("kids")) {

        results = products.filter(function(product) {

            return product.name
                .toLowerCase()
                .includes("kids");

        });

    }


    if (
        query.includes("shoe") ||
        query.includes("shoes")
    ) {

        results = products.filter(function(product) {

            return product.name
                .toLowerCase()
                .includes("shoe") ||
                product.name
                    .toLowerCase()
                    .includes("sneaker") ||
                product.name
                    .toLowerCase()
                    .includes("heels") ||
                product.name
                    .toLowerCase()
                    .includes("sandals");

        });

    }


    /* Price search */

    const underMatch =
        query.match(/under\s*(\d+)/);

    if (underMatch) {

        const amount =
            parseInt(underMatch[1]);

        results = products.filter(function(product) {

            return product.price <= amount;

        });

    }


    /* ================= RESULTS ================= */

    if (results.length === 0) {

        messageBox.innerHTML += `
            <div class="luma-message">
                Sorry 😕 I couldn't find that product.
                <br><br>
                Try:
                <br>
                • black t-shirt
                <br>
                • shoes
                <br>
                • women
                <br>
                • kids
                <br>
                • under 1000
            </div>
        `;

    } else {

        messageBox.innerHTML += `
            <div class="luma-message">
                🔎 I found ${results.length}
                product(s) for you:
            </div>
        `;


        results.forEach(function(product) {

            const imageURL =
                window.location.origin +
                window.location.pathname
                    .substring(
                        0,
                        window.location.pathname
                            .indexOf("/buyer/")
                    ) +
                "/images/" +
                product.image;


            const cartURL =
                window.location.origin +
                window.location.pathname
                    .substring(
                        0,
                        window.location.pathname
                            .indexOf("/buyer/")
                    ) +
                "/buyer/cart.jsp" +
                "?name=" +
                encodeURIComponent(product.name) +
                "&price=" +
                product.price +
                "&image=" +
                encodeURIComponent(product.image);


            messageBox.innerHTML += `

                <div class="luma-product">

                    <img src="${imageURL}"
                         alt="${escapeLumaText(product.name)}">

                    <div class="luma-product-info">

                        <strong>
                            ${escapeLumaText(product.name)}
                        </strong>

                        <span>
                            ₹${product.price}
                        </span>

                        <a href="${cartURL}"
                           class="luma-cart-btn">
                            ADD TO CART
                        </a>

                    </div>

                </div>

            `;

        });

    }


    input.value = "";

    messageBox.scrollTop =
        messageBox.scrollHeight;
}


/* ================= SECURITY ================= */

function escapeLumaText(text) {

    return text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}