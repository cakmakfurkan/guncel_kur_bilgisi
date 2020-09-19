import 'package:flutter/material.dart';
import 'package:guncel_kur_bilgisi/models/currency_model.dart';
import 'package:guncel_kur_bilgisi/services/api_service.dart';

class ExchangeScreen extends StatefulWidget {
  final Currency data;
  ExchangeScreen({this.data});

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  Future<Currency> futureCurrency;
  Currency data;
  bool _textVisible = false;
  static String apiURL = "https://api.exchangeratesapi.io/latest?base=TRY";
  ApiService apiService = new ApiService(apiURL);
  final myController = TextEditingController();

  List<DropdownMenuItem<String>> _baseDropdownMenuItems;
  List<DropdownMenuItem<String>> _convertedDropdownMenuItems;

  String _selectedBaseCurrency;
  String _selectedConvertedCurrency;

  @override
  void initState() {
    super.initState();

    data = widget.data;
    myController.text = "1";
    _baseDropdownMenuItems = buildDropdownMenuItems(data);
    _convertedDropdownMenuItems = buildDropdownMenuItems(data);

    _selectedBaseCurrency = _baseDropdownMenuItems[0].value;
    _selectedConvertedCurrency = _convertedDropdownMenuItems[0].value;
    exchangeCurrent(_selectedBaseCurrency, _selectedConvertedCurrency);
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(Currency currency) {
    List<DropdownMenuItem<String>> items = List();
    var dataList = currency.rates.entries.toList();

    dataList.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.key,
        child: Text(element.key),
      ));
    });
    return items;
  }

  void textVisibleState() {
    setState(() {
      _textVisible = true;
    });
  }

  onChangeBaseDropdownItem(String currency) {
    setState(() {
      _textVisible = false;
      _selectedBaseCurrency = currency;
    });
  }

  onChangeConvertedDropdownItem(String currency) {
    setState(() {
      _textVisible = false;
      _selectedConvertedCurrency = currency;
    });
  }

  void exchangeCurrent(String base, String converted) {
    String newApiURL =
        "https://api.exchangeratesapi.io/latest?symbols=${base}&base=${converted}";
    ApiService newApiService = new ApiService(newApiURL);
    futureCurrency = newApiService.getCurrentCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Döviz Kur Çevirici"),
        ),
        body: Center(
            child: FutureBuilder<Currency>(
          future: futureCurrency,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Dönüştürmek istediğiniz miktarı giriniz:"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: myController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Neyden:"),
                          DropdownButton(
                              items: _baseDropdownMenuItems,
                              value: _selectedBaseCurrency,
                              onChanged: onChangeBaseDropdownItem),
                          Text("Neye:"),
                          DropdownButton(
                              items: _convertedDropdownMenuItems,
                              value: _selectedConvertedCurrency,
                              onChanged: onChangeConvertedDropdownItem),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.blue[100],
                        onPressed: () {
                          exchangeCurrent(_selectedBaseCurrency,
                              _selectedConvertedCurrency);
                          textVisibleState();
                        },
                        child:
                            const Text('Çevir', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Visibility(
                      visible: _textVisible,
                      child: snapshot.data.rates[_selectedBaseCurrency] != null
                          ? Text(
                              "${myController.text} ${_selectedBaseCurrency} = ${(double.parse(myController.text) / (snapshot.data.rates[_selectedBaseCurrency])).toStringAsFixed(4)} ${_selectedConvertedCurrency}",
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic))
                          : Text(""),
                    ),
                  ],
                ),
              ));
            } else
              return CircularProgressIndicator();
          },
        )));
  }
}
