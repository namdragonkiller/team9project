package com.grepp.spring.app.controller.web.user;

import com.grepp.spring.app.controller.web.user.form.SigninForm;
import com.grepp.spring.app.controller.web.user.form.SignupForm;
import com.grepp.spring.app.model.user.UserService;
import com.grepp.spring.app.model.userdetails.role.Role;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserService userService;

    @GetMapping("signup")
    public String signup(SignupForm form){
        return "user/signup";
    }

    @PostMapping("signup")
    public String signup(
        @Valid SignupForm form,
        BindingResult bindingResult,
        Model model){
        if (bindingResult.hasErrors()){
            return "user/signup";
        }

    userService.signup(form.toDto(), Role.ROLE_USER);
        return "redirect:/user/signin";
    }

    @GetMapping("signin")
    public String signin(SigninForm form){
        return "user/signin";
    }




}
