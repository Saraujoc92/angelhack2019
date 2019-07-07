import 'package:financial_advisor/services/profile.dart';
import 'package:financial_advisor/utils/date.dart';
import 'package:financial_advisor/widgets/calendar.dart';
import 'package:financial_advisor/widgets/expense_graph.dart';
import 'package:flutter/material.dart';

class Forecast extends StatefulWidget {
  final List<double> payments;

  Forecast({this.payments});

  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulador de Compra'),
      ),
      body: Column(
        children: <Widget>[
          Spacer(),
          ExpenseGraph(
            expensesList: [widget.payments],
          ),
          SizedBox(height: 20),
          Calendar(
            payments: widget.payments,
          ),
          Spacer(),
          RaisedButton(
            onPressed: _programPayments,
            child: Text('Programar compra'),
          ),
          Spacer(),
        ],
      ),
    );
  }

  _programPayments() {
    ProfileService().payments = widget.payments;
    Navigator.pop(context, true);
  }
}
