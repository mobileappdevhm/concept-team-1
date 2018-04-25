import 'package:cie/store/MyFileStore.dart';
import 'package:flutter/material.dart';
import 'package:cie/utilities/style.dart';
import 'package:cie/utilities/constants.dart';

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
          new Text('Bookmark content'),
          new Text(_classes),
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

  void switchToLogin() {
    String path = Routes.Login;
    Navigator.of(context).pushReplacementNamed(path);
  }
}
