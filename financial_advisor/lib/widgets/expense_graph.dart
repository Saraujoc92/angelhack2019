import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseGraph extends StatelessWidget {
  final List<List<double>> expensesList;

  ExpenseGraph({this.expensesList});

  _datetimePlus(index) {
    var month;
    var year;
    var currentDate = DateTime.now();
    if (currentDate.month + index > 12) {
      month = (currentDate.month + index) % 12;
      year = currentDate.year + ((currentDate.month + index) ~/ 12);
    } else {
      month = currentDate.month + index;
      year = currentDate.year;
    }
    return DateTime(year, month);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('expensesList 0: ${expensesList[0]} ');
    var series = expensesList
        .map(
          (expenseList) => new charts.Series<double, DateTime>(
            id: 'expense',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (_, int index) => _datetimePlus(index),
            measureFn: (double expense, _) => expense,
            data: expenseList,
          ),
        )
        .toList();

    return Container(
      constraints: BoxConstraints(maxHeight: 200, maxWidth: 300),
      child: charts.TimeSeriesChart(
        series,
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      ),
    );
  }
}
