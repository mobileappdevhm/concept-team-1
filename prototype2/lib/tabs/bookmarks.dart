import 'package:cie/store/MyFileStore.dart';
import 'package:flutter/material.dart';

class Bookmarks extends StatefulWidget {
  @override
  BookmarksState createState() => new BookmarksState();
}

class BookmarksState extends State<Bookmarks> {
  String _classes;
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    MyFileStore.readLocalFile().then((String value) {
      setState(() {
        _classes = value.isNotEmpty ? value : "";
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
          new Text('Please login to show your saved classes.'),
        ],
      );
    }
  }
}
