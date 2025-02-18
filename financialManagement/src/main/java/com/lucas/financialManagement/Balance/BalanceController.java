package com.lucas.financialManagement.Balance;

import com.lucas.financialManagement.Transaction.Transaction;
import com.lucas.financialManagement.Transaction.TransactionService;
import com.lucas.financialManagement.Transaction.TransactionType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/balance")
public class BalanceController {
    @Autowired
    private BalanceService balanceService;

    @GetMapping("/month")
    public ResponseEntity<Object> getMonthBalance() {
        try {
            Double balance = balanceService.getCurrentMonthBalance();
            return ResponseEntity.ok(balance);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("An unexpected error occurred: " + e.getMessage());
        }
    }

}
