
package com.shopzilla.chatbot;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
public class GeminiChatProvider implements ChatProvider {
private final String apiKey;
private final HttpClient httpClient;

public GeminiChatProvider() {
    this.apiKey = System.getenv("GEMINI_API_KEY");
    this.httpClient = HttpClient.newHttpClient();
}

@Override
public String getResponse(String message) {

    if (message == null || message.trim().isEmpty()) {
        return "Please enter a message.";
    }

    if (apiKey == null || apiKey.trim().isEmpty()) {
        return "AI assistant is currently unavailable. Please try again later.";
    }

    try {

        String safeMessage =
                escapeJson(message.trim());

        String requestBody =
                "{"
                        + "\"contents\":["
                        + "{"
                        + "\"parts\":["
                        + "{"
                        + "\"text\":\"You are Shopzilla's helpful e-commerce assistant. "
                        + "Answer briefly and clearly about products, shopping, cart, orders, "
                        + "delivery, payments and account help. User message: "
                        + safeMessage
                        + "\"}"
                        + "]"
                        + "}"
                        + "]"
                        + "}";

        String url =
                "https://generativelanguage.googleapis.com/v1beta/models/"
                        + "gemini-2.0-flash:generateContent?key="
                        + apiKey;

        HttpRequest request =
                HttpRequest.newBuilder()
                        .uri(URI.create(url))
                        .header(
                                "Content-Type",
                                "application/json"
                        )
                        .timeout(
                                java.time.Duration.ofSeconds(15)
                        )
                        .POST(
                                HttpRequest.BodyPublishers.ofString(
                                        requestBody,
                                        StandardCharsets.UTF_8
                                )
                        )
                        .build();

        HttpResponse<String> response =
                httpClient.send(
                        request,
                        HttpResponse.BodyHandlers.ofString(
                                StandardCharsets.UTF_8
                        )
                );

        if (response.statusCode() < 200
                || response.statusCode() >= 300) {

            return "AI assistant is temporarily unavailable.";
        }

        String result =
                extractText(response.body());

        if (result == null
                || result.trim().isEmpty()) {

            return "Sorry, I couldn't generate a response.";
        }

        return result;

    } catch (Exception e) {

        return "AI assistant is temporarily unavailable. Please try again.";
    }
}

private String extractText(String json) {

    String marker = "\"text\":\"";

    int start = json.indexOf(marker);

    if (start == -1) {
        return null;
    }

    start += marker.length();

    StringBuilder result =
            new StringBuilder();

    boolean escaped = false;

    for (int i = start; i < json.length(); i++) {

        char c = json.charAt(i);

        if (escaped) {

            if (c == 'n') {
                result.append('\n');

            } else if (c == 'r') {
                result.append('\r');

            } else if (c == 't') {
                result.append('\t');

            } else {
                result.append(c);
            }

            escaped = false;

        } else if (c == '\\') {

            escaped = true;

        } else if (c == '"') {

            break;

        } else {

            result.append(c);
        }
    }

    return result.toString();
}

private String escapeJson(String value) {

    return value
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "\\r")
            .replace("\n", "\\n")
            .replace("\t", "\\t");
}
}