import 'dart:convert';
import 'package:flutter_financial_management/models/transactionModel.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  final String baseUrl = "http://192.168.0.12:8080";

  Future<List<TransactionModel>> getMonthTransactions() async {
    final url = "$baseUrl/transaction/month";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => TransactionModel.fromJson(json)).toList();
      } else {
        throw Exception("Erro ao obter as transações: ${response.body}");
      }
    } catch (e) {
      throw Exception("Erro de conexão: $e");
    }
  }
}
