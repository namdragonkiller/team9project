package com.grepp.spring.infra.error;

import com.grepp.spring.infra.error.exceptions.CommonException;
import org.springframework.security.authorization.AuthorizationDeniedException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice(basePackages = "com.grepp.spring.app.controller.web")
public class WebExceptionAdvice {

    @ExceptionHandler(CommonException.class)
    public String webExceptionHandler(CommonException ex, Model model){
        model.addAttribute("message", ex.code().message());
        return "error/redirect";
    }

    @ExceptionHandler(AuthorizationDeniedException.class)
    public String authorizationDeniedHandler(AuthorizationDeniedException ex, Model model) {
        model.addAttribute("message", "접근 권한이 없습니다.");
        return "error/redirect";
    }

}
