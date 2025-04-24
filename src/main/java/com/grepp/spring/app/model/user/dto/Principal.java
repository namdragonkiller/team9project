package com.grepp.spring.app.model.user.dto;

import com.grepp.spring.app.model.userdetails.role.Role;
import java.util.List;
import org.apache.ibatis.type.Alias;

@Alias("USER_PRINCIPAL")
public record Principal(
    String id,
    List<Role> Roles


) {
    public static final Principal ANONYMOUS = new Principal(
        "anonymous",
        List.of(Role.ANONYMOUS));



}
