package com.grepp.spring.app.controller.web.product.form;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.grepp.spring.app.model.product.dto.OrderListDto;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.Data;
import lombok.ToString;

@Data
public class OrderListForm {

    private String userId; // 회원인 경우만

    @NotBlank
    private String email;

    @NotBlank
    private String address;

    @NotBlank
    private String addressNumber;

    private LocalDateTime createdAt;

    @Valid
    private List<ProductItem> items = new ArrayList<>();

    public OrderListDto toDto(String userId) {
        OrderListDto dto = new OrderListDto();
        dto.setEmail(this.email);
        dto.setAddress(this.address);
        dto.setAddressNumber(this.addressNumber);
        dto.setCreatedAt(this.createdAt);
        dto.setUserId(userId);

        List<OrderListDto.ProductItemDTO> dtoItems = new ArrayList<>();
        for (ProductItem item : this.items) {
            OrderListDto.ProductItemDTO dtoItem = new OrderListDto.ProductItemDTO();
            dtoItem.setId(item.getId());
            dtoItem.setPrice(item.getPrice());
            dtoItem.setAmount(item.getAmount());
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
    }
}
