
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.repository.CustomerRepository;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author henry
 */
@Service
public class CustomerService {

    @Autowired
    CustomerRepository customerRepository;

    // find by email
    public CustomerEntity findCustomerByCustomerEmail(String customerEmail) {
        CustomerEntity customer = customerRepository.findByCustomerEmail(customerEmail);
        if (customer != null && customer.getId() > 0) {
            return customer;
        }
        return new CustomerEntity();
    }

    // find by phone
    public CustomerEntity findCustomerByCustomerPhone(String customerPhone) {
        CustomerEntity customer = customerRepository.findByCustomerPhone(customerPhone);
        if (customer != null && customer.getId() > 0) {
            return customer;
        }
        return new CustomerEntity();
    }

    // find by name
    public CustomerEntity findCustomerByCustomerName(String customerName) {
        CustomerEntity customer = customerRepository.findByCustomerName(customerName);
        if (customer != null && customer.getId() > 0) {
            return customer;
        }
        return new CustomerEntity();
    }

    public CustomerEntity findByCustomerEmailAndCustomerPhone(String customerEmail, String customerPhone) {
        CustomerEntity customer = customerRepository.findByCustomerEmailAndCustomerPhone(customerEmail, customerPhone);
        if (customer != null && customer.getId() > 0) {
            return customer;
        }
        return new CustomerEntity();
    }


    public void saveOrUpdateCustomer(CustomerEntity customer) {
        customerRepository.save(customer);
    }

    //show list have page
    public Page<CustomerEntity> getCustomersPagination(int currentPage, int pageSize, Sort sort) {
        Page<CustomerEntity> customers = customerRepository.findCustomer(PageRequest.of(currentPage, pageSize, sort));
        if (!customers.isEmpty()) {
            return customers;
        }

        return null;
    }

    //searc customer
    public Page<CustomerEntity> searchCutomer(String search, int currentPage, int pageSize, Sort sort) {
        Page<CustomerEntity> customer = customerRepository.findByCustomerByEmailByPhoneByName(search + "%", search, search, PageRequest.of(currentPage, pageSize, sort));
        if (!customer.isEmpty()) {
            return customer;
        }

        return null;
    }


//    view customer by id
    public CustomerEntity viewCustomerById(long id) {
        Optional<CustomerEntity> customerId = customerRepository.findById(id);
        if (customerId != null && customerId.isPresent()) {
            return customerId.get();
        }
        return new CustomerEntity();

    }
    
     // find by CINumber
     public CustomerEntity findCustomerByCINumber(String CINumber){
         CustomerEntity customer = customerRepository.findByCINumber(CINumber);
         if(customer != null && customer.getId() > 0){
             return customer;
         }
         return new CustomerEntity();
         }
}
