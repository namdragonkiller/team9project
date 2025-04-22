package com.grepp.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class IndexController {

//    @CrossOrigin(origins = "http://localhost:63342", allowCredentials = "true")
    @GetMapping
    public String index() {
        return "index";
    }
}
