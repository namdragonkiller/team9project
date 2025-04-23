package com.grepp.spring.infra.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import static org.springframework.http.HttpMethod.GET;
import static org.springframework.http.HttpMethod.POST;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    @Value("${remember-me.key}")
    private String rememberMeKey;

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class)
            .build();
    }

    @Bean
    public AuthenticationSuccessHandler successHandler() {

        return new AuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request,
                HttpServletResponse response, Authentication authentication)
                throws IOException, ServletException {

                boolean isAdmin = authentication.getAuthorities()
                    .stream()
                    .anyMatch(authority ->
                        authority.getAuthority().equals("ROLE_ADMIN"));

                if (isAdmin) {
                    response.sendRedirect("/admin");
                    return;
                }

                response.sendRedirect("/");
            }
        };
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // * : 1 depth 아래 모든 경로
        // ** : 모든 depth 의 모든 경로
        // // Security Config 에는 인증과 관련된 설정만 지정 (PermitAll or Authenticated)
        http
            .authorizeHttpRequests((requests) -> requests
                .requestMatchers(GET, "/", "/assets/**", "/download/**").permitAll()
                .requestMatchers(GET, "/book/list").permitAll()
                .requestMatchers(GET, "/api/book/list").permitAll()
                .requestMatchers(GET, "/api/member/exists/*").permitAll()
                .requestMatchers(GET, "/member/signup").permitAll()
                .requestMatchers(GET, "/member/signin").permitAll()
                .requestMatchers(POST, "/member/signin", "/member/signup").permitAll()
                .anyRequest().authenticated()
            )
            .formLogin((form) -> form
                .loginPage("/member/signin")
                .usernameParameter("userId")
                .loginProcessingUrl("/member/signin")
                .defaultSuccessUrl("/")
                .successHandler(successHandler())
                .permitAll()
            )
            .rememberMe(rememberMe -> rememberMe.key(rememberMeKey))
            .logout((logout) -> logout.permitAll());

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}
