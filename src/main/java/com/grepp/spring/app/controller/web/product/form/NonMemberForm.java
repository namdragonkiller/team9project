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
public class NonMemberForm {

    @NotBlank
    private String email;

    @NotBlank
    private String address;

    @NotBlank
    private String addressNumber;

    private LocalDateTime createdAt;

    @Valid
    private List<ProductItem> items = new ArrayList<>();

    public OrderDto toDto() {
        OrderDto dto = new OrderDto();
        dto.setEmail(this.email);
        dto.setAddress(this.address);
        dto.setAddressNumber(this.addressNumber);
        dto.setCreatedAt(this.createdAt);

        List<OrderDto.ProductItemDTO> dtoItems = new ArrayList<>();
        for (ProductItem item : this.items) {
            OrderDto.ProductItemDTO dtoItem = new OrderDto.ProductItemDTO();
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
