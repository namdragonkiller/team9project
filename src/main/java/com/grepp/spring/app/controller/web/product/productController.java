package com.grepp.spring.app.controller.web.product;

import com.grepp.spring.app.model.product.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/product")
@RequiredArgsConstructor
public class productController {

    private final ProductService productService;

    // 제품 리스트 페이지
//    @PreAuthorize("isAuthenticated()")
    @GetMapping("/list")
    public String list(Authentication authentication, Model model) {

        var result = productService.selectAll();
        log.info("result : {}", result);

        model.addAttribute("lists", result);
        return "product/product-list";
    }
}
