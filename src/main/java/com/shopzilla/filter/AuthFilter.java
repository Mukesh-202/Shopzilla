package com.shopzilla.filter;

import com.shopzilla.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/buyer/*",
        "/seller/*",
        "/admin/*",
        "/AdminServlet"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        String requestURI =
                httpRequest.getRequestURI();

        String contextPath =
                httpRequest.getContextPath();

        String path =
                requestURI.substring(contextPath.length());


        /*
         * ==========================================
         * GET CURRENT USER FROM SESSION
         * ==========================================
         */

        HttpSession session =
                httpRequest.getSession(false);

        User user = null;

        if (session != null) {

            Object object =
                    session.getAttribute("user");

            if (object instanceof User) {
                user = (User) object;
            }
        }


        /*
         * ==========================================
         * LOGIN CHECK
         * ==========================================
         */

        if (user == null) {

            httpResponse.sendRedirect(
                    contextPath
                            + "/auth/login.jsp"
            );

            return;
        }


        /*
         * ==========================================
         * ADMIN SERVLET
         * ==========================================
         *
         * /AdminServlet must ONLY be accessed
         * by ADMIN users.
         */

        if (path.equals("/AdminServlet")
                || path.startsWith("/AdminServlet/")) {

            if (!"ADMIN".equalsIgnoreCase(
                    user.getRole())) {

                httpResponse.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "Admin access required."
                );

                return;
            }

            chain.doFilter(
                    request,
                    response
            );

            return;
        }


        /*
         * ==========================================
         * ADMIN JSP PAGES
         * ==========================================
         */

        if (path.startsWith("/admin/")) {

            if (!"ADMIN".equalsIgnoreCase(
                    user.getRole())) {

                httpResponse.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "Admin access required."
                );

                return;
            }

            chain.doFilter(
                    request,
                    response
            );

            return;
        }


        /*
         * ==========================================
         * SELLER PAGES
         * ==========================================
         */

        if (path.startsWith("/seller/")) {

            if (!"SELLER".equalsIgnoreCase(
                    user.getRole())) {

                httpResponse.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "Seller access required."
                );

                return;
            }

            chain.doFilter(
                    request,
                    response
            );

            return;
        }


        /*
         * ==========================================
         * BUYER PAGES
         * ==========================================
         */

        if (path.startsWith("/buyer/")) {

            if (!"BUYER".equalsIgnoreCase(
                    user.getRole())) {

                httpResponse.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "Buyer access required."
                );

                return;
            }

            chain.doFilter(
                    request,
                    response
            );

            return;
        }


        /*
         * ==========================================
         * OTHER REQUESTS
         * ==========================================
         */

        chain.doFilter(
                request,
                response
        );
    }
}
