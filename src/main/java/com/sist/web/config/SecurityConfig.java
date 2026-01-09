package com.sist.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor

public class SecurityConfig {
	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http
			.csrf(csrf -> csrf.disable())
			.authorizeHttpRequests(auth -> auth
				.requestMatchers("/").permitAll()
				.anyRequest().permitAll()
			)
			.formLogin(form -> form
				.loginPage("/member/login")
				.loginProcessingUrl("/member/login_ok")
				.defaultSuccessUrl("/",true)
			)
			.logout(logout -> logout
				.logoutSuccessUrl("/")
			);
		
		
		
		return http.build();
	}
	@Bean
	PasswordEncoder passwordEncdoer() {
		return new BCryptPasswordEncoder();
		
	}
}
