package com.grepp.spring.app.model.product.dto;

import java.util.List;
import lombok.Data;

@Data
public class ProductCartDto {

    private String email;
    private String address;
    private String addressNumber;
    private String userId;
    private List<ProductItemDTO> items;


    @Data
    public static class ProductItemDTO {
        private Integer id; // product_id
        private Integer price;
        private Integer amount;
        private String name;
        private String imageUrl;
    }
}
