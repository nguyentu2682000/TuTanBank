/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.controller.admin;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.enums.Gender;
import com.ivt.spring_project_internship_tantubank.enums.Nation;
import com.ivt.spring_project_internship_tantubank.service.ManageUserService;
import com.ivt.spring_project_internship_tantubank.service.RoleService;
import com.ivt.spring_project_internship_tantubank.service.UserService;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author henry
 */
@Controller
public class ManageUserController {

    @Autowired
    private ManageUserService manageUserService;

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public UserEntity getUserByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String usernmae = principal.toString();
        if (principal instanceof UserDetails) {
            usernmae = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userService.findByUserName(usernmae);
        model.addAttribute("user", user);
        model.addAttribute("username", usernmae);
        return user;
    }

    @RequestMapping("/changeUserLock/{id}")
    public String userStatusLock(
            @PathVariable("id") long id,
            Model model) {
        getUserByUserLogin(model);
        manageUserService.lockUser(id, model);
        return "redirect:/management/viewManageUsers";
    }

    @RequestMapping("/changeUserActive/{id}")
    public String userStatusActive(
            @PathVariable("id") long id,
            Model model) {
        getUserByUserLogin(model);
        manageUserService.activeUser(id, model);
        return "redirect:/management/viewManageUsers";
    }

    @RequestMapping("/addManageUser")
    public String viewFormAdd(Model model) {
        getUserByUserLogin(model);
        model.addAttribute("action", "add_user");
        session.setAttribute("addUserSession", new UserEntity());
        session.setAttribute("addUserSession1", new UserEntity());
        return "/management/add_manage_user";
    }

//    addUser
    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public String addUser(
            @Valid @ModelAttribute("user") UserEntity user,
            BindingResult result,
            Model model) throws Exception {
        if (result.hasErrors()) {
            model.addAttribute("action", "add_user");
            return "/management/add_manage_user";
        } else {
            boolean addUser = manageUserService.addUser(user, model);
            if (addUser == true) {
                model.addAttribute("action", "add_user1");
                model.addAttribute("roles", roleService.getRoles());
                return "/management/add_manage_user";
            } else {
                model.addAttribute("action", "add_user");
                return "/management/add_manage_user";
            }
        }

    }

    @RequestMapping(value = "/addUser1", method = RequestMethod.POST)
    public String addUser1(
            Model model) {
        String[] rolesUser = request.getParameterValues("roleUsers");
        boolean addUser1 = manageUserService.addUser1(rolesUser, model);
        if (addUser1 != true) {
            model.addAttribute("action", "add_user1");
            model.addAttribute("roles", roleService.getRoles());
            return "/management/add_manage_user";
        } else {
            model.addAttribute("action", "add_user2");
            model.addAttribute("genders", Gender.values());
            model.addAttribute("nations", Nation.values());
            return "/management/add_manage_user";
        }
    }

    @RequestMapping(value = "/addUser2", method = RequestMethod.POST)
    public String addUser2(
            @Valid @ModelAttribute("customer") CustomerEntity customer,
            BindingResult result,
            Model model) throws Exception {
        if (result.hasErrors()) {
            model.addAttribute("action", "add_user2");
            model.addAttribute("genders", Gender.values());
            model.addAttribute("nations", Nation.values());
            return "/management/add_manage_user";
        } else {
            boolean addUser2 = manageUserService.addUser2(customer, model);
            if (addUser2 == true) {
                return "redirect:/management/viewManageUsers";
            } else {
                model.addAttribute("action", "add_user2");
                model.addAttribute("genders", Gender.values());
                model.addAttribute("nations", Nation.values());
                return "/management/add_manage_user";
            }
        }

    }

//    end addUser
    
    @RequestMapping("/viewUserEdit/{id}")
    public String viewUserEdit(
            @PathVariable("id") long id,
            Model model) {
        getUserByUserLogin(model);
        manageUserService.viewUserEdit(id, model);
        model.addAttribute("action", "update_user");
        return "/management/add_manage_user";
    }
    
    @RequestMapping(value = "/updateUser", method = RequestMethod.POST)
    public String updateUser(
            Model model) {
        String userName = request.getParameter("userName");
        String[] rolesUser = request.getParameterValues("roleUsers");
        manageUserService.updateUser(rolesUser,userName, model);
      
      return "redirect:/management/viewManageUsers";
    }
}
