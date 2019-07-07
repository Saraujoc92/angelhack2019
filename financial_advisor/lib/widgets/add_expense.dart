import 'package:badges/badges.dart';
import 'package:financial_advisor/screens/forecast/forecast.dart';
import 'package:financial_advisor/services/cuotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  final dynamic refresh;

  AddExpense({this.refresh});
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
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 40.0),
              child: ClipRect(
                child: new Stack(
                  children: [
                    new Positioned(
                      top: 2.0,
                      left: 2.0,
                      child: new Text(
                        'Simulador de crédito',
                        style: Theme.of(context).textTheme.body1.copyWith(
                            fontSize: 28.0, color: Colors.red.withOpacity(0.5)),
                      ),
                    ),
                    new BackdropFilter(
                      filter: new ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      child: new Text('Simulador de crédito',
                          style: TextStyle(fontSize: 28.0, color: Colors.red)),
                    ),
                  ],
                ),
              )),
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              tile('Televisión'),
              tile('Celulares'),
              tile('Mercado'),
              tile('Videojuegos'),
            ],
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
              child: RaisedButton(
                color: Colors.red,
                child: Text('CALCULAR CRÉDITO',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _fbKey.currentState.save();
                  if (_fbKey.currentState.validate()) {
                    _calculateCuotation(_fbKey.currentState.value);
                  }
                },
              ))
        ]),
      ),
    );
  }

  Widget tile(category) {
    return GestureDetector(
      onTap: () => setState(() => this.category = category),
      child: Badge(
        badgeColor: this.category == category ? Colors.lightBlue : Colors.blue,
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
    ).then((refresh) {
      if (refresh) widget.refresh();
    });
  }
}
