package com.grepp.spring.app.model.product.dto;

import lombok.Data;

@Data
public class OrderProductDto {

    private Integer id; // 오토 증가
    private Long orderId; // 주문 id
    private Integer productId; // 제품 id
    private Integer amount;
    private String name; // 제품 명
}