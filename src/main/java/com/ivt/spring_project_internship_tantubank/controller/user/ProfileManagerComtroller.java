/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.controller.user;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.enums.Gender;
import com.ivt.spring_project_internship_tantubank.enums.Nation;
import com.ivt.spring_project_internship_tantubank.service.ChangePasswordService;
import com.ivt.spring_project_internship_tantubank.service.ProfileManagerService;
import com.ivt.spring_project_internship_tantubank.service.UserService;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author henry
 */
@Controller
public class ProfileManagerComtroller {

    @Autowired
    private UserService userService;

    @Autowired
    private ChangePasswordService changePasswordService;

    @Autowired
    private ProfileManagerService profileManagerService;

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
        model.addAttribute("user", user);
        model.addAttribute("nation", Nation.values());
        model.addAttribute("gender", Gender.values());
        model.addAttribute("username", usernmae);
        return user;
    }

    @RequestMapping(value = "/chagePasswordUser", method = RequestMethod.POST)
    public String chengePassManaer(Model model) {
        getUserByUserLogin(model);
        String password = request.getParameter("password");
        String resetPassword = request.getParameter("resetPassword");
        String oldPassword = request.getParameter("oldPassword");
        boolean change = changePasswordService.chngePassAfterLogin(model, oldPassword, password, resetPassword);
        if (change == true) {
            return "/user/profile_manager";
        }
        return "/user/profile_manager";
    }

    @RequestMapping(value = "/emailAuthentication", method = RequestMethod.POST)
    public String emailAuthentication(Model model) throws MessagingException {
        getUserByUserLogin(model);
        String email = request.getParameter("email");
        boolean check = profileManagerService.checkEmail(model, email);
        if (check == true) {
            model.addAttribute("check", check);
            return "/user/profile_manager";
        }
        return "/user/profile_manager";
    }

    @RequestMapping(value = "/checkEmailAndUpdate", method = RequestMethod.POST)
    public String checkEmailAndUpdate(Model model) throws MessagingException {
        getUserByUserLogin(model);
        String confirmCode = request.getParameter("confirmCode");
        boolean check = profileManagerService.seveEmail(model, confirmCode);
        if (check == true) {
            return "/user/profile_manager";
        }
        return "/user/profile_manager";
    }

    @RequestMapping(value = ("/customerSave"), method = RequestMethod.POST)
    public String updateCustomer(Model model,
            @Valid @ModelAttribute("customer") CustomerEntity customer,
            BindingResult result) {
         getUserByUserLogin(model);
         if (result.hasErrors()) {
           return "/user/profile_manager";
        } else {
           profileManagerService.saveCustomer(model, customer);
           return "redirect:/profileManager";
        }
        
    }

}
