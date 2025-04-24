package com.grepp.spring.app.controller.web.admin.payload;

import com.grepp.spring.app.model.product.dto.ProductDto;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.util.List;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ProductRegistRequest {

    private List<MultipartFile> thumbnail;
    @NotBlank
    private String name;
    @NotNull
    @Min(0)
    private Integer price;
    @NotNull
    @Min(0)
    private Integer amount;
    @NotBlank
    private String info;

    public ProductDto toDto() {
        ProductDto product = new ProductDto();
        product.setName(name);
        product.setPrice(price);
        product.setAmount(amount);
        product.setInfo(info);
        return product;
    }
}
