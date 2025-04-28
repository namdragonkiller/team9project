package com.grepp.spring.app.controller.web.user;

import com.grepp.spring.app.controller.web.user.form.PromoteForm;
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
    public String signup(SignupForm form) {
        return "user/signup";
    }

    @PostMapping("signup")
    public String signup(
        @Valid SignupForm form,
        BindingResult bindingResult,
        Model model) {
        if (bindingResult.hasErrors()) {
            return "user/signup";
        }

        userService.signup(form.toDto(), Role.ROLE_USER);
        return "redirect:/user/signin";
    }

    @GetMapping("signin")
    public String signin(SigninForm form) {
        return "user/signin";
    }

    @PostMapping("signin")
    public String signin(@Valid SigninForm form,
        BindingResult bindingResult,
        Model model){
        if (bindingResult.hasErrors()){
            return "user/signin";
        }
        try{
            userService.signin(form.getId(), form.getPassword());
        }catch (Exception e){
            model.addAttribute("errorMessage", "아이디나 비밀번호를 확인하세요");
            return "user/signin";
        }
        return "redirect:/index";
    }

    @GetMapping("promote")
    public String promote(PromoteForm form) {
        return "user/promote";
    }

    @PostMapping("promote")
    public String promote(
        @Valid PromoteForm form,
        BindingResult bindingResult,
        Model model) {

        if (bindingResult.hasErrors()) {
            return "user/promote";
        }

        try {
            userService.promoteSelf(form.getAdminPassword());
        } catch (Exception e) {
            model.addAttribute("errorMessage", "비밀번호를 확인하세요.");
            return "user/promote";
        }

        return "redirect:/user/signin";

    }
}
