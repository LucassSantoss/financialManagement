import 'package:flutter/material.dart';
import 'package:flutter_financial_management/models/transactionModel.dart';
import 'package:flutter_financial_management/services/balanceService.dart';
import 'package:flutter_financial_management/services/transactionService.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<double> balance;
  late Future<List<TransactionModel>> transactions;

  @override
  void initState() {
    super.initState();

    balance = BalanceService().getMonthBalance();
    transactions = TransactionService().getMonthTransactions();

    // Debug para verificar as transações no console
    transactions.then(
      (value) => print("Transactions: $value"),
      onError: (error) => print("Error: $error"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Management')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exibir o saldo do mês
                Text(
                  "Your month balance:",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
                FutureBuilder<double>(
                  future: balance,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      );
                    } else {
                      return Text(
                        "\$${snapshot.data?.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Exibir a lista de transações do mês
                Text(
                  "Transactions:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 10),

                // FutureBuilder para carregar a lista de transações
                FutureBuilder<List<TransactionModel>>(
                  future: transactions,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text("Error: ${snapshot.error}",
                              style: const TextStyle(color: Colors.red)));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No transactions found."));
                    } else {
                      List<TransactionModel> transactionList = snapshot.data!;
                      return SizedBox(
                        height: 300, // Define um tamanho fixo para a lista
                        child: ListView.builder(
                          shrinkWrap: true, // Evita problemas de layout
                          physics: NeverScrollableScrollPhysics(), // Usa o scroll do SingleChildScrollView
                          itemCount: transactionList.length,
                          itemBuilder: (context, index) {
                            TransactionModel transaction = transactionList[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: ListTile(
                                title: Text(transaction.description),
                                subtitle: Text(
                                    "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}"),
                                trailing: Text(
                                  "\$${transaction.amount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: transaction.transactionType ==
                                            "INCOME"
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
