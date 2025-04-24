package com.grepp.spring.app.model.userdetails.role;

import org.apache.ibatis.type.Alias;

@Alias("USER_ROLE")
public enum Role {
    ANONYMOUS,
    ROLE_USER,
    ROLE_ADMIN
}
