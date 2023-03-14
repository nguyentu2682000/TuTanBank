/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.repository;

import com.ivt.spring_project_internship_tantubank.entities.UserRoleEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author henry
 */
@Repository
public interface UserRoleRepository extends CrudRepository<UserRoleEntity, Long>{
    
    
    @Transactional
    @Modifying
    @Query(value ="delete FROM user_roles where userId = ?1" , nativeQuery = true)
    void deleteUserRole(long id);
}
