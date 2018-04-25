import 'dart:io';

import 'package:cie/store/MyFileStore.dart';
import 'package:cie/utilities/constants.dart';
import 'package:cie/utilities/utilities.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  LoginState createState() => new LoginState();
}

class LoginData {
  String email = '';
  String password = '';
  bool persistence = true;
}

class LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LoginData loginData = new LoginData();

  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    MyFileStore.readLoginFile().then((bool value) {
      setState(() {
        _loggedIn = value;
      });
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  bool _autoValidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();

      setState(() {
        _loggedIn = true;
      });

      await MyFileStore.getLoginFile().then((File file) {
        file.writeAsString(loginData.email);
      });


      String path = Constants.REGISTRATION_PERIOD ? Routes.Courses : Routes.About;
      Navigator.of(context).pushReplacementNamed(path);
    }
  }

  String _validateMail(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return 'Mail is required.';
    final RegExp mailExp = new RegExp(
        r"^((([a-z]|\d|[!#$%&'*+-/=?^_`{|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#$%&'*+\-/=?^_`{|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
    if (!mailExp.hasMatch(value)) return 'Please enter a valid e-mail address.';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return 'Password is required.';
    if (value.length < 8) return 'Password is to short.';
    return null;
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Login'),
      ),
      body: new Container(
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: new ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
              children: <Widget>[
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Deine E-Mailadresse',
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    loginData.email = value;
                  },
                  //initialValue: Storage.getEmail(),
                  validator: _validateMail,
                ),
                new TextFormField(
                  key: _passwordFieldKey,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.vpn_key),
                    hintText: 'Dein Passwort',
                    labelText: 'Passwort',
                  ),
                  obscureText: true,
                  onSaved: (String value) {
                    loginData.password = value;
                  },
                  //initialValue: Storage.getPassword(),
                  validator: _validatePassword,
                ),
                new ListTile(
                  leading:
                  new Icon(
                    loginData.persistence
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: loginData.persistence ? Colors.lightBlueAccent: null,
                  ),
                  title: new Text('Remember Me?'),
                  trailing: new FlatButton(
                    color: Colors.lightBlueAccent,
                    onPressed: _handleSubmitted,
                    child: new Text('Login'),
                  ),
                  onTap: () {
                    setState(() {
                      loginData.persistence = !loginData.persistence;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Utilities.getNavigationDrawer(context));
}
