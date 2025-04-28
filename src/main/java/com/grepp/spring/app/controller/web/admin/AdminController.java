package com.grepp.spring.app.controller.web.admin;

import com.grepp.spring.app.controller.web.admin.payload.ProductModifyRequest;
import com.grepp.spring.app.controller.web.admin.payload.ProductRegistRequest;
import com.grepp.spring.app.model.order.OrderService;
import com.grepp.spring.app.model.product.ProductService;
import com.grepp.spring.app.model.product.dto.OrderDto;
import com.grepp.spring.app.model.product.dto.ProductDto;
import jakarta.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
@RequestMapping("admin")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final ProductService productService;
    private final OrderService orderService;

    // 제품 등록 페이지
    @GetMapping("product/regist")
    public String regist(ProductRegistRequest request, Model model) {
        return "product/admin-product-regist";
    }

    @PostMapping("product/regist")
    public String regist(@Valid ProductRegistRequest request, BindingResult bindingResult, Model model) {

        if (bindingResult.hasErrors()) {
            return "product/admin-product-regist";
        }
        productService.registProduct(request.getThumbnail(), request.toDto());

        return "redirect:/admin/product/list";
    }

    @GetMapping("product/list")
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {

        int pageSize = 6;

        List<ProductDto> products = productService.getProducts(page, pageSize);
        int totalProducts = productService.countProducts(); // 총 상품 개수
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "product/admin-product-list";
    }

    @DeleteMapping("product/{id}")
    @ResponseBody
    public ResponseEntity<String> delete(@PathVariable Integer id, @RequestBody String path) {

        boolean result = productService.deleteById(id, path);

        if (result) {
            return ResponseEntity.ok("삭제 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }

    @GetMapping("product/{id}")
    public String detail(@PathVariable Integer id, @ModelAttribute ProductModifyRequest request, Model model) {

        ProductDto productDto = productService.selectById(id);

        model.addAttribute("product", productDto);
        return "product/admin-product-detail";
    }

    @PutMapping("product/{id}")
    @ResponseBody
    public ResponseEntity<?> modify(@PathVariable Integer id,
        @ModelAttribute @Valid ProductModifyRequest request, BindingResult bindingResult, Model model){

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = new HashMap<>();
            bindingResult.getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
            );
            return ResponseEntity.badRequest().body(errors);
        }

        productService.updateById(id, request.getOldPath(), request.getNewImage(), request.toDto());
        return ResponseEntity.ok("수정 성공");
    }

    @GetMapping("order")
    public String orderList(Model model) {

        List<OrderDto> result = orderService.selectAll();

        model.addAttribute("orders", result);

        return "product/admin-order-list";
    }

    @DeleteMapping("order/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteOrder(@PathVariable Integer id) {

        boolean result = orderService.deleteById(id);

        if (result) {
            return ResponseEntity.ok("취소 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("취소 실패");
        }
    }

}
