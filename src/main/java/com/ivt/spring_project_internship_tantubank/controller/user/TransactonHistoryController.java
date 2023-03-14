/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.controller.user;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.service.TransactionHistoryService;
import com.ivt.spring_project_internship_tantubank.service.UserService;
import java.text.ParseException;
import java.util.Optional;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
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
public class TransactonHistoryController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private TransactionHistoryService transactionHistoryService;
    
    @Autowired
    HttpSession session;

    
     public UserEntity getUserByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String usernmae = principal.toString();
        if (principal instanceof UserDetails) {
            usernmae = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userService.findByUserName(usernmae);
        session.setAttribute("userlg", user);
        model.addAttribute("user", user);
        model.addAttribute("username", usernmae);
        return user;
    }
    
   
    
    @RequestMapping("/transactionHistory")
    public String viewTransactionHistory(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        getUserByUserLogin(model);
         transactionHistoryService.getTransactionHistory(model, page, size);
        return "/user/transaction_history";
    }
    
    @RequestMapping(value = "/search_transactionHistory", method = RequestMethod.GET)
    public String searchMangeUser(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) throws ParseException{
        getUserByUserLogin(model);
       transactionHistoryService.searchTransactionHistory(searchValue, model, page, size);
         return "/user/transaction_history";
    }
}
