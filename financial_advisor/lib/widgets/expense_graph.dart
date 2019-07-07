import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseGraph extends StatelessWidget {
  final List<List<double>> expensesList;
  final double income;

  ExpenseGraph({this.expensesList, this.income});

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
            colorFn: (double expense, __) {
              if (this.income == null || this.income == 0)
                return charts.MaterialPalette.red.shadeDefault;
              if (expense / this.income > .7)
                return charts.MaterialPalette.red.shadeDefault;
              if (expense / this.income < .3)
                return charts.MaterialPalette.green.shadeDefault;
              return charts.MaterialPalette.deepOrange.shadeDefault;

              //   percentage >= 70
              // ? Colors.lightGreen
              // : percentage <= 30 ? Colors.red : Colors.orange,
            },
            domainFn: (_, int index) => _datetimePlus(index),
            measureFn: (double expense, _) => expense,
            data: expenseList,
          ),
        )
        .toList();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Cuotas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 25),
          Container(
            constraints: BoxConstraints(maxHeight: 200, maxWidth: 300),
            child: charts.TimeSeriesChart(series,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                defaultInteractions: false,
                behaviors: [
                  new charts.SelectNearest(),
                  new charts.DomainHighlighter()
                ]),
          ),
        ],
      ),
    );
  }
}
