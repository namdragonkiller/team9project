package com.grepp.spring.app.model.product;

import com.grepp.spring.app.model.product.dto.Product;
import com.grepp.spring.app.model.product.dto.ProductImg;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface ProductRepository {

    List<Product> selectAll();

    void insert(Product product);

    void insertImage(ProductImg productImg);
}
