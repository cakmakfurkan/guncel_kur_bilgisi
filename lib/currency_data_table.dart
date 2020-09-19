import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/currency_model.dart';

class CurrencyDataTable extends StatefulWidget {
  final Currency data;
  CurrencyDataTable({this.data});

  @override
  _CurrencyDataTableState createState() => _CurrencyDataTableState();
}

class _CurrencyDataTableState extends State<CurrencyDataTable> {
  String currency;
  Currency data;
  var dataList;
  DataRow dataRow;
  @override
  void initState() {
    data = widget.data;
    dataList = data.rates.entries.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Döviz Cinsi',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Alış',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: List<DataRow>.generate(
              data.rates.length,
              (index) => DataRow(
                    cells: [
                      DataCell(Text(dataList[index].key)),
                      DataCell(
                          Text((1 / dataList[index].value).toStringAsFixed(4))),
                    ],
                  ))),
    );
  }
}
