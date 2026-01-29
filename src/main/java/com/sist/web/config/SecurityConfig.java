package com.sist.web.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.sist.web.security.LoginFailHandler;
import com.sist.web.security.LoginSuccessHandler;
import com.sist.web.service.CustomOAuth2UserService;
import com.sist.web.service.CustomUsersDetailService;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
	private final LoginSuccessHandler loginSuccessHandler;
	private final LoginFailHandler loginFailHander;
	private final CustomOAuth2UserService ouath2userService;
	private final CustomUsersDetailService userDetailService;
	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http
			.csrf(csrf -> csrf.disable())
			.authorizeHttpRequests(auth -> auth
				.requestMatchers("/","/vue","/boardjs","/css","/images","/userimages","/js","/noticejs","/style.css").permitAll()
				.requestMatchers("/admin").hasRole("ADMIN")
				.anyRequest().permitAll()
			)
			.oauth2Login(oauth2 -> oauth2
			.loginPage("/member/login")
			.userInfoEndpoint(userInfo -> userInfo
					.userService(ouath2userService))
			.successHandler(loginSuccessHandler)
			)
			
			.formLogin(form -> form
				.loginPage("/member/local_login")
				.loginProcessingUrl("/member/login_process")
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
				.deleteCookies("remember-me","JSESSIONID")
			);

		return http.build();
	}
	@Bean
	AuthenticationManager authenticationManager(HttpSecurity http,BCryptPasswordEncoder encoder) throws Exception{
		AuthenticationManagerBuilder builder=http.getSharedObject(AuthenticationManagerBuilder.class);
//		System.out.println("authenticationManager 호출");
		builder
			.userDetailsService(userDetailService)
			.passwordEncoder(passwordEncoder());
		return builder.build();	
	}
/*	@Bean
	JdbcUserDetailsManager jdbcUserDetailsManager() {
		JdbcUserDetailsManager manager = new JdbcUserDetailsManager(dataSource);
		manager.setUsersByUsernameQuery("SELECT username,password,state as enabled FROM user_table WHERE provider = 'local' AND username=?");
		manager.setAuthoritiesByUsernameQuery("SELECT username,role_name as authority FROM user_table a, user_roles b WHERE provider = 'local' AND username=? AND a.no = b.user_no");
		return manager;
	}*/
	@Bean
	PasswordEncoder passwordEncoder() {
//		System.out. println("passwordEncoder 호출");
		return new BCryptPasswordEncoder();
		
	}
}
