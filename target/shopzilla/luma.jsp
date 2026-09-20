<%@ page contentType="text/html;charset=UTF-8" %>

<style>
#luma-button {
    position: fixed;
    right: 25px;
    bottom: 25px;
    width: 62px;
    height: 62px;
    padding: 0;
    border: 3px solid white;
    border-radius: 50%;
    overflow: hidden;
    background: white;
    box-shadow: 0 4px 18px rgba(0,0,0,0.35);
    cursor: pointer;
    z-index: 999999;
}

#luma-button img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
    border-radius: 50%;
}

#luma-chat {
    display: none;
    position: fixed;
    right: 25px;
    bottom: 100px;
    width: 360px;
    height: 520px;
    background: white;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 10px 35px rgba(0,0,0,0.30);
    z-index: 999998;
    border: 1px solid #ddd;
}

.luma-header {
    height: 65px;
    background: #111;
    color: white;
    display: flex;
    align-items: center;
    padding: 10px 15px;
    gap: 10px;
}

.luma-header img {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    object-fit: cover;
}

.luma-info {
    flex: 1;
}

.luma-info h3 {
    margin: 0;
    font-size: 16px;
}

.luma-info p {
    margin: 3px 0 0;
    font-size: 11px;
    opacity: 0.8;
}

.luma-close {
    background: none;
    border: none;
    color: white;
    font-size: 25px;
    cursor: pointer;
}

#luma-messages {
    height: 390px;
    overflow-y: auto;
    padding: 15px;
    background: #f7f7f7;
}

.luma-message {
    background: white;
    padding: 10px;
    border-radius: 10px;
    margin-bottom: 10px;
    font-size: 13px;
}

.luma-input {
    height: 65px;
    display: flex;
    align-items: center;
    gap: 5px;
    padding: 10px;
    background: white;
    border-top: 1px solid #ddd;
}

#luma-input {
    flex: 1;
    height: 40px;
    border: 1px solid #ccc;
    border-radius: 20px;
    padding: 0 14px;
    outline: none;
}

.luma-input button {
    width: 40px;
    height: 40px;
    border: none;
    border-radius: 50%;
    background: #111;
    color: white;
    cursor: pointer;
}
</style>


<div id="luma-container">

    <!-- SMALL LUMA ICON -->

    <button id="luma-button"
            type="button"
            onclick="document.getElementById('luma-chat').style.display='block';">

        <img src="${pageContext.request.contextPath}/images/luma.jpg"
             alt="Luma">

    </button>


    <!-- LUMA CHAT -->

    <div id="luma-chat">

        <div class="luma-header">

            <img src="${pageContext.request.contextPath}/images/luma.jpg"
                 alt="Luma">

            <div class="luma-info">
                <h3>Luma</h3>
                <p>AI Shopping Assistant</p>
            </div>

            <button class="luma-close"
                    type="button"
                    onclick="document.getElementById('luma-chat').style.display='none';">
                ×
            </button>

        </div>


        <div id="luma-messages">

            <div class="luma-message">
                Hi! I'm Luma 👋
                <br>
                What are you looking for today?
            </div>

        </div>


        <div class="luma-input">

            <input id="luma-input"
                   type="text"
                   placeholder="Search products...">

            <button type="button"
                    onclick="startLumaVoice()">
                🎤
            </button>

            <button type="button"
                    onclick="lumaSearch()">
                ➤
            </button>

        </div>

    </div>

</div>

<script src="${pageContext.request.contextPath}/luma.js"></script>