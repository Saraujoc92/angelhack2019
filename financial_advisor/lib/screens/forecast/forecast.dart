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
  double income;

  @override
  void initState() {
    income = 0;
    _getIncome();
    super.initState();
  }

  _getIncome() async {
    var profile = await ProfileService().profile;
    setState(() {
      income =
          (profile.data.containsKey('income') && profile.data['income'] != null)
              ? double.parse(profile.data['income'])
              : null;
    });
  }

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
            income: income,
          ),
          SizedBox(height: 20),
          Calendar(
            payments: widget.payments,
          ),
          Spacer(),
          RaisedButton(
            color: Colors.red,
            onPressed: _programPayments,
            child: Text('Programar compra', style: TextStyle(color: Colors.white),),
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
