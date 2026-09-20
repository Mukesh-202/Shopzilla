<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
String orderId = request.getParameter("orderId");

List<Map<String, Object>> orders =
    (List<Map<String, Object>>) session.getAttribute("orders");

Map<String, Object> selectedOrder = null;

if (orders != null && orderId != null) {

    for (Map<String, Object> order : orders) {

        if (orderId.equals(String.valueOf(order.get("orderId")))) {
            selectedOrder = order;
            break;
        }
    }
}

String status = "PROCESSING";

if (selectedOrder != null && selectedOrder.get("status") != null) {
    status = selectedOrder.get("status").toString();
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Track Order | Shopzilla</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #f7f7f7;
    color: #111;
}

.container {
    max-width: 900px;
    margin: 60px auto;
    background: #fff;
    padding: 40px;
    border: 1px solid #ddd;
}

h1 {
    margin: 0;
    font-size: 30px;
}

.order-id {
    margin-top: 10px;
    color: #777;
    font-size: 14px;
}

/* TRACKING */

.tracking {
    display: flex;
    justify-content: space-between;
    margin: 60px 20px 40px;
    position: relative;
}

.tracking::before {
    content: "";
    position: absolute;
    top: 22px;
    left: 8%;
    right: 8%;
    height: 3px;
    background: #ddd;
    z-index: 0;
}

.step {
    position: relative;
    z-index: 1;
    text-align: center;
    width: 25%;
}

.circle {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    background: #ddd;
    color: #555;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: auto;
    font-weight: bold;
}

.circle.active {
    background: #111;
    color: #fff;
}

.step-title {
    margin-top: 12px;
    font-size: 12px;
    font-weight: bold;
}

.step-text {
    margin-top: 5px;
    font-size: 10px;
    color: #777;
}

.status-box {
    margin-top: 30px;
    padding: 20px;
    background: #f8f8f8;
    border: 1px solid #ddd;
}

.status-box strong {
    font-size: 15px;
}

.back-btn {
    display: inline-block;
    margin-top: 30px;
    padding: 13px 25px;
    background: #111;
    color: #fff;
    text-decoration: none;
    font-size: 12px;
    font-weight: bold;
}

.not-found {
    text-align: center;
    padding: 50px 20px;
}

@media (max-width: 600px) {

    .container {
        margin: 20px;
        padding: 25px 15px;
    }

    h1 {
        font-size: 24px;
    }

    .tracking {
        margin-left: 0;
        margin-right: 0;
    }

    .step-title {
        font-size: 9px;
    }

    .step-text {
        font-size: 8px;
    }

}

</style>

</head>

<body>

<div class="container">

<%
if (selectedOrder == null) {
%>

    <div class="not-found">

        <h1>Order Not Found</h1>

        <p>
            The selected order could not be found.
        </p>

        <a
            href="${pageContext.request.contextPath}/buyer/orders.jsp"
            class="back-btn">

            BACK TO MY ORDERS

        </a>

    </div>

<%
} else {
%>

    <h1>Track Your Order</h1>

    <div class="order-id">
        Order #<%= orderId %>
    </div>


    <div class="tracking">

        <!-- STEP 1 -->

        <div class="step">

            <div class="circle active">
                ✓
            </div>

            <div class="step-title">
                Order Placed
            </div>

            <div class="step-text">
                Order received
            </div>

        </div>


        <!-- STEP 2 -->

        <div class="step">

            <div class="circle active">
                ✓
            </div>

            <div class="step-title">
                Processing
            </div>

            <div class="step-text">
                Preparing order
            </div>

        </div>


        <!-- STEP 3 -->

        <div class="step">

            <div class="circle">
                3
            </div>

            <div class="step-title">
                Shipped
            </div>

            <div class="step-text">
                On the way
            </div>

        </div>


        <!-- STEP 4 -->

        <div class="step">

            <div class="circle">
                4
            </div>

            <div class="step-title">
                Delivered
            </div>

            <div class="step-text">
                Delivered
            </div>

        </div>

    </div>


    <div class="status-box">

        <strong>
            Current Status:
        </strong>

        <span>
            <%= status %>
        </span>

    </div>


    <a
        href="${pageContext.request.contextPath}/buyer/orders.jsp"
        class="back-btn">

        ← BACK TO MY ORDERS

    </a>

<%
}
%>

</div>

</body>

</html>