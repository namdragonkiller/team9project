package com.grepp.spring.app.model.product;

import com.grepp.spring.app.model.product.dto.OrderListDto;
import com.grepp.spring.app.model.product.dto.OrderProductDto;
import com.grepp.spring.app.model.product.dto.ProductDto;
import com.grepp.spring.app.model.product.dto.ProductImg;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface ProductRepository {


    void insert(ProductDto product);

    void insertImage(ProductImg productImg);

    boolean deleteById(Integer id);
    List<ProductDto> selectAll();

    void insertPurchase(OrderListDto nonMember);

    void insertOrderProduct(OrderProductDto product);

    ProductDto selectById(Integer id);

    void updateProductById(@Param("id") Integer id, @Param("dto") ProductDto dto);

    void updateImageById(ProductImg productImg);

    void updateProductAmountById(Integer id, Integer amount);

    void updateOrderList(OrderListDto nonMember);

    Integer selectProductAmountById(@Param("id") Integer id);
}
