import 'package:financial_advisor/screens/login/LoginScreen.dart';
import 'package:financial_advisor/services/auth.dart';
import 'package:flutter/material.dart';

class ProfileConfig extends StatefulWidget {
  ProfileConfig({Key key}) : super(key: key);

  _ProfileConfigState createState() => _ProfileConfigState();
}

class _ProfileConfigState extends State<ProfileConfig> {
  var value = false;
  double percent = 0;

  @override
  void initState() {
    super.initState();
  }

  alertConfigChange(value) {
    debugPrint('$value');
    this.setState(() => this.value = value);
  }

  alertPercentChange(percent) {
    debugPrint('$percent');
    this.setState(() => this.percent = percent);
  }

  logout() {
    Auth.auth.signOut();
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginSignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) => Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Ingreso mensual promedio'),
            keyboardType: TextInputType.number,
            onSaved: null,
          ),
          Divider(),
          SwitchListTile(
            title: Text('Recibir alertas?'),
            value: this.value,
            onChanged: alertConfigChange,
          ),
          Text('Porcentaje en el cual recibir alertas'),
          Slider.adaptive(
            value: this.percent,
            onChanged: this.value ? alertPercentChange : null,
          ),
          Divider(),
          ListTile(
            title: Text('Cerrar sesión'),
            onTap: logout,
          )
        ],
      ),
    );
  }
}
