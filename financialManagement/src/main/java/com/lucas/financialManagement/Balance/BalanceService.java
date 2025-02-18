package com.lucas.financialManagement.Balance;

import com.lucas.financialManagement.Transaction.Transaction;
import com.lucas.financialManagement.Transaction.TransactionService;
import com.lucas.financialManagement.Transaction.TransactionType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BalanceService {
    @Autowired
    TransactionService transactionService;

    public Double getCurrentMonthBalance() {
        List<Transaction> transactions = transactionService.getMonthTransactions();

        double totalIncome = transactions.stream()
                .filter(t -> t.getTransaction_type() == TransactionType.INCOME)
                .mapToDouble(Transaction::getAmount)
                .sum();

        double totalExpense = transactions.stream()
                .filter(t -> t.getTransaction_type() == TransactionType.EXPENSE)
                .mapToDouble(Transaction::getAmount)
                .sum();

        return totalIncome - totalExpense;
    }
}
