package com.grepp.spring.app.model.product.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import lombok.Data;

@Data
public class OrderListDto {

    private Long id;
    private String email;
    private String address;
    private String addressNumber;
    private LocalDateTime createdAt;
    private List<ProductItemDTO> items;
    private Boolean isMember;
    private String userId;

    @Data
    public static class ProductItemDTO {

        private Integer id; // product_id
        private Integer price;
        private Integer amount;
    }

    public ProductItemDTO getItem() {
        return items != null && !items.isEmpty() ? items.get(0) : null;
    }

    public String getDate() {
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy.MM.dd a hh:mm:ss"));
    }
}
