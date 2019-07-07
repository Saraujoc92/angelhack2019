import 'package:financial_advisor/screens/home/home.dart';
import 'package:financial_advisor/services/profile.dart';
import 'package:financial_advisor/services/push.dart';
import 'package:flutter/material.dart';
import 'package:financial_advisor/services/auth.dart';

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage();

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  Auth _auth;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await _auth.signIn(_email, _password);
          debugPrint('Signed in: $userId');
        } else {
          userId = await _auth.signUp(_email, _password);
          ProfileService().init();
          _auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          debugPrint('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null &&
            userId.length > 0 &&
            _formMode == FormMode.LOGIN) {
          _onSignedIn();
        }
      } catch (e) {
        debugPrint('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  _onSignedIn() {
    PushService().init();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _auth = Auth.auth;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Ingresa a tu cuenta'),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verifca tu cuenta"),
          content: new Text("Verifica tu cuenta a través de tu email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showErrorMessage(),
              _showPrimaryButton(),
              _showSecondaryMessage(),
              _showSecondaryButton(),
            ],
          ),
        ));
  }

  Widget _showLogo() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
        child: Image.asset('assets/images/logos/logo-lg.png',
            height: 200, width: 200));
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      String message = '';

      if (_errorMessage == 'The email address is badly formatted.') {
        message = 'Correo electrónico inválido.';
      } else if (_errorMessage == 'The password is invalid or the user does not have a password.') {
        message = 'Usuario/Contraseña inválidos.';
      } else if (_errorMessage == 'The email address is already in use by another account.') {
        message = 'El correo electrónico ya ha sido registrado por otro usuario.';
      } else {
        message = _errorMessage;
      }
      
      return new Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: new Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13.0,
                color: Colors.red,
                height: 1.0,
                fontWeight: FontWeight.w500),
          ));
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
            return 'Ingresa tu Email';
          }
        },
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Contraseña',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
            return 'Ingresa una contraseña';
          }
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showSecondaryMessage() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: _formMode == FormMode.LOGIN
            ? new Text('¿No tienes cuenta?',
                textAlign: TextAlign.center,
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
            : new Text('¿Ya estás registrado?',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w300)));
  }

  Widget _showSecondaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: FlatButton(
          child: _formMode == FormMode.LOGIN
              ? new Text('Crea una cuenta',
                  style: new TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800))
              : new Text('Ingresa aquí',
                  style: new TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800)),
          onPressed: _formMode == FormMode.LOGIN
              ? _changeFormToSignUp
              : _changeFormToLogin,
        ));
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.red,
            child: _formMode == FormMode.LOGIN
                ? new Text('Ingresar',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Crear cuenta',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}
