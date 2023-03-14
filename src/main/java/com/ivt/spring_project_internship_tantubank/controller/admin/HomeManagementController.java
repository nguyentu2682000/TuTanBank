/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.controller.admin;

import com.ivt.spring_project_internship_tantubank.entities.BankAccountEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.service.ChangePasswordService;
import com.ivt.spring_project_internship_tantubank.service.CustomerService;
import com.ivt.spring_project_internship_tantubank.service.ManageCustomerService;
import com.ivt.spring_project_internship_tantubank.service.ManageTransactionService;
import com.ivt.spring_project_internship_tantubank.service.ManageUserService;
import com.ivt.spring_project_internship_tantubank.service.UserService;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author henry
 */
@Controller
@RequestMapping("/management")
public class HomeManagementController {

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ManageCustomerService manageCustomerService;

    @Autowired
    private ManageUserService manageUserService;

    @Autowired
    private ManageTransactionService manageTransactionService;
    
    @Autowired
    private ChangePasswordService changePasswordService;

    @Autowired
    HttpSession session;

     @Autowired
    HttpServletRequest request;
     
    public UserEntity getUserByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String usernmae = principal.toString();
        if (principal instanceof UserDetails) {
            usernmae = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userService.findByUserName(usernmae);
        session.setAttribute("userlg", user);
        model.addAttribute("usernamelg", usernmae);
        return user;
    }

    @RequestMapping(value = {"/*", "/adminHome"})
    public String homePage(Model model) {
        getUserByUserLogin(model);
        return "/management/home";
    }

    //Hiển thị user_profile trong management 
    @RequestMapping("/profile_user")
    public String viewProfile(Model model) {
        getUserByUserLogin(model);
        model.addAttribute("action", "profile");
        return "/management/profile_management";    
    }

    @RequestMapping( value = "/changePassManagement", method = RequestMethod.POST)
    public String chengePassManagement(Model model) {
        getUserByUserLogin(model);
        String password = request.getParameter("password");
        String resetPassword = request.getParameter("resetPassword");
        String oldPassword = request.getParameter("oldPassword");
        boolean change = changePasswordService.chngePassAfterLogin(model, oldPassword, password, resetPassword);
        if(change == true){
        model.addAttribute("action", "changePasss");
        return "/management/profile_management";
        }
        model.addAttribute("action", "changePasss");
        return "/management/profile_management";
    }

    @RequestMapping("/viewManageUsers")
    public String viewManageUser(
            @RequestParam(value = "page", required = false) Optional<Integer> page,
            @RequestParam(value = "size", required = false) Optional<Integer> size,
            Model model) {
        getUserByUserLogin(model);
        boolean listUsers = manageUserService.viewManageUser(page, size, model);
        if (listUsers != true) {
            return "/management/manage_users";
        }
        return "/management/manage_users";
    }

    @RequestMapping(value = "/search_user", method = RequestMethod.GET)
    public String searchMangeUser(
            @RequestParam(value = "searchValue", required = false) String earchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        getUserByUserLogin(model);
        boolean searchUser = manageUserService.searchManageUser(earchValue, page, size, model);
        if (searchUser != true) {
            return "/management/manage_users";
        }
        return "/management/manage_users";
    }

    @RequestMapping("/Withdraw")
    public String viewWithdraw(
            Model model) {
        getUserByUserLogin(model);
        session.setAttribute("bankAccount", new BankAccountEntity());
        model.addAttribute("action", "search");
        return "/management/Withdraw";
    }
    
   

}
