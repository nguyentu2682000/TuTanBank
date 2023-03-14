/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.controller.admin;

import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.service.UserService;
import com.ivt.spring_project_internship_tantubank.service.WithdrawService;
import javax.mail.MessagingException;
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
public class WithdrawController {
    @Autowired
    private WithdrawService withdrawService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    HttpSession session;
    
    public UserEntity getUserByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String usernmae = principal.toString();
        if (principal instanceof UserDetails) {
            usernmae = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userService.findByUserName(usernmae);
        model.addAttribute("user", user);
        model.addAttribute("username", usernmae);
        session.setAttribute("staff", user.getStaff());
        return user;
    }
    
    @RequestMapping(value = "/search_BankAccount", method = RequestMethod.POST)
    public String viewBankAccount(
            @RequestParam(value = "searchValue",  required = false) String valueSearch
            ,Model model){
        getUserByUserLogin(model);
       boolean withdraw = withdrawService.viewSearchWithdraw(valueSearch, model);
       if(withdraw == true){
           return "/management/Withdraw";
       }
         return "/management/Withdraw";
    }
    
    
     @RequestMapping(value = "/withdraw", method = RequestMethod.POST)
    public String withdrawBankAccount(
            @RequestParam(value = "amount",  required = false) String amount,
            @RequestParam(value = "tantuBankAddress",  required = false) String tantuBankAddress
            ,Model model) throws MessagingException{
        getUserByUserLogin(model);
       boolean withdraw = withdrawService.withdraw(amount,tantuBankAddress, model);
       if(withdraw == true){
           return "/management/Withdraw";
       }
         return "/management/Withdraw";
    }
}
