package com.grepp.spring;

import com.grepp.spring.app.model.product.ProductService;
import com.grepp.spring.app.model.product.dto.ProductDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class IndexController {

    private final ProductService productService;
//
//    @GetMapping
//    public String index(Model model) {
//        List<ProductDto> product = productService.selectAll();
//        model.addAttribute("products", product);
//        return "index";
//    }

    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {

        int pageSize = 6;

        List<ProductDto> products = productService.getProducts(page, pageSize);
        int totalProducts = productService.countProducts(); // 총 상품 개수
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "index";
    }
}