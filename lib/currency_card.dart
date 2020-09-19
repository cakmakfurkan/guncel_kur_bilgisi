import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/currency_model.dart';

class CurrencyCard extends StatefulWidget {
  final String currency;
  final Currency data;
  CurrencyCard({this.currency, this.data});

  @override
  _CurrencyCardState createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  String currency;
  Currency data;
  @override
  void initState() {
    currency = widget.currency;
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 100,
      child: Card(
        color: Colors.blue[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 50,
              child: Card(
                color: Colors.white38,
                child: Center(
                    child:
                        Text(currency, style: TextStyle(color: Colors.black))),
              ),
            ),
            Center(
              child: Text((1 / data.rates[currency]).toStringAsFixed(4),
                  style: TextStyle(color: Colors.black)),
            ),
            Center(child: Text("TL", style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
