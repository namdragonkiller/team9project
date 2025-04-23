package com.grepp.spring.app.model.product;

import com.grepp.spring.app.model.product.dto.Product;
import com.grepp.spring.app.model.product.dto.ProductImg;
import com.grepp.spring.infra.error.exceptions.CommonException;
import com.grepp.spring.infra.response.ResponseCode;
import com.grepp.spring.infra.util.file.FileDto;
import com.grepp.spring.infra.util.file.FileUtil;
import java.io.IOException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {

    private final ProductRepository productRepository;
    private final FileUtil fileUtil;

    @Transactional
    public List<Product> selectAll() {
        return productRepository.selectAll();
    }

    @Transactional
    public void registProduct(List<MultipartFile> thumbnail, Product dto) {
        try {
            List<FileDto> fileDtos = fileUtil.upload(thumbnail, "product");
            productRepository.insert(dto);

            if (fileDtos.isEmpty()) {
                return;
            }

            ProductImg productImg = new ProductImg(dto.getId(), fileDtos.getFirst());

            productRepository.insertImage(productImg);
        } catch (IOException e) {
            throw new CommonException(ResponseCode.INTERNAL_SERVER_ERROR, e);
        }
    }

    @Transactional
    public boolean deleteById(Integer id) {

        return productRepository.deleteById(id);
    }
}
