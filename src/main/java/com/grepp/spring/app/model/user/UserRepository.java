package com.grepp.spring.app.model.user;

import com.grepp.spring.app.model.user.dto.User;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Mapper
@Repository
public interface UserRepository {

    Optional<User> selectById(String id);

    @Select("select count(*) from users where id = #{id}")
    Boolean existUser(String user);

    @Insert("insert into users(ID,PASSWORD,EMAIL,TEL,ADDRESS,ADDRESS_NUMBER,ROLE)"
        + "values (#{id},#{password},#{email},#{tel},#{address},#{addressNumber},#{role})")
    void insert(User dto);


}
