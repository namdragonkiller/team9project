package com.grepp.spring.app.model.product.dto;

import com.grepp.spring.infra.util.file.FileDto;
import java.time.LocalDateTime;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProductImg {

    private Integer id;
    private Integer productId;
    private String originFileName;
    private String renameFileName;
    private String savePath;
    private LocalDateTime createdAt;
    private Boolean activated;

    public ProductImg(Integer productId, FileDto fileDto) {
        this.productId = productId;
        this.originFileName = fileDto.originFileName();
        this.renameFileName = fileDto.renameFileName();
        this.savePath = fileDto.savePath();
    }

    public String getUrl() {
        return "/download/" + savePath + renameFileName;
    }

    public String getPath() {
        return savePath + renameFileName;
    }

}
