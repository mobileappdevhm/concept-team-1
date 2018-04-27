import 'package:cie/store/MyFileStore.dart';
import 'package:flutter/material.dart';
import 'package:cie/utilities/style.dart';
import 'package:cie/utilities/constants.dart';
import 'package:cie/tabs/departments.dart';

class Bookmarks extends StatefulWidget {
  @override
  BookmarksState createState() => new BookmarksState();
}

class BookmarksState extends State<Bookmarks> {
  String _classes = "dog";
  bool _loggedIn = true;

  @override
  void initState() {
    super.initState();
    MyFileStore.readLocalFile().then((String value) {
      setState(() {
        _classes = value!= null ? value : "We are logged in";
      });
    });
    MyFileStore.readLoginFile().then((bool value) {
      setState(() {
        _loggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (_loggedIn) {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('No scheduling conflicts found\n', style: MyStyle.getBoldStyle(),),
          new Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            decoration: new BoxDecoration(
            border: new Border(
                top: new BorderSide(color: Colors.grey, width: 2.0),
                right: new BorderSide(color: Colors.grey, width: 2.0),
                bottom: new BorderSide(color: Colors.grey, width: 2.0),
                left: new BorderSide(color: Colors.grey, width: 2.0)),
            ),
            child: new Text(_classes, style: MyStyle.getBoldStyle()),
      ),

      new Container(
        height: 50.0,
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: new RaisedButton(
        color: Colors.orangeAccent,
        onPressed: voidFunction,
        child:new Text("Register Shopping Cart Contents"),
      )
    )
        ],
      );
    } else {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
              onPressed: switchToLogin,
              child: new Text("Sign in"),
              color: Colors.lightBlueAccent
          ),
        ],
      );
    }
    return new Row();
  }

  void voidFunction() { }

  void switchToLogin() {
    String path = Routes.Login;
    Navigator.of(context).pushReplacementNamed(path);
  }
}
