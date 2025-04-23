package com.grepp.spring.app.model.product;

import com.grepp.spring.app.model.product.dto.Product;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface ProductRepository {

    List<Product> selectAll();
}
