package com.example.ecommerce.dto;

public class AuthResponse {
    private final String tokenType = "Bearer";
    private final String accessToken;
    private final Long userId;
    private final String name;
    private final String email;
    private final String role;

    public AuthResponse(String accessToken, Long userId, String name, String email, String role) {
        this.accessToken = accessToken;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.role = role;
    }

    public String getTokenType() { return tokenType; }
    public String getAccessToken() { return accessToken; }
    public Long getUserId() { return userId; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getRole() { return role; }
}
