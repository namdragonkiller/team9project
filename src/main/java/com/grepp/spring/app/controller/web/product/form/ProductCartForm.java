package com.grepp.spring.app.controller.web.product.form;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.grepp.spring.app.model.product.dto.ProductCartDto;
import jakarta.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import lombok.Data;
import lombok.ToString;

@Data
public class ProductCartForm {

    private String email;

    private String address;

    private String addressNumber;

    private String userId;

    @Valid
    private List<ProductItem> items = new ArrayList<>();

    public ProductCartDto toDto(String userId) {
        ProductCartDto dto = new ProductCartDto();
        dto.setEmail(this.email);
        dto.setAddressNumber(this.addressNumber);
        dto.setAddress(this.address);
        dto.setUserId(userId);

        List<ProductCartDto.ProductItemDTO> dtoItems = new ArrayList<>();
        for (ProductItem item : this.items) {
            ProductCartDto.ProductItemDTO dtoItem = new ProductCartDto.ProductItemDTO();
            dtoItem.setId(item.getId());
            dtoItem.setPrice(item.getPrice());
            dtoItem.setAmount(item.getAmount());
            dtoItem.setName(item.getName());
            dtoItem.setImageUrl(item.getImageUrl());
            dtoItems.add(dtoItem);
        }

        dto.setItems(dtoItems);
        return dto;
    }

    @ToString
    @Data
    public static class ProductItem {
        @JsonProperty("id")
        private Integer id;
        @JsonProperty("price")
        private Integer price;
        @JsonProperty("amount")
        private Integer amount;
        @JsonProperty("name")
        private String name;
        @JsonProperty("imageUrl")
        private String imageUrl;
    }
}
