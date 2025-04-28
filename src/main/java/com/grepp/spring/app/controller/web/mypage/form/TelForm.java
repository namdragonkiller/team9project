package com.grepp.spring.app.controller.web.mypage.form;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class TelForm {

    @NotBlank(message = "전화번호를 입력해주세요.")
    @Pattern(
            regexp = "^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$",
            message = "전화번호 형식은 010-1234-5678 과 같이 입력해주세요."
    )
    private String tel;
}
