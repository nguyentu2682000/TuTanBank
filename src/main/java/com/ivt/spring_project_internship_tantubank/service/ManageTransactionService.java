/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.service;

import com.ivt.spring_project_internship_tantubank.entities.TransactionEntity;
import com.ivt.spring_project_internship_tantubank.entities.UserEntity;
import com.ivt.spring_project_internship_tantubank.repository.TransactionRepository;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 *
 * @author henry
 */
@Service
public class ManageTransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

   
     public boolean searchManageTransaction(String searchValue, Optional<Integer> page, Optional<Integer> size,
            Model model) {
        model.addAttribute("action", "search_transaction");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<TransactionEntity> transactions = searchTransaction(searchValue, currentPage - 1, pageSize, Sort.by("id").descending());
        if (transactions != null) {
            int totalPages = transactions.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("transactions", transactions);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return true;
    }


    public boolean viewsTransaction(Optional<Integer> page, Optional<Integer> size, Model model) {
        model.addAttribute("action", "transaction");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);
        Page<TransactionEntity> transactions = getTransactionPagination(currentPage - 1, pageSize, Sort.by("transactionDate").descending());
          if (transactions != null) {
            int totalPages = transactions.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("transactions", transactions);
        }
        return true;
    }
    
     public Page<TransactionEntity> getTransactionPagination(int currentPage, int pageSize, Sort sort) {
        Page<TransactionEntity> transactions = transactionRepository.findTransaction(PageRequest.of(currentPage, pageSize, sort));
        if (!transactions.isEmpty()) {
            return transactions;
        }
        return null;
    }
    
     public Page<TransactionEntity> searchTransaction(String search, int currentPage, int pageSize, Sort sort){
        Page<TransactionEntity>  transactions= transactionRepository.findTransactionByBankAccountById(search, search, "%"+search+"%", PageRequest.of(currentPage, pageSize, sort));
        if(!transactions.isEmpty()){
            return transactions;
        }
        return  null;
    }
     
}