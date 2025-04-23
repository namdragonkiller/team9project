package com.grepp.spring.app.model.product;

import com.grepp.spring.app.model.product.dto.Product;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {

    private final ProductRepository productRepository;

    @Transactional
    public List<Product> selectAll() {
        return productRepository.selectAll();
    }


}
