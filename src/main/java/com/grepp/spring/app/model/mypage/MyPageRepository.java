package com.grepp.spring.app.model.mypage;

import org.apache.ibatis.annotations.Param;

public interface MyPageRepository {
    void updatePassword(@Param("id") String id, @Param("password") String password);
    void updateEmail(@Param("id") String id, @Param("email") String email);
    void updateTel(@Param("id") String id, @Param("tel") String tel);
    void updateAddress(@Param("id") String id,
                       @Param("address") String address,
                       @Param("addressNumber") String addressNumber);
    void deleteById(@Param("id") String id);
}
