<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopzilla.model.User" %>

<%
    String ctx = request.getContextPath();

    List<User> users =
            (List<User>) request.getAttribute("users");

    int totalUsers = users != null ? users.size() : 0;
    int buyerCount = 0;
    int sellerCount = 0;
    int adminCount = 0;

    if (users != null) {
        for (User user : users) {
            String role = user.getRole();

            if ("BUYER".equalsIgnoreCase(role)) {
                buyerCount++;
            } else if ("SELLER".equalsIgnoreCase(role)) {
                sellerCount++;
            } else if ("ADMIN".equalsIgnoreCase(role)) {
                adminCount++;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Users | Shopzilla Admin</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f6f6f6;
            color: #222;
            font-family: Arial, Helvetica, sans-serif;
        }

        /* NAVBAR */

        .navbar {
            height: 70px;
            background: #111;
            display: flex;
            align-items: center;
            padding: 0 45px;
        }

        .nav-container {
            width: 100%;
            display: flex;
            align-items: center;
        }

        .logo {
            color: white;
            text-decoration: none;
            font-size: 23px;
            font-weight: 800;
            letter-spacing: .5px;
        }

        .nav-links {
            display: flex;
            gap: 28px;
            margin-left: 55px;
        }

        .nav-links a {
            color: #bbb;
            text-decoration: none;
            font-size: 13px;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: white;
        }

        .nav-icons {
            margin-left: auto;
        }

        .nav-icons a {
            color: white;
            font-size: 17px;
            text-decoration: none;
        }

        /* PAGE */

        .users-page {
            max-width: 1450px;
            margin: auto;
            padding: 35px 30px 70px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .page-header h1 {
            margin: 0 0 7px;
            font-size: 32px;
        }

        .page-header p {
            margin: 0;
            color: #777;
            font-size: 14px;
        }

        .back-btn {
            text-decoration: none;
            background: #111;
            color: white;
            padding: 12px 18px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 600;
        }

        /* STATS */

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 20px;
        }

        .stat-icon {
            width: 45px;
            height: 45px;
            background: #f1f1f1;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 18px;
        }

        .stat-card span {
            display: block;
            color: #888;
            font-size: 12px;
            margin-bottom: 6px;
        }

        .stat-card strong {
            font-size: 26px;
        }

        /* PANEL */

        .users-panel {
            background: white;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            overflow: hidden;
        }

        .panel-top {
            padding: 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .panel-title h2 {
            margin: 0 0 5px;
            font-size: 17px;
        }

        .panel-title p {
            margin: 0;
            color: #888;
            font-size: 11px;
        }

        .search-box {
            width: 340px;
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 14px;
            top: 14px;
            color: #888;
        }

        .search-box input {
            width: 100%;
            height: 42px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            padding: 0 14px 0 40px;
            font-size: 12px;
        }

        /* FILTERS */

        .filters {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .filter-btn {
            background: white;
            border: 1px solid #ddd;
            padding: 9px 15px;
            border-radius: 5px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
        }

        .filter-btn.active,
        .filter-btn:hover {
            background: #111;
            color: white;
            border-color: #111;
        }

        /* TABLE */

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        thead {
            background: #fafafa;
        }

        th {
            text-align: left;
            padding: 15px 18px;
            font-size: 10px;
            color: #777;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 1px solid #eee;
        }

        td {
            padding: 16px 18px;
            border-bottom: 1px solid #eee;
            font-size: 12px;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #fafafa;
        }

        /* USER */

        .user-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #111;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .user-name {
            font-weight: 700;
            margin-bottom: 4px;
        }

        .user-email {
            color: #888;
            font-size: 10px;
        }

        /* ROLE */

        .role {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 9px;
            font-weight: 700;
        }

        .buyer {
            background: #eee;
            color: #333;
        }

        .seller {
            background: #e0e7ff;
            color: #3730a3;
        }

        .admin {
            background: #111;
            color: white;
        }

        /* ACTIONS */

        .actions {
            display: flex;
            gap: 6px;
        }

        .action-btn {
            width: 34px;
            height: 34px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            background: #111;
            color: white;
            border-color: #111;
        }

        /* EMPTY */

        .no-results {
            display: none;
            padding: 60px 20px;
            text-align: center;
        }

        .no-results i {
            font-size: 40px;
            color: #bbb;
            margin-bottom: 15px;
        }

        .no-results h3 {
            margin: 0 0 8px;
        }

        .no-results p {
            margin: 0;
            color: #888;
            font-size: 12px;
        }

        /* ROLE MODAL */

        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.55);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal {
            width: 100%;
            max-width: 430px;
            background: white;
            border-radius: 8px;
            padding: 28px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 19px;
        }

        .close-btn {
            border: 0;
            background: none;
            font-size: 22px;
            cursor: pointer;
            color: #777;
        }

        .modal-user {
            display: flex;
            align-items: center;
            gap: 12px;
            padding-bottom: 18px;
            border-bottom: 1px solid #eee;
            margin-bottom: 20px;
        }

        .modal-info strong {
            display: block;
            font-size: 13px;
            margin-bottom: 4px;
        }

        .modal-info span {
            color: #888;
            font-size: 10px;
        }

        .modal label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .modal select {
            width: 100%;
            height: 43px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0 12px;
            outline: none;
            margin-bottom: 20px;
        }

        .save-btn {
            width: 100%;
            height: 43px;
            background: #111;
            color: white;
            border: 0;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
        }

        @media(max-width: 1000px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media(max-width: 700px) {

            .navbar {
                padding: 0 18px;
            }

            .nav-links {
                display: none;
            }

            .users-page {
                padding: 25px 15px 50px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .panel-top {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                width: 100%;
            }
        }

        @media(max-width: 480px) {

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .filters {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }

            .filter-btn {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<header class="navbar">

    <div class="nav-container">

        <a href="<%= ctx %>/"
           class="logo">
            SHOPZILLA
        </a>

        <nav class="nav-links">

            <a href="<%= ctx %>/AdminServlet?action=dashboard">
                Dashboard
            </a>

            <a href="<%= ctx %>/AdminServlet?action=users"
               class="active">
                Users
            </a>

            <a href="<%= ctx %>/AdminServlet?action=listings">
                Products
            </a>

            <a href="<%= ctx %>/AdminServlet?action=orders">
                Orders
            </a>

        </nav>

        <div class="nav-icons">

            <a href="<%= ctx %>/LogoutServlet"
               title="Logout">

                <i class="fa-solid fa-right-from-bracket"></i>

            </a>

        </div>

    </div>

</header>


<main class="users-page">

    <div class="page-header">

        <div>

            <h1>Manage Users</h1>

            <p>
                View and manage registered Shopzilla accounts.
            </p>

        </div>

        <a href="<%= ctx %>/AdminServlet?action=dashboard"
           class="back-btn">

            <i class="fa-solid fa-arrow-left"></i>
            Dashboard

        </a>

    </div>


    <!-- REAL DATABASE STATS -->

    <section class="stats-grid">

        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-users"></i>
            </div>

            <span>Total Users</span>

            <strong><%= totalUsers %></strong>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-user"></i>
            </div>

            <span>Buyers</span>

            <strong><%= buyerCount %></strong>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-store"></i>
            </div>

            <span>Sellers</span>

            <strong><%= sellerCount %></strong>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                <i class="fa-solid fa-user-shield"></i>
            </div>

            <span>Admins</span>

            <strong><%= adminCount %></strong>

        </div>

    </section>


    <!-- USERS -->

    <section class="users-panel">

        <div class="panel-top">

            <div class="panel-title">

                <h2>All Users</h2>

                <p>
                    <%= totalUsers %> registered accounts
                </p>

            </div>


            <div class="search-box">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    id="userSearch"
                    placeholder="Search name, email or phone..."
                    onkeyup="filterUsers()">

            </div>

        </div>


        <div class="filters">

            <button class="filter-btn active"
                    onclick="setFilter(this,'all')">
                All
            </button>

            <button class="filter-btn"
                    onclick="setFilter(this,'BUYER')">
                Buyers
            </button>

            <button class="filter-btn"
                    onclick="setFilter(this,'SELLER')">
                Sellers
            </button>

            <button class="filter-btn"
                    onclick="setFilter(this,'ADMIN')">
                Admins
            </button>

        </div>


        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>ID</th>

                    <th>User</th>

                    <th>Phone</th>

                    <th>Role</th>

                    <th>Actions</th>

                </tr>

                </thead>


                <tbody id="usersTable">

                <%
                    if (users != null && !users.isEmpty()) {

                        for (User user : users) {

                            String name =
                                    user.getName() == null
                                            ? ""
                                            : user.getName();

                            String email =
                                    user.getEmail() == null
                                            ? ""
                                            : user.getEmail();

                            String phone =
                                    user.getPhone() == null
                                            ? "-"
                                            : user.getPhone();

                            String role =
                                    user.getRole() == null
                                            ? "UNKNOWN"
                                            : user.getRole().toUpperCase();

                            String roleClass = "buyer";

                            if ("SELLER".equals(role)) {
                                roleClass = "seller";
                            } else if ("ADMIN".equals(role)) {
                                roleClass = "admin";
                            }

                            String initials = "U";

                            if (!name.trim().isEmpty()) {

                                String[] parts =
                                        name.trim().split("\\s+");

                                initials =
                                        parts[0].substring(0, 1).toUpperCase();

                                if (parts.length > 1) {

                                    initials +=
                                            parts[parts.length - 1]
                                                    .substring(0, 1)
                                                    .toUpperCase();
                                }
                            }
                %>

                <tr class="user-row"
                    data-role="<%= role %>"
                    data-search="<%= name.toLowerCase() %> <%= email.toLowerCase() %> <%= phone.toLowerCase() %>">

                    <td>
                        <strong>
                            #<%= user.getId() %>
                        </strong>
                    </td>


                    <td>

                        <div class="user-cell">

                            <div class="avatar">
                                <%= initials %>
                            </div>

                            <div>

                                <div class="user-name">
                                    <%= name %>
                                </div>

                                <div class="user-email">
                                    <%= email %>
                                </div>

                            </div>

                        </div>

                    </td>


                    <td>
                        <%= phone %>
                    </td>


                    <td>

                        <span class="role <%= roleClass %>">
                            <%= role %>
                        </span>

                    </td>


                    <td>

                        <div class="actions">

                            <button
                                class="action-btn"
                                type="button"
                                onclick="openRoleModal(
                                    '<%= user.getId() %>',
                                    '<%= name.replace("'", "\\'") %>',
                                    '<%= email.replace("'", "\\'") %>',
                                    '<%= role %>'
                                )">

                                <i class="fa-solid fa-pen"></i>

                            </button>

                        </div>

                    </td>

                </tr>

                <%
                        }

                    } else {
                %>

                <tr>

                    <td colspan="5"
                        style="text-align:center;padding:50px;color:#888;">

                        No users found.

                    </td>

                </tr>

                <%
                    }
                %>

                </tbody>

            </table>


            <div class="no-results"
                 id="noResults">

                <i class="fa-solid fa-user-slash"></i>

                <h3>No users found</h3>

                <p>
                    Try another search or filter.
                </p>

            </div>

        </div>

    </section>

</main>


<!-- ROLE MODAL -->

<div class="modal-overlay"
     id="roleModal">

    <div class="modal">

        <div class="modal-header">

            <h3>Update User Role</h3>

            <button
                class="close-btn"
                type="button"
                onclick="closeRoleModal()">

                ×

            </button>

        </div>


        <div class="modal-user">

            <div class="avatar"
                 id="modalAvatar">
                U
            </div>

            <div class="modal-info">

                <strong id="modalName">
                    User
                </strong>

                <span id="modalEmail">
                    user@email.com
                </span>

            </div>

        </div>


        <form method="post"
              action="<%= ctx %>/AdminServlet">

            <input type="hidden"
                   name="action"
                   value="updateUserStatus">

            <input type="hidden"
                   name="userId"
                   id="modalUserId">

            <label>
                Account Role
            </label>

            <select name="status"
                    id="modalRole">

                <option value="BUYER">
                    Buyer
                </option>

                <option value="SELLER">
                    Seller
                </option>

                <option value="ADMIN">
                    Admin
                </option>

            </select>

            <button
                class="save-btn"
                type="submit">

                Save Changes

            </button>

        </form>

    </div>

</div>


<script>

    let currentFilter = "all";


    function setFilter(button, filter) {

        currentFilter = filter;

        document
            .querySelectorAll(".filter-btn")
            .forEach(function(btn) {

                btn.classList.remove("active");

            });

        button.classList.add("active");

        filterUsers();

    }


    function filterUsers() {

        const search =
            document
                .getElementById("userSearch")
                .value
                .toLowerCase()
                .trim();

        const rows =
            document.querySelectorAll(".user-row");

        let visible = 0;


        rows.forEach(function(row) {

            const role =
                row.getAttribute("data-role");

            const data =
                row.getAttribute("data-search");


            let roleMatch = true;


            if (currentFilter !== "all") {

                roleMatch =
                    role === currentFilter;

            }


            const searchMatch =
                search === ""
                || data.includes(search);


            if (roleMatch && searchMatch) {

                row.style.display = "table-row";

                visible++;

            } else {

                row.style.display = "none";

            }

        });


        const noResults =
            document.getElementById("noResults");

        noResults.style.display =
            visible === 0
                ? "block"
                : "none";

    }


    function openRoleModal(
        id,
        name,
        email,
        role
    ) {

        document
            .getElementById("modalUserId")
            .value = id;

        document
            .getElementById("modalName")
            .textContent = name;

        document
            .getElementById("modalEmail")
            .textContent = email;

        document
            .getElementById("modalRole")
            .value = role;

        const initials =
            name
                .split(" ")
                .map(function(word) {
                    return word.charAt(0);
                })
                .join("")
                .substring(0, 2)
                .toUpperCase();

        document
            .getElementById("modalAvatar")
            .textContent =
            initials || "U";


        document
            .getElementById("roleModal")
            .classList.add("show");

    }


    function closeRoleModal() {

        document
            .getElementById("roleModal")
            .classList.remove("show");

    }


    document
        .getElementById("roleModal")
        .addEventListener(
            "click",
            function(event) {

                if (event.target === this) {

                    closeRoleModal();

                }

            }
        );

</script>


</body>

</html>