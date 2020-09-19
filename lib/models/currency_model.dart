import 'dart:collection';

class Currency {
  final LinkedHashMap rates;
  final String base;
  final String date;

  Currency({this.rates, this.base, this.date});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
        rates: json["rates"], base: json["base"], date: json["date"]);
  }
}
