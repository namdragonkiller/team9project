package com.grepp.spring.app.model.order;

import com.grepp.spring.app.model.product.dto.OrderListDto;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderService {

    private final OrderRepository orderRepository;


    public List<OrderListDto> selectAll() {
        return orderRepository.selectAll();
    }
}
