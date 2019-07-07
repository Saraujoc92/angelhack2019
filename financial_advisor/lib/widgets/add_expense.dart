import 'package:badges/badges.dart';
import 'package:financial_advisor/screens/forecast/forecast.dart';
import 'package:financial_advisor/services/cuotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddExpense extends StatefulWidget {
  AddExpense({Key key}) : super(key: key);
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: FormBuilder(
        key: _fbKey,
        child: Column(children: <Widget>[
          Spacer(),
          Center(
            child: Text(
              'Simulador de crédito',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Spacer(),
          FormBuilderTextField(
            attribute: "cost",
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Precio"),
            validators: [
              FormBuilderValidators.numeric(),
            ],
          ),
          FormBuilderTextField(
            attribute: "split",
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Cuotas"),
            validators: [
              FormBuilderValidators.numeric(),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              tile('TV'),
              tile('Celular'),
              tile('Mercado'),
              tile('Videojuegos'),
            ],
          ),
          RaisedButton(
            child: Text("Calcular"),
            onPressed: () {
              _fbKey.currentState.save();
              if (_fbKey.currentState.validate()) {
                _calculateCuotation(_fbKey.currentState.value);
              }
            },
          ),
          Spacer(),
        ]),
      ),
    );
  }

  Widget tile(category) {
    return GestureDetector(
      onTap: () => setState(() => this.category = category),
      child: Badge(
        badgeColor:
            this.category == category ? Colors.lightBlueAccent : Colors.blue,
        shape: BadgeShape.square,
        borderRadius: 20,
        toAnimate: false,
        badgeContent: Padding(
          padding: EdgeInsets.all(5),
          child: Text(category, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  _calculateCuotation(data) async {
    var cost = data['cost'];
    var split = data['split'];
    var simulationWithCuotation = await MockCuotationProvider()
        .getSimulationWithCuotationCount(double.parse(cost), int.parse(split));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => Forecast(
          payments: simulationWithCuotation,
        ),
      ),
    );
  }
}
