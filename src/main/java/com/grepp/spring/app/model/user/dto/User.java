package com.grepp.spring.app.model.user.dto;

import com.grepp.spring.app.model.userdetails.role.Role;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("User")
public class User {

    private String id;
    private String password;
    private String email;
    private String tel;
    private String address;
    private String addressNumber;
    private Role role;

}
