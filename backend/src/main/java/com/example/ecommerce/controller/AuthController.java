package com.example.ecommerce.controller;

import com.example.ecommerce.dto.AuthResponse;
import com.example.ecommerce.dto.LoginRequest;
import com.example.ecommerce.dto.RegisterRequest;
import com.example.ecommerce.entity.UserEntity;
import com.example.ecommerce.repository.UserRepository;
import com.example.ecommerce.security.JwtService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public AuthController(UserRepository userRepository, PasswordEncoder passwordEncoder,
                          AuthenticationManager authenticationManager, JwtService jwtService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("Email is already registered");
        }

        UserEntity user = new UserEntity();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setPhone(request.getPhone());
        user.setAddress(request.getAddress());
        // Public registration must never allow the client to choose ADMIN.
        user.setRole("user");
        UserEntity saved = userRepository.save(user);
        UserDetails principal = org.springframework.security.core.userdetails.User
                .withUsername(saved.getEmail())
                .password(saved.getPassword())
                .roles("USER")
                .build();

        String token = jwtService.generateToken(principal);
        return ResponseEntity.status(HttpStatus.CREATED).body(
                new AuthResponse(token, saved.getId(), saved.getName(), saved.getEmail(), saved.getRole()));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));
        UserDetails principal = (UserDetails) authentication.getPrincipal();
        UserEntity user = userRepository.findByEmail(request.getEmail()).orElseThrow();
        String token = jwtService.generateToken(principal);
        return ResponseEntity.ok(
                new AuthResponse(token, user.getId(), user.getName(), user.getEmail(), user.getRole()));
    }
}
