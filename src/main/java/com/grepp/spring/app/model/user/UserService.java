package com.grepp.spring.app.model.user;

import com.grepp.spring.app.model.user.dto.Principal;
import com.grepp.spring.app.model.user.dto.User;
import com.grepp.spring.app.model.userdetails.role.Role;
import com.grepp.spring.infra.error.exceptions.CommonException;
import com.grepp.spring.infra.response.ResponseCode;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;

    @Value("${admin-password.key}")
    private String adminPasswordKey;

    @Transactional
    public void signup(User dto, Role role) {
        if (userRepository.existUser(dto.getId()))
            throw new CommonException(ResponseCode.BAD_REQUEST);

        String encodedPassword = passwordEncoder.encode(dto.getPassword());
        dto.setPassword(encodedPassword);

        dto.setRole(role);
        userRepository.insert(dto);
    }

    public Principal signin(String id, String password) {

        Optional<User> optional = userRepository.selectById(id);

        if (optional.isEmpty()){
            throw new IllegalArgumentException("아이디나 비밀번호가 틀렸습니다");
        }


        User user = optional.get();

        if (!user.getId().equals(id) || !user.getPassword().equals(password)){
            throw new IllegalArgumentException("아이디나 비밀번호가 틀렸습니다");
        }

        return new Principal(id, List.of(Role.ROLE_USER));
    }

    public User findById(String id){
        return userRepository.selectById(id)
            .orElseThrow(() -> new CommonException(ResponseCode.BAD_REQUEST));
    }

    public Boolean isDuplicatedId(String id){
        return userRepository.existUser(id);
    }

    @Transactional
    public void promoteSelf(String adminPassword) {
        if (!adminPasswordKey.equals(adminPassword)) {
            throw new IllegalArgumentException("비밀번호가 틀렸습니다.");
        }

        String currentUserId = SecurityContextHolder.getContext().getAuthentication().getName();

        userRepository.promoteRole(currentUserId);
    }


}

