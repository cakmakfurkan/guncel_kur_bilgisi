import 'package:flutter/material.dart';
import 'package:guncel_kur_bilgisi/currency_card.dart';
import 'package:guncel_kur_bilgisi/currency_data_table.dart';
import 'package:guncel_kur_bilgisi/models/currency_model.dart';
import 'package:guncel_kur_bilgisi/screens/exchange_screen.dart';
import 'package:guncel_kur_bilgisi/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Currency currencyData;
  Future<Currency> futureCurrency;
  static String apiURL = "https://api.exchangeratesapi.io/latest?base=TRY";
  ApiService apiService = new ApiService(apiURL);
  //List<String> currency = ["EUR", "USD"];
  @override
  void initState() {
    super.initState();
    futureCurrency = apiService.getCurrentCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Döviz Kur Fiyatları"),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    child:
                        Expanded(child: Image.asset("lib/assets/avatar.jpg"))),
              ),
              ListTile(
                title: Text("Döviz Çevir"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ExchangeScreen(
                            data: currencyData,
                          )));
                },
              ),
            ],
          ),
        ),
        body: Center(
            child: FutureBuilder<Currency>(
          future: futureCurrency,
          builder: (context, snapshot) {
            currencyData = snapshot.data;
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CurrencyCard(data: snapshot.data, currency: "EUR"),
                          CurrencyCard(data: snapshot.data, currency: "USD"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CurrencyCard(data: snapshot.data, currency: "GBP"),
                          CurrencyCard(data: snapshot.data, currency: "AUD"),
                        ],
                      ),
                    ],
                  ),
                  CurrencyDataTable(
                    data: snapshot.data,
                  )
                ],
              );
            } else
              return CircularProgressIndicator();
          },
        )));
  }
}
