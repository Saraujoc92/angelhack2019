import 'package:financial_advisor/screens/profile/profile.dart';
import 'package:financial_advisor/widgets/add_expense.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> body;
  bool addingExpense = false;

  @override
  void initState() {
    body = [
      Container(
        child: IconButton(
          icon: Icon(Icons.settings),
          onPressed: goToSettings,
        ),
      ),
    ];
    super.initState();
  }

  goToSettings() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }

  addExpense() {
    debugPrint('adding expense');
    Widget expenseCard = Card(
      child: Center(child: AddExpense()),
    );
    setState(() {
      body.add(expenseCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addingExpense ? null : addExpense,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
