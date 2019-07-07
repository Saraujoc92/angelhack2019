import 'package:financial_advisor/screens/SplashScreen.dart';
import 'package:financial_advisor/screens/forecast/forecast.dart';
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
        .then((refresh) => _refresh());
  }

  _refresh() async {
    var profile = await ProfileService().profile;
    setState(() {
      this.profile = profile.data;
    });
  }

  addExpense() {
    if (!addingExpense) return Container();

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 80, 10, 80),
      child: Card(
        child: Container(
          child: AddExpense(),
        ),
      ),
    );
  }

  Widget healthbar() {
    if (!(profile != null &&
        profile.containsKey('income') &&
        profile.containsKey('payments'))) return Container();
    var income = int.parse(profile['income']);
    var payments = profile['payments'];
    var health = payments[0] / income;

    debugPrint('income: $income');
    debugPrint('payments: $payments');
    debugPrint('health: $health');
    return HealthBar(percentage: (health * 100).toInt());
  }

  Widget paymentGraph() {
    if (!(profile != null && profile.containsKey('payments')))
      return Container();
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child:ExpenseGraph(
      expensesList: [List<double>.from(profile['payments'])],
    ),
    );
  }

  Widget contentButtons() {
    var section = (image, route) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: route),
            );
          },
          child: image,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        section(
          Icon(
            Icons.help,
            size: 100,
          ),
          (context) => SplashScreen(),
        ),
        section(
          Icon(
            Icons.card_giftcard,
            size: 100,
          ),
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
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Stack(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: goToSettings,
              ),
            ),
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
