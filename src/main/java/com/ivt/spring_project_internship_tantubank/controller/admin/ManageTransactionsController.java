/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.controller.admin;

import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.service.ManageTransactionService;
import com.ivt.spring_project_internship_tantubank.service.UserService;
import java.util.Optional;
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
public class ManageTransactionsController {

    @Autowired
    private ManageTransactionService manageTransactionService;
    
    @Autowired
    private UserService userService;
    
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

    @RequestMapping("/transactions")
    public String viewTransactions(@RequestParam(value = "page", required = false) Optional<Integer> page,
            @RequestParam(value = "size", required = false) Optional<Integer> size,
            Model model) {
        getUserByUserLogin(model);
        boolean tst = manageTransactionService.viewsTransaction(page, size, model);
        if(tst != true){
             return "/management/manage_transaction";
        }
        return "/management/manage_transaction";
    }
    
     @RequestMapping(value = "/search_transaction", method = RequestMethod.GET)
    public String searchMangeUser(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model){
        getUserByUserLogin(model);
        boolean searchTransaction = manageTransactionService.searchManageTransaction(searchValue, page, size, model);
        if(searchTransaction != true){
             return "/management/manage_transaction";
        }
         return "/management/manage_transaction";
    }
}
