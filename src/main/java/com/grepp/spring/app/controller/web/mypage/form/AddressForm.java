package com.grepp.spring.app.controller.web.mypage.form;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class AddressForm {

    @NotBlank(message = "주소를 입력해주세요.")
    private String address;

    @NotBlank(message = "우편번호를 입력해주세요.")
    @Pattern(
            regexp = "^[0-9]{2}$",
            message = "우편번호는 5자리 숫자로 입력해주세요."
    )
    private String addressNumber;
}
