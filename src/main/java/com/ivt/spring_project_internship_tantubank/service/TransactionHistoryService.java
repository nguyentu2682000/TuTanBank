/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.BankAccountEntity;
import com.ivt.spring_project_internship_tantubank.entities.CustomerEntity;
import com.ivt.spring_project_internship_tantubank.entities.TransactionEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.repository.BankAccountRepository;
import com.ivt.spring_project_internship_tantubank.repository.TransactionRepository;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 *
 * @author henry
 */
@Service
public class TransactionHistoryService {

    @Autowired
    private BankAccountService bankAccountService;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    HttpSession session;
    
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public void getTransactionHistory(Model model, Optional<Integer> page, Optional<Integer> size) {
        UserEntity user = (UserEntity) session.getAttribute("userlg");
        BankAccountEntity bankAccount = bankAccountService.searchBankAccountByCustomerId(user.getCustomer().getId());
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<TransactionEntity> transactions = getTransactionHistoryPagination(bankAccount, currentPage - 1, pageSize, Sort.by("id").descending());
        if (transactions != null) {
            int totalPages = transactions.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("transactions", transactions);
        }
        model.addAttribute("action", "transactionHistory");
    }

    public void searchTransactionHistory(String searchValue, Model model, Optional<Integer> page, Optional<Integer> size) {
        UserEntity user = (UserEntity) session.getAttribute("userlg");
        BankAccountEntity bankAccount = bankAccountService.searchBankAccountByCustomerId(user.getCustomer().getId());
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<TransactionEntity> transactions = searchTransactionHistoryByContentByDate(searchValue, bankAccount, currentPage - 1, pageSize, Sort.by("id").descending());
        if (transactions != null) {
            int totalPages = transactions.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("transactions", transactions);
            model.addAttribute("searchValue", searchValue);
        }
        model.addAttribute("action", "search_transactionHistory");
    }

    public Page<TransactionEntity> getTransactionHistoryPagination(BankAccountEntity bankAccount, int currentPage, int pageSize, Sort sort) {
        Page<TransactionEntity> transactions = transactionRepository.findTransactionByBankAccount(bankAccount, bankAccount, PageRequest.of(currentPage, pageSize, sort));
        if (!transactions.isEmpty()) {
            return transactions;
        }
        return null;
    }

    public Page<TransactionEntity> searchTransactionHistoryByContentByDate(String searchValue, BankAccountEntity bankAccount, int currentPage, int pageSize, Sort sort) {
        Page<TransactionEntity> transaction = transactionRepository.searchTransactionByBankAccountIdAndDate(bankAccount, bankAccount, searchValue + "%", PageRequest.of(currentPage, pageSize, sort));
        if (!transaction.isEmpty()) {
            return transaction;
        }
        return null;
    }
}
