/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.controller.admin;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.enums.Gender;
import com.ivt.spring_project_internship_tantubank.enums.Nation;
import com.ivt.spring_project_internship_tantubank.service.CustomerService;
import com.ivt.spring_project_internship_tantubank.service.ManageCustomerService;
import com.ivt.spring_project_internship_tantubank.service.UserService;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Optional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author henry
 */
@Controller
public class ManageCustomerController {

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ManageCustomerService manageCustomerService;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public UserEntity getUserByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String usernmae = principal.toString();
        if (principal instanceof UserDetails) {
            usernmae = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userService.findByUserName(usernmae);
        model.addAttribute("userlg", user);
        model.addAttribute("usernamelg", usernmae);
        return user;
    }

    @RequestMapping("/viewManageCustomer")
    public String viewManageCustomer(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        getUserByUserLogin(model);
        model.addAttribute("action", "customer");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<CustomerEntity> customers = customerService.getCustomersPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        System.out.println(customers);
        if (customers != null) {
            int totalPages = customers.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("customers", customers);
        }

        return "/management/manage_customers";
    }

    @RequestMapping(value = "/search_customer", method = RequestMethod.GET)
    public String searchCustomer(
            @RequestParam(value = "searchValue", required = false) String earchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        getUserByUserLogin(model);
        boolean searchCustomer = manageCustomerService.searchCustomer(earchValue, page, size, model);
        if (searchCustomer != true) {
            return "/management/manage_customers";
        }
        return "/management/manage_customers";
    }

    @RequestMapping("/editManageCustomer/{id}")
    public String viewEditCustomer(
            @PathVariable("id") long id,
            Model model) {
        getUserByUserLogin(model);
        CustomerEntity customer = customerService.viewCustomerById(id);
        model.addAttribute("customer", customer);
        model.addAttribute("nation", Nation.values());
        model.addAttribute("gender", Gender.values());
        return "/management/add_manage_customer";
    }

    @RequestMapping(value = ("/updateCustomer"), method = RequestMethod.POST)
    public String UpdeteCustomer(
            @Valid @ModelAttribute("customer") CustomerEntity customer,
            BindingResult result,
            Model model) throws IOException, ParseException {
        getUserByUserLogin(model);
        if (result.hasErrors()) {
            model.addAttribute("nation", Nation.values());
            return "/management/add_manage_customer";
        } else {
             manageCustomerService.UpdateCustomer(customer, model);
            return "redirect:/viewManageCustomer";
        }
    }

}
