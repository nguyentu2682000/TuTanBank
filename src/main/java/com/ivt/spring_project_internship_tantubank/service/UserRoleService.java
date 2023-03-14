/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.UserRoleEntity;
import com.ivt.spring_project_internship_tantubank.repository.UserRoleRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author henry
 */
@Service
public class UserRoleService {
    
    @Autowired
    private UserRoleRepository userRoleRepository;
    
    public void deleteUserRole(long id){
             userRoleRepository.deleteUserRole(id);
    }
}
