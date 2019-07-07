import 'package:financial_advisor/screens/login/LoginScreen.dart';
import 'package:financial_advisor/services/auth.dart';
import 'package:financial_advisor/services/profile.dart';
import 'package:flutter/material.dart';

class ProfileConfig extends StatefulWidget {
  ProfileConfig({Key key}) : super(key: key);

  _ProfileConfigState createState() => _ProfileConfigState();
}

class _ProfileConfigState extends State<ProfileConfig> {
  var alerts = false;
  double percent = 0;

  ProfileService profileService;

  FocusNode _textFocus = new FocusNode();
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    profileService = ProfileService();
    _textFocus.addListener(incomeChange);
    profileService.profile.then((profile) {
      setState(() {
        _controller.text = profile.data['income'] ?? '';
        alerts = profile.data['alerts'] ?? false;
        percent = profile.data['alertpercent'] ?? .3;
      });
    });
    super.initState();
  }

  @override
  dispose() {
    _textFocus.dispose();
    super.dispose();
  }

  incomeChange() {
    debugPrint('incomeChange');
    bool hasFocus = _textFocus.hasFocus;
    if (hasFocus) return;
    String value = _controller.text;
    debugPrint('$value');
    try {
      profileService.income = double.parse(value);
    } catch (error) {
      _controller.text = '';
    }
  }

  alertConfigChange(value) {
    debugPrint('$value');
    profileService.alerts = value;
    this.setState(() => this.alerts = value);
  }

  alertPercentChange(percent) {
    debugPrint('$percent');
    this.setState(() => this.percent = percent);
  }

  alertPercentSave(percent) {
    profileService.alertPercentage = percent;
  }

  logout() {
    Auth.auth.signOut();
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginSignUpPage()));
  }

  _reset() {
    ProfileService().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Mi Perfil',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.red,
                fontWeight: FontWeight.w600)),
        Divider(color: Colors.red, height: 10.0),
        TextFormField(
          controller: _controller,
          focusNode: _textFocus,
          decoration:
              InputDecoration(labelText: 'Dinero libre mensual promedio'),
          keyboardType: TextInputType.number,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 40.0),
          child: Card(
            color: Colors.white70,
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Recibir alertas?'),
                  value: this.alerts,
                  onChanged: alertConfigChange,
                ),
                Text('Porcentaje en el cual recibir alertas'),
                Slider(
                  value: this.percent,
                  onChanged: this.alerts ? alertPercentChange : null,
                  onChangeEnd: alertPercentSave,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 20.0),
          child: RaisedButton(
              color: Colors.red,
              child: Text(
                'Cerrar sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: logout),
        ),
        MaterialButton(
          child: Text(
                'Reset'),
                onPressed: _reset,
        ),
      ],
    );
  }
}
