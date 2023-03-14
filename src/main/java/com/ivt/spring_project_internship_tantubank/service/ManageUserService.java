/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.RoleEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserRoleEntity;
import com.ivt.spring_project_internship_tantubank.enums.Gender;
import com.ivt.spring_project_internship_tantubank.enums.Nation;
import com.ivt.spring_project_internship_tantubank.enums.RoleUser;
import com.ivt.spring_project_internship_tantubank.enums.UserStatus;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 *
 * @author henry
 */
@Service
public class ManageUserService {

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    HttpSession session;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public boolean viewManageUser(Optional<Integer> page, Optional<Integer> size, Model model) {
        model.addAttribute("action", "user");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<UserEntity> users = userService.getUserPagination(currentPage - 1, pageSize, Sort.by("createDate").ascending());
        if (users != null) {
            int totalPages = users.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("users", users);
        }
        return true;
    }

    public boolean searchManageUser(String searchValue, Optional<Integer> page, Optional<Integer> size,
            Model model) {
        model.addAttribute("action", "search_customer");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<UserEntity> user = userService.searchUse(searchValue, currentPage - 1, pageSize, Sort.by("id").ascending());
        if (user != null) {
            int totalPages = user.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("users", user);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return true;
    }

    public void lockUser(long id, Model model) {
        UserEntity user = userService.findByUserById(id);
        if (user.getId() > 0) {
            user.setUserStatus(UserStatus.LOCK);
            userService.saveUser(user);
        }
    }

    public void activeUser(long id, Model model) {
        UserEntity user = userService.findByUserById(id);
        if (user.getId() > 0) {
            user.setUserStatus(UserStatus.ACTIVE);
            userService.saveUser(user);
        }
    }

    public boolean addUser(UserEntity user, Model model
    ) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        UserEntity userNameEt = userService.findByUserName(user.getUserName());
        if (userNameEt.getId() > 0) {
            model.addAttribute("messageUser", "Tên tài khoản đã tồn tại");
            model.addAttribute("userName", user.getUserName());
        } else {
            String pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&-+=]).{6,}$";
            if (user.getPassword().matches(pattern) == false) {
                model.addAttribute("messagePass", "Mật khẩu sai định dạng!! Vui lòng kiểm tra lại!!");
                 model.addAttribute("userName", user.getUserName());
            } else {
                UserEntity addUser = new UserEntity();
                addUser.setUserName(user.getUserName());
                addUser.setPassword(encoder.encode(user.getPassword()));
                addUser.setCreateDate(new Date());
                addUser.setUserStatus(UserStatus.ACTIVE);
                session.setAttribute("addUserSession", addUser);
                return true;
            }
        }
        return false;
    }

    public boolean addUser1(String[] rolesUser, Model model) {
        UserEntity userAddsession = (UserEntity) session.getAttribute("addUserSession");

        List<String> rolesUserString = new ArrayList<>();
        if (rolesUser != null) {
            for (String role : rolesUser) {
                rolesUserString.add(role);
            }
        }

        List<RoleEntity> roles = roleService.getRoles();
        List<RoleEntity> rolesList = new ArrayList<>();
        rolesList.add(roles.get(1));
        for (String roleUserString : rolesUserString) {
            for (RoleEntity r : roles) {
                if (String.valueOf(r.getId()).equals(roleUserString)) {
                    rolesList.add(r);
                }
            }
        }

        List<UserRoleEntity> roleUserList = new ArrayList<>();
        for (RoleEntity r : rolesList) {
            UserRoleEntity roleU = new UserRoleEntity(userAddsession, r);
            roleUserList.add(roleU);
        }
        userAddsession.setUserRoles(roleUserList);
        session.setAttribute("addUserSession1", userAddsession);
        return true;
    }

    public boolean addUser2(CustomerEntity customer, Model model) {
        CustomerEntity customerCustomerEmail = customerService.findCustomerByCustomerEmail(customer.getCustomerEmail());
        if (customerCustomerEmail.getId() > 0) {
            model.addAttribute("messEmail", "Email này đã được dùng !!");
        } else {
            CustomerEntity customerCustomerPhone = customerService.findCustomerByCustomerPhone(customer.getCustomerPhone());
            if (customerCustomerPhone.getId() > 0) {
                model.addAttribute("messphone", "Số điện thoại đã được dùng !!");
            } else {
                if (customer.getCustomerPhone().length() < 10 || customer.getCustomerPhone().length() > 12) {
                    model.addAttribute("messPhone", "Số điện thoại không đúng định dạng !!");
                } else {
                    if (customer.getCINumber().length() < 11 || customer.getCINumber().length() > 13) {
                        model.addAttribute("messCINumber", "Số căn cước không đúng định dạng !!");
                    } else {
                        CustomerEntity customerCINumber = customerService.findCustomerByCINumber(customer.getCINumber());
                        if (customerCINumber.getId() > 0) {
                            model.addAttribute("messCINumber", "Số căn cước công dân đã được dùng !!");
                        } else {
                            UserEntity userAddsession = (UserEntity) session.getAttribute("addUserSession1");
                            if (userAddsession == null) {
                                model.addAttribute("messageError", "Thêm người dùng không thành công");
                            } else {
                                userService.saveUser(userAddsession);
                                customer.setUser(userAddsession);
                                customerService.saveOrUpdateCustomer(customer);
                                return true;
                            }
                        }
                    }
                }
            }
        }
        model.addAttribute("customer", customer);
        return false;
    }

    public void viewUserEdit(long id, Model model) {
        UserEntity user = userService.findByUserById(id);
        List<RoleEntity> roles = roleService.getRoles();
        for (RoleEntity r : roles) {
            for (UserRoleEntity ur : user.getUserRoles()) {
                if (r.getId() == ur.getRole().getId()) {
                    r.setExistRoleUser(true);
                    break;
                }
            }
        }
        model.addAttribute("userEdit", user);
        model.addAttribute("roles", roles);
    }

    public void updateUser(String[] rolesUser, String username, Model model) {
        UserEntity user = userService.findByUserName(username);
        if (user.getId() > 0) {
            userRoleService.deleteUserRole(user.getId());
            List<String> rolesUserString = new ArrayList<>();
            if (rolesUser != null) {
                for (String role : rolesUser) {
                    rolesUserString.add(role);
                }
            }

            List<RoleEntity> roles = roleService.getRoles();
            List<RoleEntity> rolesList = new ArrayList<>();
            rolesList.add(roles.get(1));
            for (String roleUserString : rolesUserString) {
                for (RoleEntity r : roles) {
                    if (String.valueOf(r.getId()).equals(roleUserString)) {
                        rolesList.add(r);
                    }
                }
            }

            List<UserRoleEntity> roleUserList = new ArrayList<>();
            for (RoleEntity r : rolesList) {
                UserRoleEntity roleU = new UserRoleEntity(user, r);
                roleUserList.add(roleU);
            }
            user.setUserRoles(roleUserList);
            userService.saveUser(user);
        }
    }

}
