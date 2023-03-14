
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.repository;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author henry
 */
@Repository
public interface CustomerRepository extends CrudRepository<CustomerEntity, Long> {

    // find by accountId
    CustomerEntity findByUserId(long userId);

    // find by email
    CustomerEntity findByCustomerEmail(String customerEmail);

    // find by phone
    CustomerEntity findByCustomerPhone(String customerPhone);
    
    // find by name
    CustomerEntity findByCustomerName(String customerName);
    
    // find by CINumber
    CustomerEntity findByCINumber (String CINumber);

    //find by email and phone
    CustomerEntity findByCustomerEmailAndCustomerPhone(String customerEmail, String customePhone);

    @Query("SELECT c FROM CustomerEntity c")
    Page<CustomerEntity> findCustomer(Pageable pageable);

    @Query(value = "SELECT * FROM customer where customer_email like ?1 or customer_phone = ?2 or  customer_name =  ?3", nativeQuery = true)
    Page<CustomerEntity> findByCustomerByEmailByPhoneByName(String email_customer, String phone_customer, String name_customer, Pageable pageable);
    

}
