<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Account | Shopzilla</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f7f7f7;
        }

        .auth-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;

            background:
                linear-gradient(
                    rgba(0,0,0,0.58),
                    rgba(0,0,0,0.58)
                ),
                url("https://images.unsplash.com/photo-1445205170230-053b83016050?auto=format&fit=crop&w=1800&q=85")
                center/cover no-repeat;
        }

        .auth-container {
            width: 100%;
            max-width: 500px;
            background: #ffffff;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.25);
        }

        .auth-logo {
            text-align: center;
            font-size: 30px;
            font-weight: 900;
            letter-spacing: -1px;
            text-transform: uppercase;
            color: #111;
        }

        .auth-logo span {
            color: #d4145a;
        }

        .auth-subtitle {
            text-align: center;
            margin-top: 7px;
            margin-bottom: 28px;
            color: #777;
            font-size: 13px;
        }

        .auth-title {
            margin: 0 0 25px;
            text-align: center;
            font-size: 24px;
            font-weight: 800;
            color: #111;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 17px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            color: #333;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper > i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-size: 13px;
        }

        .form-control {
            width: 100%;
            height: 46px;
            padding: 0 14px 0 40px;
            border: 1px solid #ddd;
            outline: none;
            font-size: 13px;
            color: #222;
        }

        .form-control:focus {
            border-color: #111;
        }

        select.form-control {
            cursor: pointer;
            background: #fff;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            color: #777;
            cursor: pointer;
        }

        .password-toggle:hover {
            color: #111;
        }

        .password-strength {
            display: none;
            margin-top: 6px;
            font-size: 10px;
            font-weight: 600;
        }

        .terms {
            display: flex;
            align-items: flex-start;
            gap: 8px;
            margin: 5px 0 20px;
            color: #666;
            font-size: 11px;
            line-height: 1.5;
        }

        .terms input {
            margin-top: 2px;
        }

        .terms a {
            color: #111;
            font-weight: 700;
            text-decoration: none;
        }

        .terms a:hover {
            color: #d4145a;
        }

        .register-btn {
            width: 100%;
            height: 50px;
            border: none;
            background: #111;
            color: #fff;
            cursor: pointer;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            transition: background 0.25s ease;
        }

        .register-btn:hover {
            background: #d4145a;
        }

        .auth-divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 23px 0;
            color: #999;
            font-size: 10px;
        }

        .auth-divider::before,
        .auth-divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: #eee;
        }

        .login-text {
            text-align: center;
            color: #777;
            font-size: 13px;
        }

        .login-text a {
            color: #111;
            font-weight: 800;
            text-decoration: none;
        }

        .login-text a:hover {
            color: #d4145a;
        }

        .back-home {
            display: block;
            margin-top: 18px;
            text-align: center;
            color: #777;
            text-decoration: none;
            font-size: 12px;
        }

        .back-home:hover {
            color: #111;
        }

        .error-message {
            margin-bottom: 18px;
            padding: 11px;
            background: #fff1f1;
            border: 1px solid #ffd5d5;
            color: #c62828;
            font-size: 12px;
            text-align: center;
        }

        @media (max-width: 550px) {

            .auth-container {
                padding: 30px 22px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .auth-logo {
                font-size: 26px;
            }

            .auth-title {
                font-size: 21px;
            }
        }

    </style>

</head>

<body>

<div class="auth-page">

    <div class="auth-container">

        <div class="auth-logo">
            SHOP<span>ZILLA</span>
        </div>

        <div class="auth-subtitle">
            Fashion. Lifestyle. Everything you love.
        </div>

        <h1 class="auth-title">
            Create Your Account
        </h1>

        <% if (request.getParameter("error") != null) { %>

            <div class="error-message">
                Registration failed.
                Please check your details and try again.
            </div>

        <% } %>


        <form
            action="${pageContext.request.contextPath}/RegisterServlet"
            method="post"
            onsubmit="return validateRegistration()">

            <!-- NAME -->

            <div class="form-group">

                <label for="name">
                    Full Name
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-user"></i>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        class="form-control"
                        placeholder="Enter your full name"
                        required
                        minlength="2"
                        maxlength="100"
                        autocomplete="name">

                </div>

            </div>


            <!-- EMAIL + PHONE -->

            <div class="form-row">

                <div class="form-group">

                    <label for="email">
                        Email
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-solid fa-envelope"></i>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            class="form-control"
                            placeholder="Email address"
                            required
                            maxlength="120"
                            autocomplete="email">

                    </div>

                </div>


                <div class="form-group">

                    <label for="phone">
                        Phone
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-solid fa-phone"></i>

                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            class="form-control"
                            placeholder="Phone number"
                            pattern="[0-9]{10}"
                            maxlength="10"
                            required
                            autocomplete="tel">

                    </div>

                </div>

            </div>


            <!-- ROLE -->

            <div class="form-group">

                <label for="role">
                    Account Type
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-users"></i>

                    <select
                        id="role"
                        name="role"
                        class="form-control"
                        required>

                        <option value="">
                            Select account type
                        </option>

                        <option value="BUYER">
                            Buyer
                        </option>

                        <option value="SELLER">
                            Seller
                        </option>

                    </select>

                </div>

            </div>


            <!-- PASSWORD -->

            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-lock"></i>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="form-control"
                        placeholder="Create a password"
                        required
                        minlength="8"
                        maxlength="72"
                        autocomplete="new-password"
                        oninput="checkPasswordStrength()">

                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword('password','passwordIcon')">

                        <i
                            class="fa-regular fa-eye"
                            id="passwordIcon">
                        </i>

                    </button>

                </div>

                <div
                    id="passwordStrength"
                    class="password-strength">
                </div>

            </div>


            <!-- CONFIRM PASSWORD -->

            <div class="form-group">

                <label for="confirmPassword">
                    Confirm Password
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-shield-halved"></i>

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        class="form-control"
                        placeholder="Confirm your password"
                        required
                        minlength="8"
                        maxlength="72"
                        autocomplete="new-password">

                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword('confirmPassword','confirmIcon')">

                        <i
                            class="fa-regular fa-eye"
                            id="confirmIcon">
                        </i>

                    </button>

                </div>

            </div>


            <!-- TERMS -->

            <label class="terms">

                <input
                    type="checkbox"
                    id="terms"
                    name="terms"
                    required>

                <span>
                    I agree to the
                    <a href="#">Terms & Conditions</a>
                    and
                    <a href="#">Privacy Policy</a>.
                </span>

            </label>


            <!-- REGISTER -->

            <button
                type="submit"
                class="register-btn">

                <i class="fa-solid fa-user-plus"></i>
                &nbsp; Create Account

            </button>

        </form>


        <div class="auth-divider">
            OR
        </div>


        <div class="login-text">

            Already have an account?

            <a
                href="${pageContext.request.contextPath}/auth/login.jsp">

                Login

            </a>

        </div>


        <a
            href="${pageContext.request.contextPath}/"
            class="back-home">

            <i class="fa-solid fa-arrow-left"></i>
            &nbsp; Back to Shopzilla

        </a>

    </div>

</div>


<script>

    function togglePassword(inputId, iconId) {

        const input =
            document.getElementById(inputId);

        const icon =
            document.getElementById(iconId);

        if (input.type === "password") {

            input.type = "text";

            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");

        } else {

            input.type = "password";

            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");

        }

    }


    function checkPasswordStrength() {

        const password =
            document.getElementById("password").value;

        const strength =
            document.getElementById("passwordStrength");

        if (password.length === 0) {

            strength.style.display = "none";
            return;

        }

        strength.style.display = "block";

        let score = 0;

        if (password.length >= 8) score++;

        if (/[A-Z]/.test(password)) score++;

        if (/[a-z]/.test(password)) score++;

        if (/[0-9]/.test(password)) score++;

        if (/[^A-Za-z0-9]/.test(password)) score++;

        if (score <= 2) {

            strength.textContent =
                "Password strength: Weak";

        } else if (score <= 3) {

            strength.textContent =
                "Password strength: Medium";

        } else {

            strength.textContent =
                "Password strength: Strong";

        }

    }


    function validateRegistration() {

        const password =
            document.getElementById("password").value;

        const confirmPassword =
            document.getElementById("confirmPassword").value;

        if (password !== confirmPassword) {

            alert("Passwords do not match.");

            document
                .getElementById("confirmPassword")
                .focus();

            return false;

        }

        if (password.length < 8) {

            alert(
                "Password must contain at least 8 characters."
            );

            return false;

        }

        return true;

    }

</script>

</body>

</html>