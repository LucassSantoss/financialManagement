import 'package:http/http.dart' as http;

class BalanceService {
  final String baseUrl = "http://192.168.0.12:8080";

  Future<double> getMonthBalance() async {
    final url = "$baseUrl/balance/month";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return double.parse(response.body);
      } else {
        throw Exception("Erro ao obter o saldo: ${response.body}");
      }
    } catch (e) {
      throw Exception("Erro de conexão: $e");
    }
  }  
}