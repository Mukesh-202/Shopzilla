<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Shopzilla</title>

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
            min-height: 100vh;
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
                    rgba(0,0,0,0.55),
                    rgba(0,0,0,0.55)
                ),
                url("https://images.unsplash.com/photo-1445205170230-053b83016050?auto=format&fit=crop&w=1800&q=85")
                center/cover no-repeat;
        }

        .auth-container {
            width: 100%;
            max-width: 440px;
            background: #ffffff;
            padding: 42px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.25);
        }

        .auth-logo {
            text-align: center;
            margin-bottom: 8px;
            font-size: 30px;
            font-weight: 900;
            letter-spacing: -1px;
            text-transform: uppercase;
            color: #111111;
        }

        .auth-logo span {
            color: #d4145a;
        }

        .auth-subtitle {
            text-align: center;
            color: #777777;
            font-size: 13px;
            margin-bottom: 30px;
        }

        .auth-title {
            margin: 0 0 25px;
            text-align: center;
            font-size: 24px;
            font-weight: 800;
            color: #111111;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 12px;
            font-weight: 700;
            color: #333333;
            text-transform: uppercase;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #888888;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            height: 48px;
            padding: 0 15px 0 42px;
            border: 1px solid #dddddd;
            outline: none;
            font-size: 14px;
            transition: border-color 0.2s ease;
        }

        .form-control:focus {
            border-color: #111111;
        }

        .password-toggle {
            position: absolute;
            right: 13px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            cursor: pointer;
            color: #777777;
        }

        .auth-options {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin: 5px 0 22px;
            font-size: 12px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #666666;
        }

        .forgot-password {
            color: #111111;
            text-decoration: none;
            font-weight: 600;
        }

        .forgot-password:hover {
            color: #d4145a;
        }

        .login-btn {
            width: 100%;
            height: 50px;
            border: none;
            background: #111111;
            color: #ffffff;
            cursor: pointer;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            transition: background 0.25s ease;
        }

        .login-btn:hover {
            background: #d4145a;
        }

        .auth-divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 25px 0;
            color: #999999;
            font-size: 11px;
        }

        .auth-divider::before,
        .auth-divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: #eeeeee;
        }

        .register-text {
            text-align: center;
            color: #777777;
            font-size: 13px;
        }

        .register-text a {
            color: #111111;
            font-weight: 800;
            text-decoration: none;
        }

        .register-text a:hover {
            color: #d4145a;
        }

        .back-home {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #777777;
            text-decoration: none;
            font-size: 12px;
        }

        .back-home:hover {
            color: #111111;
        }

        .error-message {
            margin-bottom: 18px;
            padding: 12px;
            background: #fff1f1;
            border: 1px solid #ffd5d5;
            color: #c62828;
            font-size: 12px;
            text-align: center;
        }

        .success-message {
            margin-bottom: 18px;
            padding: 12px;
            background: #effaf2;
            border: 1px solid #ccebd3;
            color: #218838;
            font-size: 12px;
            text-align: center;
        }

        @media (max-width: 500px) {

            .auth-container {
                padding: 30px 22px;
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
            Welcome Back
        </h1>

        <% if (request.getParameter("error") != null) { %>

            <div class="error-message">
                Invalid email or password.
                Please try again.
            </div>

        <% } %>

        <% if (request.getParameter("success") != null) { %>

            <div class="success-message">
                Registration successful.
                Please login to continue.
            </div>

        <% } %>

        <form action="${pageContext.request.contextPath}/LoginServlet"
              method="post">

            <div class="form-group">

                <label for="email">
                    Email Address
                </label>

                <div class="input-wrapper">

                    <i class="fa-solid fa-envelope"></i>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        class="form-control"
                        placeholder="Enter your email"
                        required
                        autocomplete="email">

                </div>

            </div>


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
                        placeholder="Enter your password"
                        required
                        autocomplete="current-password">

                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword()"
                        aria-label="Show password">

                        <i class="fa-regular fa-eye"
                           id="passwordIcon"></i>

                    </button>

                </div>

            </div>


            <div class="auth-options">

                <label class="remember-me">

                    <input
                        type="checkbox"
                        name="remember">

                    Remember me

                </label>

                <a href="#"
                   class="forgot-password">
                    Forgot Password?
                </a>

            </div>


            <button
                type="submit"
                class="login-btn">

                <i class="fa-solid fa-right-to-bracket"></i>
                &nbsp; Login

            </button>

        </form>


        <div class="auth-divider">
            OR
        </div>


        <div class="register-text">

            Don't have an account?

            <a href="${pageContext.request.contextPath}/auth/register.jsp">
                Create Account
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

    function togglePassword() {

        const password =
            document.getElementById("password");

        const icon =
            document.getElementById("passwordIcon");

        if (password.type === "password") {

            password.type = "text";

            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");

        } else {

            password.type = "password";

            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");

        }

    }

</script>

</body>

</html>