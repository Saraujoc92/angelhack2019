import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddExpense extends StatefulWidget {
  AddExpense({Key key}) : super(key: key);
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: Column(children: <Widget>[
        Center(
          child: Text('Añadir una compra'),
        ),
        Spacer(),
        FormBuilderTextField(
          attribute: "cost",
          decoration: InputDecoration(labelText: "Precio"),
          validators: [
            FormBuilderValidators.numeric(),
          ],
        ),
        FormBuilderTextField(
          attribute: "split",
          decoration: InputDecoration(labelText: "Cuotas"),
          validators: [
            FormBuilderValidators.numeric(),
            FormBuilderValidators.max(48),
          ],
        ),
        Spacer(),
        MaterialButton(
          child: Text("Calcular"),
          onPressed: () {
            _fbKey.currentState.save();
            if (_fbKey.currentState.validate()) {
              print(_fbKey.currentState.value);
            }
          },
        ),
      ]),
    );
  }
}
