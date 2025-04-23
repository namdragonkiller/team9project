package com.grepp.spring.app.controller.web.admin;

import com.grepp.spring.app.controller.web.admin.payload.ProductRegistRequest;
import com.grepp.spring.app.model.product.ProductService;
import com.grepp.spring.app.model.product.dto.Product;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Slf4j
@RequestMapping("admin")
@RequiredArgsConstructor
//@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final ProductService productService;

    // 제품 등록 페이지
    @GetMapping("product/regist")
    public String regist(ProductRegistRequest request, Model model) {
        return "product/product-regist";
    }

    @PostMapping("product/regist")
    public String regist(@Valid ProductRegistRequest request, BindingResult bindingResult, Model model) {

        if (bindingResult.hasErrors()) {
            return "product/product-regist";
        }
        productService.registProduct(request.getThumbnail(), request.toDto());

        return "redirect:/admin/product/list";
    }

    @GetMapping("product/list")
    public String list(Model model) {

        List<Product> result = productService.selectAll();

        model.addAttribute("products", result);
        return "product/admin-product-list";
    }

    @DeleteMapping("product/{id}")
    @ResponseBody
    public ResponseEntity<String> delete(@PathVariable Integer id, RedirectAttributes redirectAttributes) {

        boolean result = productService.deleteById(id);

        if (result) {
            return ResponseEntity.ok("삭제 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }

    }
}
