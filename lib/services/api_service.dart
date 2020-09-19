import 'dart:convert';
import 'package:guncel_kur_bilgisi/models/currency_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiURL;
  ApiService(this.apiURL);

  Future<Currency> getCurrentCurrency() async {
    final response = await http.get(apiURL);
    if (response.statusCode == 200) {
      return Currency.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can't get data");
    }
  }
}
