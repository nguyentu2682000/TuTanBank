/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.repository;

import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.enums.UserStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

/**
 *
 * @author henry
 */
public interface UserRepository extends CrudRepository<UserEntity, Long> {

    UserEntity findByUserNameLikeAndUserStatus(String userName, UserStatus userStatus);

    UserEntity findByUserName(String userName);
    
    @Query("SELECT u FROM UserEntity u")
    Page<UserEntity> findUser(Pageable pageable);
    
    @Query(value = "SELECT * FROM users where user_name like ?1 or user_status = ?2 ", nativeQuery = true)
    Page<UserEntity> findByUserByUserNameByStatus(String userName, String userStatus, Pageable pageable);

}
