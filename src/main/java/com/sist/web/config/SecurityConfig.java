package com.sist.web.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import com.sist.web.security.LoginFailHandler;
import com.sist.web.security.LoginSuccessHandler;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
	private final LoginSuccessHandler loginSuccessHandler;
	private final LoginFailHandler loginFailHander;
	private final DataSource dataSource;
	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http
			.csrf(csrf -> csrf.disable())
			.authorizeHttpRequests(auth -> auth
				.requestMatchers("/").permitAll()
				.anyRequest().permitAll()
			)
			.formLogin(form -> form
				.loginPage("/member/local_login")
				.loginProcessingUrl("/member/login_proccess")
				.usernameParameter("username")
				.passwordParameter("password")
				.successHandler(loginSuccessHandler)
				.failureHandler(loginFailHander)
				.permitAll()
			)
			.rememberMe(remember -> remember
				.key("refresh-remember-key")
				.rememberMeParameter("remember-me")
				.tokenValiditySeconds(60*60*24*7)
			)
			.logout(logout -> logout
				.logoutUrl("/member/logout")
				.logoutSuccessUrl("/")
				.invalidateHttpSession(true)
				.deleteCookies("remember-me","JSEESIONID")
			);
		
			
		
		return http.build();
	}
	@Bean
	AuthenticationManager authenticationManager(HttpSecurity http,BCryptPasswordEncoder encoder) throws Exception{
		AuthenticationManagerBuilder builder=http.getSharedObject(AuthenticationManagerBuilder.class);
		builder
			.userDetailsService(jdbcUserDetailsManager())
			.passwordEncoder(passwordEncoder());
		return builder.build();	
	}
	@Bean
	JdbcUserDetailsManager jdbcUserDetailsManager() {
		JdbcUserDetailsManager manager = new JdbcUserDetailsManager(dataSource);
		manager.setUsersByUsernameQuery("SELECT username,password,status as enabled FROM user_table WHERE provider = 'local' AND username=?");
		manager.setAuthoritiesByUsernameQuery("SELECT username,role_name as authority FROM user_table a, user_roles b WHERE provider = 'local' AND username=? AND a.no = b.user_no");
		return manager;
	}
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
		
	}
}
