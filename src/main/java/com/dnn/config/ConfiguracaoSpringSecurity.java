/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dnn.config;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
import org.springframework.stereotype.Component;

/**
 *
 * @author DeividNn
 */
//AbstractSecurityWebApplicationInitializer carrega o  springSecurityFilterChain automaticamente
//
public class ConfiguracaoSpringSecurity extends AbstractSecurityWebApplicationInitializer {

    @Configuration
    @EnableWebSecurity
    public static class Configuracao extends WebSecurityConfigurerAdapter {

        @Autowired
        Sucesso sucesso;

        @Autowired
        public void usuariosPadrao(AuthenticationManagerBuilder auth) throws Exception {

            auth.inMemoryAuthentication().withUser("admin").password("admin").roles("ADMIN");
            auth.inMemoryAuthentication().withUser("user").password("user").roles("USER");
            auth.inMemoryAuthentication().withUser("user2").password("user2").roles("USER").disabled(true);
        }

        @Override
        public void configure(HttpSecurity http) throws Exception {
            http.authorizeRequests()
                    .antMatchers("/", "/inicio").permitAll()
                    .antMatchers("/admin/**").access("hasRole('ADMIN')")
                    .antMatchers("/usuario/**").access("hasRole('USER') or hasRole('ADMIN')")
                    .and().formLogin().loginPage("/acesso")
                    .usernameParameter("usuario").passwordParameter("senha")
                    .successHandler(sucesso)
                    .and().csrf()
                    .and().exceptionHandling().accessDeniedPage("/acessoNegado");
        }
    }

    //##########################################################################
    @Component
    public static class Sucesso extends SimpleUrlAuthenticationSuccessHandler {

        private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

        @Override
        protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
                throws IOException {
            String targetUrl = determineTargetUrl(authentication);

            if (response.isCommitted()) {
                System.out.println("Can't redirect");
                return;
            }

            redirectStrategy.sendRedirect(request, response, targetUrl);
        }

        /*
         * This method extracts the roles of currently logged-in user and returns
         * appropriate URL according to his/her role.
         */
        protected String determineTargetUrl(Authentication authentication) {
            String url = "";

            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

            List<String> roles = new ArrayList<>();

            for (GrantedAuthority a : authorities) {
                roles.add(a.getAuthority());
            }

            if (isAdmin(roles)) {
                url = "/admin";
            } else if (isUser(roles)) {
                url = "/usuario";
            } else {
                url = "/accessNegado";
            }

            return url;
        }

        private boolean isUser(List<String> roles) {
            return roles.contains("ROLE_USER") || roles.contains("ROLE_ADMIN");
        }

        private boolean isAdmin(List<String> roles) {
            return roles.contains("ROLE_ADMIN");
        }

        @Override
        public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
            this.redirectStrategy = redirectStrategy;
        }

        @Override
        protected RedirectStrategy getRedirectStrategy() {
            return redirectStrategy;
        }
    }

}
