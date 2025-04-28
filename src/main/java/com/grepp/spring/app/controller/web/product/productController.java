package com.grepp.spring.app.controller.web.product;

import com.grepp.spring.app.controller.web.product.form.OrderForm;
import com.grepp.spring.app.controller.web.product.form.ProductCartForm;
import com.grepp.spring.app.model.product.ProductService;
import com.grepp.spring.app.model.product.dto.ProductCartDto;
import com.grepp.spring.app.model.user.UserService;
import com.grepp.spring.app.model.user.dto.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequestMapping("/product")
@RequiredArgsConstructor
public class productController {

    private final ProductService productService;
    private final UserService userService;

    // 장바구니 페이지 (페이징 처리 o)
    @GetMapping("/cart")
    public String showCart(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "5") int size,
        Authentication authentication,
        HttpServletRequest request,
        Model model) {

        // 세션에서 장바구니 리스트 꺼냄
        Object cartListObj = request.getSession().getAttribute("cartList");

        if (cartListObj instanceof ProductCartDto cartList) {
            List<ProductCartDto.ProductItemDTO> items = cartList.getItems();

            int totalItems = items.size();
            int totalPages = (int) Math.ceil((double) totalItems / size);
            int start = page * size;
            int end = Math.min(start + size, totalItems);

            // 부분 리스트 추출
            List<ProductCartDto.ProductItemDTO> pagedItems = items.subList(start, end);

            User userInfo = null;
            String userId = null;
            if(authentication != null) {
                userId = authentication.getName();
            }

            if(userId != null && !userId.isEmpty()) {
                userInfo = userService.findById(userId);
            }

            model.addAttribute("userInfo", userInfo);
            model.addAttribute("cartList", pagedItems);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
        }

        return "product/product-cart";
    }

    // 장바구니 전달
    @PostMapping("/goCart")
    public String  goCart(Authentication authentication,
        @ModelAttribute @Valid ProductCartForm form,
        HttpServletRequest request ) {
        String userId = null;
        if(authentication != null) {
            userId = authentication.getName();
        }

        // DTO로 변환된 장바구니 리스트
        var cartList = form.toDto(userId);

        // 세션에 저장
        request.getSession().setAttribute("cartList", cartList);

        return "redirect:/product/cart";
    }

    // 구매하기
    @PostMapping("/purchase")
    public ResponseEntity<Map<String, Object>> purchaseProducts(Authentication authentication,@ModelAttribute @Valid OrderForm form) {

        String userId = null;
        if(authentication != null) {
            userId = authentication.getName();
        }
        int message =  productService.purchaseProduct(form.toDto(userId));

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("msg", message);
        return ResponseEntity.ok(response);
    }

}
