package com.lucas.financialManagement.Transaction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/transaction")
public class TransactionController {
    @Autowired
    private TransactionService transactionService;

    @PostMapping
    public ResponseEntity<Object> createTransaction(@RequestBody Transaction transaction) {
        try {
            if (transaction == null || transaction.getAmount() <= 0)
                return ResponseEntity.badRequest().body("Invalid transaction: amount must be greater than zero");
            Transaction newTransaction = transactionService.saveTransaction(transaction);
            return ResponseEntity.status(201).body(newTransaction);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("Invalid request: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(500).body("An unexpected error occurred: " + e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<Object> getAllTransactions() {
        try {
            List<Transaction> transactions = transactionService.getAllTransactions();
            if (transactions == null || transactions.isEmpty())
                return ResponseEntity.badRequest().body("No transactions found");

            return ResponseEntity.status(200).body(transactions);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("An unexpected error occurred: " + e.getMessage());
        }
    }

    @GetMapping("/month")
    public ResponseEntity<Object> getMonthTransactions() {
        try {
            List<Transaction> transactions = transactionService.getMonthTransactions();
            if (transactions == null || transactions.isEmpty())
                return ResponseEntity.badRequest().body("No transactions found");
            return ResponseEntity.status(200).body(transactions);

        } catch (Exception e) {
            return ResponseEntity.status(500).body("An unexpected error occurred: " + e.getMessage());
        }
    }

}
