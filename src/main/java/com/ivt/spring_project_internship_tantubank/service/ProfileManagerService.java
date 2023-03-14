/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 *
 * @author henry
 */
@Service
public class ProfileManagerService {

    @Autowired
    HttpSession session;

    @Autowired
    JavaMailSender mailSender;

    @Autowired
    private CustomerService customerService;
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

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

    public boolean checkEmail(Model model, String email) throws MessagingException {
        CustomerEntity customerEmail = customerService.findCustomerByCustomerEmail(email);
        String pattern = "^[a-z][a-z0-9_\\s.]{5,32}@[a-z0-9]{2,}(\\.[a-z0-9]{2,4}){1,2}$";
        if (email.matches(pattern) == false) {
            model.addAttribute("messageCeError", "Email không đúng định dạng");
        } else {
            if (customerEmail.getId() > 0) {
                model.addAttribute("messageCeError", "Email đã được đăng ký ở một tài khoản khác");
            } else {
                session.setAttribute("email", email);
                String randomNumeric = RandomStringUtils.randomNumeric(6);
                String subject = "Xác nhận thông tin TanTuBank";
                String content = "<h1>Bạn vui lòng nhập mã để xác thực email!</h1>"
                        + "<h3 style='text-align:center'>Mã gồm 6 ký tự số: <b>" + randomNumeric + "</b></h3>";
                sendMail("testsendtu@gmail.com", email, subject, content);
                session.setAttribute("randomNumericConfirmRegister", randomNumeric);
                session.setMaxInactiveInterval(60);
                model.addAttribute("Email", customerEmail.getCustomerEmail());
                return true;

            }
        }
        return false;
    }

    public boolean seveEmail(Model model, String confirmCode) {
        String email = (String) session.getAttribute("email");
        UserEntity user = (UserEntity) session.getAttribute("userlg");
        String randomNumeric = (String) session.getAttribute("randomNumericConfirmRegister");
        if (confirmCode.equals(randomNumeric) == false) {
            model.addAttribute("messageCeError", "Mã sác nhận sai");
        } else {
            CustomerEntity customer = customerService.viewCustomerById(user.getCustomer().getId());
            if (customer.getId() > 0) {
                customer.setCustomerEmail(email);
                customerService.saveOrUpdateCustomer(customer);
                model.addAttribute("messageSus", "Đỗi email thành công");
                return true;
            }
        }
        return false;
    }
    
    public void saveCustomer(Model model, CustomerEntity customerInput){
         UserEntity user = (UserEntity) session.getAttribute("userlg");
        CustomerEntity customer = customerService.viewCustomerById(user.getCustomer().getId());
            if (customer.getId() > 0) {
                customer.setCustomerName(customerInput.getCustomerName());
                customer.setCustomerPhone(customerInput.getCustomerPhone());
                customer.setBirthDate(customerInput.getBirthDate());
                customer.setGender(customerInput.getGender());
                customer.setNation(customerInput.getNation());
                customer.setCustomerAddress(customerInput.getCustomerAddress());
                customerService.saveOrUpdateCustomer(customer);
            }
    }
}
