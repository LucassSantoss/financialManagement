class TransactionModel {
  final int id;
  final String description;
  final double amount;
  final DateTime date;
  final String transactionType;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.transactionType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      transactionType: json['transaction_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'transaction_type': transactionType,
    };
  }

  @override
  String toString() {
    return 'TransactionModel{id: $id, description: $description, amount: $amount, date: $date, transactionType: $transactionType}';
  }
}
