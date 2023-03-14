/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 *
 * @author henry
 */
@Service
public class ManageCustomerService {

    @Autowired
    private CustomerService customerService;

    public boolean searchCustomer(String searchValue, Optional<Integer> page, Optional<Integer> size,
            Model model) {
        model.addAttribute("action", "search_customer");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<CustomerEntity> customer = customerService.searchCutomer(searchValue, currentPage - 1, pageSize, Sort.by("id").descending());
        if (customer != null) {
            int totalPages = customer.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("customers", customer);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return true;
    }

    public void viewEditCustomer(long id, Model model) {
        CustomerEntity customer = customerService.viewCustomerById(id);
        model.addAttribute("customer", customer);
        return;
    }

    public void UpdateCustomer(CustomerEntity customer, Model model) {
                if (customer.getId() > 0) {
                    customerService.saveOrUpdateCustomer(customer);
                }
    }

}
