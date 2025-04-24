package com.grepp.spring.app.controller.web.product;

import com.grepp.spring.app.controller.web.product.form.NonMemberForm;
import com.grepp.spring.app.controller.web.admin.payload.ProductRegistRequest;
import com.grepp.spring.app.model.product.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/product")
@RequiredArgsConstructor
public class productController {

    private final ProductService productService;

    @Value("${upload.path}")
    private String uploadPath;

    // 제품 리스트 페이지
//    @PreAuthorize("isAuthenticated()")
    @GetMapping("/list")
    public String list(Authentication authentication, Model model) {

        var result = productService.selectAll();
        log.info("result : {}", result);

//        // 이미지 경로에 사용할 URL 접두사
//        String uploadUrl = "/download/";
//
//        result.forEach(productDto -> {
//            String imageUrl = uploadUrl + productDto.getSavePath() + "/" + productDto.getRenameFileName();
//            productDto.setSavePath(imageUrl);
//        });

        model.addAttribute("lists", result);
        return "product/product-list";
    }


    // 비회원 구매하기 ( 회원 구매하기도 만들어야함....)
    @PostMapping("/purchase")
    public ResponseEntity<String> purchaseProducts(@ModelAttribute @Valid NonMemberForm form) {

        productService.purchaseProduct(form.toDto());

        // 나중에 페이지 이동 처리
        return ResponseEntity.ok("success");
    }
}
