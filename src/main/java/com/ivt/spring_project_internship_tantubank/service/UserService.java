/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.RoleEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserRoleEntity;
import com.ivt.spring_project_internship_tantubank.enums.UserStatus;
import com.ivt.spring_project_internship_tantubank.repository.UserRepository;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.RandomStringUtils;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

/**
 *
 * @author henry
 */
@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleService roleService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    HttpSession session;

    @Autowired
    JavaMailSender mailSender;

    @Autowired
    private UserService userService;

    public void sendMail(String from, String to, String subject, String content) throws MessagingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        boolean multipart = true;
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, multipart, "utf-8");
        helper.setFrom(from);
        helper.setTo(to);
        helper.setSubject(subject);
        mimeMessage.setContent(content, "text/html; charset=utf-8");

        mailSender.send(mimeMessage);
    }

    public UserEntity findByUserName(String userName) {
        UserEntity user = userRepository.findByUserName(userName);
        if (user != null && user.getId() > 0) {
            return user;
        }
        return new UserEntity();
    }

    public void saveUser(UserEntity user) {

        userRepository.save(user);
    }

    @Transactional
    public UserEntity findByUserById(long id) {
        Optional<UserEntity> userId = userRepository.findById(id);
        if (userId != null && userId.isPresent()) {
            Hibernate.initialize(userId.get().getUserRoles());
            return userId.get();
        }
        return new UserEntity();
    }

//    show list have page
    @Transactional
    public Page<UserEntity> getUserPagination(int currentPage, int pageSize, Sort sort) {
        Page<UserEntity> users = userRepository.findUser(PageRequest.of(currentPage, pageSize, sort));
        if (!users.isEmpty()) {
            for (UserEntity user : users) {
                Hibernate.initialize(user.getUserRoles());
            }
            return users;
        }
        return null;
    }

    // Search user list
    @Transactional
    public Page<UserEntity> searchUse(String search, int currentPage, int pageSize, Sort sort) {
        Page<UserEntity> users = userRepository.findByUserByUserNameByStatus(search + "%", search, PageRequest.of(currentPage, pageSize, sort));
        if (!users.isEmpty()) {
            for (UserEntity user : users) {
                Hibernate.initialize(user.getUserRoles());
            }
            return users;
        }
        return null;
    }

    public boolean addRegister(Model model, String userName, String password,
            String customerName, String customerEmail,
            String customerPhone, String passwordAgain, String CINumber,
            String issueDate, String issuePlace, String captcha)
            throws MessagingException, ParseException {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        UserEntity user = new UserEntity();
        user.setUserName(userName);
        user.setPassword(encoder.encode(password));
        user.setCreateDate(new Date());
        user.setUserStatus(UserStatus.ACTIVE);

        List<UserRoleEntity> roleList = new ArrayList<>();
        UserRoleEntity roleA = new UserRoleEntity();
        List<RoleEntity> roles = roleService.getRoles();
        roleA.setRole(roles.get(1));
        roleA.setUser(user);
        System.out.println(user);
        roleList.add(roleA);
        user.setUserRoles(roleList);
        System.out.println(roleList);
        if (!captcha.equals(session.getAttribute("captcha"))) {
            model.addAttribute("message", "Captcha không chính xác");
            String reloadCaptcha = RandomStringUtils.randomAlphanumeric(6);
            session.setAttribute("captcha", reloadCaptcha);
        } else {
            UserEntity userNameEt = userService.findByUserName(userName);
            if (userNameEt.getId() > 0) {
                model.addAttribute("message", "Tài khoản đã tồn tại");
            } else {
                String pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&-+=]).{6,}$";
                if (password.matches(pattern) == false) {
                    model.addAttribute("message", "Mật khẩu sai định dạng!! Vui lòng kiểm tra lại!!");
                } else {
                    if (password.equals(passwordAgain) == false) {
                        model.addAttribute("message", "Nhập lại mật khảu không trùng");
                    } else {
                        CustomerEntity customerCustomerEmail = customerService.findCustomerByCustomerEmail(customerEmail);
                        if (customerCustomerEmail.getId() > 0) {
                            model.addAttribute("message", "Email này đã được sử dụng!!");
                        } else {
                            CustomerEntity customerCustomerPhone = customerService.findCustomerByCustomerPhone(customerPhone);
                            if (customerCustomerPhone.getId() > 0) {
                                model.addAttribute("message", "Số điện thoại này đã được sử dụng!!");
                            } else {
                                if (customerPhone.length() < 10 || customerPhone.length() > 12) {
                                    model.addAttribute("message", "Số điện thoại này không đúng định dạng!!");
                                } else {
                                    if (CINumber.length() < 11 || CINumber.length() > 13) {
                                        model.addAttribute("message", "Số căn cước không đúng định dạng !!");
                                    } else {
                                        CustomerEntity customerCINumber = customerService.findCustomerByCINumber(CINumber);
                                        if (customerCINumber.getId() > 0) {
                                            model.addAttribute("message", "Số căn cước công dân đã được dùng !!");
                                        } else {
                                            session.setAttribute("user", user);
                                            CustomerEntity customer = new CustomerEntity();
                                            customer.setCustomerName(customerName);
                                            customer.setCustomerEmail(customerEmail);
                                            customer.setCustomerPhone(customerPhone);
                                            customer.setIssuePlace(issuePlace);
                                            customer.setCINumber(CINumber);
                                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                            Date date = sdf.parse(issueDate);
                                            customer.setIssueDate(date);
                                            customer.setUser(user);
                                            session.setAttribute("customer", customer);
                                            String randomNumeric = RandomStringUtils.randomNumeric(6);
                                            String subject = "Xác nhận thông tin đăng ký tài khoản tại TanTuBank";
                                            String content = "<h1>Bạn vui lòng nhập mã số gồm 6 ký tự vào khung xác nhận đăng ký!</h1>"
                                                    + "<h3 style='text-align:center'>Mã gồm 6 ký tự số: <b>" + randomNumeric + "</b></h3>";
                                            sendMail("natsutan94@gmail.com", customerEmail, subject, content);
                                            session.setAttribute("randomNumericConfirmRegister", randomNumeric);
                                            session.setMaxInactiveInterval(60);
                                            model.addAttribute("Email", customerEmail);
                                            return true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return false;
    }
}
