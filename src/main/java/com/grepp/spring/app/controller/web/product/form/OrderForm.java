package com.grepp.spring.app.controller.web.product.form;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.grepp.spring.app.model.product.dto.OrderDto;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.Data;
import lombok.ToString;

@Data
public class OrderForm {

    private String userId; // 회원인 경우만

    @NotBlank(message = "이메일은 필수입니다.")
    private String email;

    @NotBlank(message = "주소는 필수입니다.")
    private String address;

    @NotBlank(message = "우편번호는 필수입니다.")
    private String addressNumber;

    private LocalDateTime createdAt;

    @Valid
    private List<ProductItem> items = new ArrayList<>();

    public OrderDto toDto(String userId) {
        OrderDto dto = new OrderDto();
        dto.setEmail(this.email);
        dto.setAddress(this.address);
        dto.setAddressNumber(this.addressNumber);
        dto.setCreatedAt(this.createdAt);
        dto.setUserId(userId);

        List<OrderDto.ProductItemDTO> dtoItems = new ArrayList<>();
        for (ProductItem item : this.items) {
            OrderDto.ProductItemDTO dtoItem = new OrderDto.ProductItemDTO();
            dtoItem.setId(item.getId());
            dtoItem.setPrice(item.getPrice());
            dtoItem.setAmount(item.getAmount());
            dtoItem.setName(item.getName());
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
    }
}
