package com.grepp.spring;

import com.grepp.spring.app.model.product.ProductService;
import com.grepp.spring.app.model.product.dto.ProductDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class IndexController {

    private final ProductService productService;

    @GetMapping
    public String index(Model model) {
        List<ProductDto> product = productService.selectAll();
        model.addAttribute("products", product);
        return "index";
    }
}