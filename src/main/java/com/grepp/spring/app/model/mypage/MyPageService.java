package com.grepp.spring.app.model.mypage;

import com.grepp.spring.app.model.product.dto.OrderDto;
import com.grepp.spring.app.model.order.OrderRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class MyPageService {

    private final OrderRepository orderRepository;
    private final JdbcTemplate jdbcTemplate;

    public MyPageService(OrderRepository orderRepository,
                         JdbcTemplate jdbcTemplate) {
        this.orderRepository = orderRepository;
        this.jdbcTemplate    = jdbcTemplate;
    }

    /**
     * 주문 내역 조회
     * 현재는 전체 주문 목록을 반환합니다. 나중에 userId로 필터링 구현 필요.
     */
    public List<OrderDto> getOrderHistory(String userId) {
        return orderRepository.selectAll();
    }

    public void changePassword(String userId, String newPassword) {
        jdbcTemplate.update(
                "UPDATE users SET password = ? WHERE id = ?",
                newPassword, userId
        );
    }

    public void changeEmail(String userId, String newEmail) {
        jdbcTemplate.update(
                "UPDATE users SET email = ? WHERE id = ?",
                newEmail, userId
        );
    }

    public void changeTel(String userId, String newTel) {
        jdbcTemplate.update(
                "UPDATE users SET tel = ? WHERE id = ?",
                newTel, userId
        );
    }

    public void changeAddress(String userId, String address, String addressNumber) {
        jdbcTemplate.update(
                "UPDATE users SET address = ?, address_number = ? WHERE id = ?",
                address, addressNumber, userId
        );
    }

    public void deleteAccount(String userId) {
        jdbcTemplate.update(
                "DELETE FROM users WHERE id = ?",
                userId
        );
    }
}
