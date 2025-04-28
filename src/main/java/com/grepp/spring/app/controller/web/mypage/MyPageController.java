package com.grepp.spring.app.controller.web.mypage;

import com.grepp.spring.app.model.mypage.MyPageService;
import com.grepp.spring.app.model.product.dto.OrderDto;
import com.grepp.spring.app.model.userdetails.domain.AuthPrincipal;
import com.grepp.spring.app.model.user.UserService;
import com.grepp.spring.app.model.user.dto.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import org.springframework.security.core.Authentication;

@Slf4j
@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MyPageController {

    private final MyPageService myPageService;
    private final UserService     userService;  // ← 추가


    @GetMapping("/mypagemain")
    public String showMyPageMain(
        Authentication authentication,
        Model model,
        @ModelAttribute("message") String message
    ) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/user/signin";
        }

        AuthPrincipal principal = (AuthPrincipal) authentication.getPrincipal();

        String userId = principal.getUsername();
        User currentUser = userService.findById(userId);
        log.debug("== showMyPageMain 호출, currentUser.id={}, email={} ==", userId, currentUser.getEmail());

        model.addAttribute("currentUser", currentUser);

        List<OrderDto> orderHistory = myPageService.getOrderHistory(userId);
        model.addAttribute("orderHistory", orderHistory);

        return "mypage/mypagemain";
    }

    // 이하 비밀번호/이메일/전화번호/주소 변경 및 탈퇴 처리 메서드는 기존과 동일하게 두시면 됩니다.
}
