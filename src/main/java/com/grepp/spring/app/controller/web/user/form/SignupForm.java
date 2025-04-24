package com.grepp.spring.app.controller.web.user.form;

import com.grepp.spring.app.model.user.dto.User;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data

public class SignupForm {

    @NotBlank
    private String id;
    @NotBlank
    @Size(min = 4, max = 10)
    private String password;
    @NotBlank
    @Email
    private String email;
    @NotBlank
    @Size(min = 8, max = 14)
    private String tel;
    @NotBlank
    private String address;
    @NotBlank
    private String addressNumber;

    public User toDto(){
        User user = new User();
        user.setId(id);
        user.setPassword(password);
        user.setEmail(email);
        user.setTel(tel);
        user.setAddress(address);
        user.setAddressNumber(addressNumber);
        return user;
    }

}
