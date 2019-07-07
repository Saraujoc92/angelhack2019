import 'package:financial_advisor/screens/SplashScreen.dart';
import 'package:financial_advisor/screens/forecast/forecast.dart';
import 'package:financial_advisor/screens/help/help.dart';
import 'package:financial_advisor/screens/profile/profile.dart';
import 'package:financial_advisor/screens/promos/promos.dart';
import 'package:financial_advisor/services/profile.dart';
import 'package:financial_advisor/widgets/add_expense.dart';
import 'package:financial_advisor/widgets/expense_graph.dart';
import 'package:financial_advisor/widgets/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> body;
  bool addingExpense = false;

  Map<String, dynamic> profile;

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    debugPrint('onWillPop: $addingExpense');
    if (addingExpense) {
      setState(() {
        addingExpense = false;
      });
      return false;
    }
    return true;
  }

  goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    ).then((refresh) {
      _refresh();
    });
  }

  _refresh() async {
    var profile = await ProfileService().profile;
    setState(() {
      addingExpense = false;
      this.profile = profile.data;
    });
  }

  addExpenseBg() {
    if (!addingExpense) return Container();
    return Opacity(
      opacity: 0.5,
      child: Container(color: Colors.black),
    );
  }

  addExpense() {
    if (!addingExpense) return Container();

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 80, 10, 80),
      child: Card(
        child: Container(
          child: AddExpense(refresh: _refresh),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
      ),
    );
  }

  Widget healthbar() {
    if (!(profile != null &&
        profile.containsKey('income') &&
        profile['income'] != null ))
      return Container();
    var income = int.parse(profile['income']);
    
        
    var payments = profile.containsKey('payments') ? profile['payments'] : [];

    var health = payments.length > 0 ? payments[0] / income : 0;

    debugPrint('income: $income');
    debugPrint('payments: $payments');
    debugPrint('health: $health');
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: HealthBar(percentage: 100 - (health * 100).toInt()),
    );
  }

  Widget paymentGraph() {
    if (!(profile != null &&
        profile.containsKey('payments') &&
        (List<double>.from(profile['payments'])).length > 0))
      return Container();
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: ExpenseGraph(
          expensesList: [List<double>.from(profile['payments'])],
          income: (profile.containsKey('income') && profile['income'] != null)
              ? double.parse(profile['income'])
              : null),
    );
  }

  Widget contentButtons() {
    var section = (image, text, route) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: route),
            );
          },
          child: new Container(
            width: 150.0,
            height: 150.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(image),
                )),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
            ),
          ),
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        section(
          'assets/images/info/info.jpeg',
          'Ayudas',
          (context) => Help(),
        ),
        section(
          'assets/images/info/info2.jpg',
          'Promos',
          (context) => PromoScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Inicio'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: goToSettings,
            ),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
              child: Column(
                children: <Widget>[
                  healthbar(),
                  paymentGraph(),
                  contentButtons(),
                ],
              ),
            ),
            addExpenseBg(),
            addExpense(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              addingExpense ? null : () => setState(() => addingExpense = true),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
