package com.grepp.spring.app.model.userdetails.domain;

import java.util.Collection;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class AuthPrincipal extends User {

    public AuthPrincipal(String username, String password,
        Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    public static AuthPrincipal createPrincipal(com.grepp.spring.app.model.user.dto.User user,
        List<SimpleGrantedAuthority> authorities){
        return new AuthPrincipal(user.getId(), user.getPassword(), authorities);
    }
}
