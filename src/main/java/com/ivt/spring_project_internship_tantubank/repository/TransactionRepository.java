/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_project_internship_tantubank.repository;

import com.ivt.spring_project_internship_tantubank.entities.BankAccountEntity;
import com.ivt.spring_project_internship_tantubank.entities.TransactionEntity;
import java.util.Date;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author TanHegemony
 */
@Repository
public interface TransactionRepository extends CrudRepository<TransactionEntity, Long>{
    
    @Query("SELECT t FROM TransactionEntity t")
    Page<TransactionEntity> findTransaction(Pageable pageable);

    @Query(value = "SELECT * FROM transaction as t "
            + "join bankaccount as ba "
            + "on t.bankAccountId2 = ba.id OR t.bankAccountId1 = ba.id "
            + "where ba.account_number = ?1 or t.id = ?2 or t.tantubank_address like ?3", nativeQuery = true)
    Page<TransactionEntity> findTransactionByBankAccountById(String BankAccount,String id, String tantubankAddress ,Pageable pageable);
    
    @Query("SELECT t FROM TransactionEntity t WHERE t.bankAccount1 = ?1 OR t.bankAccount2 = ?2")
    Page<TransactionEntity> findTransactionByBankAccount(BankAccountEntity bankAccount1 ,BankAccountEntity bankAccount2, Pageable pageable);
    
    @Query("SELECT t FROM TransactionEntity t WHERE bankAccount1 = ?1 OR bankAccount2 = ?2 AND transactionContent like ?3 ")
    Page<TransactionEntity> searchTransactionByBankAccountIdAndDate(BankAccountEntity bankAccount1 ,BankAccountEntity bankAccount2, String transactionContent, Pageable pageable);
}
