package com.grepp.spring.app.model.product.dto;

import java.util.List;
import lombok.Data;

@Data
public class Product {

    private Integer id;
    private String name;
    private Integer price;
    private Integer amount;
    private String info;
    private ProductImg image;
}
