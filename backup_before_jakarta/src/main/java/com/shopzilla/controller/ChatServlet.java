package com.shopzilla.controller;
import com.shopzilla.chatbot.ChatProvider;
import com.shopzilla.chatbot.GeminiChatProvider;
import com.shopzilla.chatbot.MockChatProvider;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
public class ChatServlet extends HttpServlet {
private ChatProvider chatProvider;

@Override
public void init() {

    String apiKey =
            System.getenv("GEMINI_API_KEY");

    if (apiKey != null
            && !apiKey.trim().isEmpty()) {

        chatProvider =
                new GeminiChatProvider();

    } else {

        chatProvider =
                new MockChatProvider();
    }
}

@Override
protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");

    response.setContentType(
            "application/json"
    );

    response.setCharacterEncoding(
            "UTF-8"
    );

    String message =
            request.getParameter("message");

    if (message == null
            || message.trim().isEmpty()) {

        response.setStatus(
                HttpServletResponse.SC_BAD_REQUEST
        );

        response.getWriter().write(
                "{\"success\":false,\"message\":\"Please enter a message.\"}"
        );

        return;
    }

    if (message.length() > 1000) {

        response.setStatus(
                HttpServletResponse.SC_BAD_REQUEST
        );

        response.getWriter().write(
                "{\"success\":false,\"message\":\"Message is too long.\"}"
        );

        return;
    }

    try {

        String reply =
                chatProvider.getResponse(
                        message.trim()
                );

        response.getWriter().write(
                "{"
                        + "\"success\":true,"
                        + "\"reply\":\""
                        + escapeJson(reply)
                        + "\""
                        + "}"
        );

    } catch (Exception e) {

        getServletContext().log(
                "Chatbot error",
                e
        );

        response.setStatus(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR
        );

        response.getWriter().write(
                "{\"success\":false,\"message\":\"AI assistant is temporarily unavailable.\"}"
        );
    }
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    response.setContentType(
            "application/json"
    );

    response.setCharacterEncoding(
            "UTF-8"
    );

    response.getWriter().write(
            "{"
                    + "\"success\":true,"
                    + "\"message\":\"Shopzilla AI Assistant is ready.\""
                    + "}"
    );
}

private String escapeJson(String value) {

    if (value == null) {
        return "";
    }

    return value
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "\\r")
            .replace("\n", "\\n")
            .replace("\t", "\\t");
}
}