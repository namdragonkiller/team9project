package com.grepp.spring.app.model.order;

import com.grepp.spring.app.model.product.dto.OrderDto;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface OrderRepository {

    List<OrderDto> selectAll();

    boolean deleteById(Integer id);
}
