/* =========================================================
   SHOPZILLA - AI CHATBOT
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {

    initializeChatbot();

});


/* =========================================================
   INITIALIZE CHATBOT
   ========================================================= */

function initializeChatbot() {

    const chatbotButton =
        document.querySelector(".chatbot-button");

    const chatbotBox =
        document.querySelector(".chatbot-box");

    const chatbotClose =
        document.querySelector(".chatbot-close");

    const chatbotForm =
        document.querySelector(".chatbot-form");

    if (chatbotButton && chatbotBox) {

        chatbotButton.addEventListener(
            "click",
            function () {

                chatbotBox.classList.toggle("active");

            }
        );

    }

    if (chatbotClose && chatbotBox) {

        chatbotClose.addEventListener(
            "click",
            function () {

                chatbotBox.classList.remove("active");

            }
        );

    }

    if (chatbotForm) {

        chatbotForm.addEventListener(
            "submit",
            function (event) {

                event.preventDefault();

                sendChatMessage();

            }
        );

    }

}


/* =========================================================
   SEND CHAT MESSAGE
   ========================================================= */

function sendChatMessage() {

    const input =
        document.querySelector(".chatbot-input");

    const messages =
        document.querySelector(".chatbot-messages");

    if (!input || !messages) {
        return;
    }

    const message =
        input.value.trim();

    if (message === "") {
        return;
    }

    addChatMessage(
        message,
        "user"
    );

    input.value = "";

    showTypingIndicator();

    fetch(
        "ChatServlet",
        {
            method: "POST",
            headers: {
                "Content-Type":
                    "application/x-www-form-urlencoded"
            },
            body:
                "message=" +
                encodeURIComponent(message)
        }
    )
    .then(function (response) {

        return response.text();

    })
    .then(function (reply) {

        hideTypingIndicator();

        if (reply && reply.trim() !== "") {

            addChatMessage(
                reply,
                "bot"
            );

        } else {

            addChatMessage(
                getFallbackReply(message),
                "bot"
            );

        }

    })
    .catch(function () {

        hideTypingIndicator();

        addChatMessage(
            getFallbackReply(message),
            "bot"
        );

    });

}


/* =========================================================
   ADD CHAT MESSAGE
   ========================================================= */

function addChatMessage(message, type) {

    const messages =
        document.querySelector(".chatbot-messages");

    if (!messages) {
        return;
    }

    const messageElement =
        document.createElement("div");

    messageElement.className =
        "chat-message " + type;

    const bubble =
        document.createElement("div");

    bubble.className =
        "chat-bubble";

    /*
     * textContent is intentionally used here
     * to prevent HTML injection.
     */

    bubble.textContent = message;

    messageElement.appendChild(bubble);

    messages.appendChild(messageElement);

    messages.scrollTop =
        messages.scrollHeight;

}


/* =========================================================
   TYPING INDICATOR
   ========================================================= */

function showTypingIndicator() {

    const messages =
        document.querySelector(".chatbot-messages");

    if (!messages) {
        return;
    }

    if (
        document.querySelector(
            ".chatbot-typing"
        )
    ) {
        return;
    }

    const typing =
        document.createElement("div");

    typing.className =
        "chat-message bot chatbot-typing";

    typing.innerHTML =
        '<div class="chat-bubble">' +
        '<span>.</span>' +
        '<span>.</span>' +
        '<span>.</span>' +
        '</div>';

    messages.appendChild(typing);

    messages.scrollTop =
        messages.scrollHeight;

}


function hideTypingIndicator() {

    const typing =
        document.querySelector(
            ".chatbot-typing"
        );

    if (typing) {
        typing.remove();
    }

}


/* =========================================================
   FALLBACK RESPONSE
   ========================================================= */

function getFallbackReply(message) {

    const text =
        message.toLowerCase();

    if (
        text.includes("hello") ||
        text.includes("hi") ||
        text.includes("hey")
    ) {

        return "Hi! Welcome to Shopzilla. How can I help you?";

    }

    if (
        text.includes("product") ||
        text.includes("dress") ||
        text.includes("shirt") ||
        text.includes("shoe")
    ) {

        return "Sure! You can browse our latest fashion products from the Shop section.";

    }

    if (
        text.includes("cart")
    ) {

        return "You can view your selected products by opening the Cart.";

    }

    if (
        text.includes("order")
    ) {

        return "You can check your orders from your Orders section after login.";

    }

    if (
        text.includes("return")
    ) {

        return "For return-related help, please check the order details or contact Shopzilla support.";

    }

    if (
        text.includes("payment") ||
        text.includes("pay")
    ) {

        return "Shopzilla supports the checkout flow with the available payment option shown during checkout.";

    }

    return "I'm Shopzilla Assistant. I can help you with products, cart, orders, checkout and general shopping questions.";

}


/* =========================================================
   CLOSE CHAT WHEN CLICKING OUTSIDE
   ========================================================= */

document.addEventListener(
    "click",
    function (event) {

        const chatbot =
            document.querySelector(".chatbot-box");

        const button =
            document.querySelector(".chatbot-button");

        if (!chatbot || !button) {
            return;
        }

        if (
            chatbot.classList.contains("active") &&
            !chatbot.contains(event.target) &&
            !button.contains(event.target)
        ) {

            chatbot.classList.remove("active");

        }

    }
);