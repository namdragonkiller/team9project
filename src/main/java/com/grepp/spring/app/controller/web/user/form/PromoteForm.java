package com.grepp.spring.app.controller.web.user.form;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class PromoteForm {

    @NotBlank
    private String adminPassword;

}
