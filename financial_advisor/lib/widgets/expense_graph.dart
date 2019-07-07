import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseGraph extends StatelessWidget {
  final List<double> expenseList;

  ExpenseGraph({this.expenseList});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<double, int>> expenses = [
      new charts.Series<double, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (double expense, _) => expenseList.indexOf(expense),
        measureFn: (double expense, _) => expense,
        data: expenseList,
      )
    ];
    return Container(
      constraints: BoxConstraints(maxHeight: 200, maxWidth: 300),
      child: charts.LineChart(expenses,
          animate: true,
          defaultRenderer: new charts.LineRendererConfig(includePoints: true)),
    );
  }
}
