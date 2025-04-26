package com.grepp.spring.app.model.user;

import com.grepp.spring.app.model.user.dto.User;
import com.grepp.spring.app.model.userdetails.role.Role;
import java.util.Optional;
import lombok.extern.slf4j.Slf4j;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/servlet-context.xml"
})
@Slf4j
class UserRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @Test
    public void selectById() {
        log.info("{}", userRepository.selectById("test01"));
    }

    @Test
    public void insertAndSelectById() {

        User user = new User();
        user.setId("insertTest02");
        user.setPassword("encodedPwd123!");
        user.setEmail("test@sample.com");
        user.setTel("010-1111-2222");
        user.setAddress("서울시 강남구");
        user.setAddressNumber("06234");
        user.setRole(Role.ROLE_USER);

        userRepository.insert(user);

        Optional<User> result = userRepository.selectById("insertTest01");

        assertTrue(result.isPresent(), "유저가 DB에 삽입되지 않았습니다.");
        assertEquals("test@sample.com", result.get().getEmail());
        log.info("삽입된 사용자: {}", result.get());
    }


}



