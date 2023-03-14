/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ibm.icu.text.RuleBasedNumberFormat;
import com.ivt.spring_project_internship_tantubank.entities.BankAccountEntity;
import com.ivt.spring_project_internship_tantubank.entities.StaffEntity;
import com.ivt.spring_project_internship_tantubank.entities.TransactionEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.enums.TransactionType;
import com.ivt.spring_project_internship_tantubank.repository.TransactionRepository;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Currency;
import java.util.Date;
import java.util.Locale;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 *
 * @author henry
 */
@Service
public class WithdrawService {

    @Autowired
    HttpSession session;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private BankAccountService bankAccountService;

    @Autowired
    private BankService bankService;

    @Autowired
    private TanTuBankAddressService tanTuBankAddressService;

    @Autowired
    private TransactionService transactionService;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public boolean viewSearchWithdraw(String valueSearch, Model model) {
        if (valueSearch.isBlank()) {
            model.addAttribute("error", "không được để trống");
            model.addAttribute("valueSearch", valueSearch);
            model.addAttribute("action", "search");
            return false;
        } else {
            BankAccountEntity bankAccount = bankAccountService.findbankAccountByCiNumberOrAccountNumber(valueSearch);
            session.setAttribute("bankAccount", new BankAccountEntity());
            if (bankAccount.getId() > 0) {
                model.addAttribute("bankAccount", bankAccount);
                session.setAttribute("bankAccount", bankAccount);
                model.addAttribute("tantuBankAddress", tanTuBankAddressService.getTanTuBankAddressList());
                model.addAttribute("search", true);
                return true;
            } else {
                model.addAttribute("action", "search");
                model.addAttribute("valueSearch", valueSearch);
                model.addAttribute("error", "không tìm thấy tài khoản");
                return false;
            }
        }
    }

    public boolean withdraw(String balanceSt, String tantuBankAddress, Model model) throws MessagingException {
        if (balanceSt.isBlank()) {
            model.addAttribute("search", true);
            model.addAttribute("ErrorMessage", "Không được để trống ");
            model.addAttribute("tantuBankAddress", tanTuBankAddressService.getTanTuBankAddressList());
        } else {
            double balance = Double.valueOf(balanceSt);
            BankAccountEntity bankAccount = (BankAccountEntity) session.getAttribute("bankAccount");
            if (bankAccount.getId() > 0) {
                if (balance > bankAccount.getBalance()) {
                    model.addAttribute("search", true);
                    model.addAttribute("ErrorMessage", "Số dư tài khoản không khả dụng");
                } else {
                    double withdraw = bankAccount.getBalance() - balance;
                    bankAccount.setBalance(withdraw);
                    TransactionEntity transaction = new TransactionEntity();
                    transaction.setTransactionDate(new Timestamp(new Date().getTime()));
                    transaction.setTransactionAmount(balance);
                    transaction.setTantuBankAddress(tantuBankAddress);
                    if (bankAccount.getAccountType().equalsIgnoreCase("PAYMENT_ACCOUNT")) {
                        transaction.setTransactionType(TransactionType.WITHDRAW_PAYMENT_ACCOUNT);
                        transaction.setTransactionContent("RTTT Quy khach yeu cau TanTuBank rut tien mat");
                    } else {
                        transaction.setTransactionType(TransactionType.WITHDRAW_SAVING_ACCOUNT);
                        transaction.setTransactionContent("RTTk Quy khach yeu cau TanTuBank rut tien mat");
                    }
                    transaction.setBankAccount1(bankAccount);
                    StaffEntity staff = (StaffEntity) session.getAttribute("staff");
                    transaction.setStaff(staff);
                    String moneyText = convertMoneyToText(balance);
                    
                    
                    transactionRepository.save(transaction);
                    bankAccountService.saveOrUpdateBankAccount(bankAccount);
                    
                    
                    model.addAttribute("print", true);
                    model.addAttribute("code1", bankAccount.getId());
                    model.addAttribute("code2", transaction.getId());
                    model.addAttribute("moneyText", moneyText);
                    model.addAttribute("moneyNumber", balance);
                    model.addAttribute("Date", sdf.format(new Date()));
                    model.addAttribute("bankAccount", bankAccount);
                    
                    
                    String availablebl = printCurrency(bankAccount.getBalance());
                    String ps = printCurrency(balance);
                    String subjectEmailReceive = "TanTuBank";
                    String contentEmailReceive = "<h2>TK:" + bankAccount.getAccountNumber()
                            + "<h2>ps: -" + ps + " </h2>"
                            + "<h2>So dung kha dung: " + availablebl + "</h2>";
                    transactionService.sendMail("testsendtu@gmail.com", transaction.getBankAccount1().getCustomer().getCustomerEmail(), subjectEmailReceive, contentEmailReceive);
                    
                    session.setAttribute("bankAccount", new BankAccountEntity());
                    return true;
                }
            }
        }
        return false;
    }

    public static String convertMoneyToText(double input) {
        long inputL = (long) input;
        String balanceST = String.valueOf(inputL);
        String output = "";
        try {
            RuleBasedNumberFormat ruleBasedNumberFormat = new RuleBasedNumberFormat(new Locale("vi", "VN"), RuleBasedNumberFormat.SPELLOUT);
            output = ruleBasedNumberFormat.format(Long.parseLong(balanceST)) + " ĐỒNG";
        } catch (NumberFormatException e) {
            output = "không đồng";
        }
        return output.toUpperCase();
    }

    public static String printCurrency(double currencyAmount) {
        Locale locale = new Locale("vi", "VN");
        String output = "";
        try {
            NumberFormat numberFormat = NumberFormat.getCurrencyInstance(locale);
            output = numberFormat.format(currencyAmount);
        } catch (NumberFormatException e) {
                output = "";
        }
        return output.toUpperCase();
    }

}
