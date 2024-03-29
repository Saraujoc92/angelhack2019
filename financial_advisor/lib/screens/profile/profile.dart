import 'package:financial_advisor/services/push.dart';
import 'package:financial_advisor/widgets/profile_config.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    PushService().printToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: ProfileConfig(),
      ),
    );
  }
}
