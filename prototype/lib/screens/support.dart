import 'package:flutter/material.dart';
import 'package:cie/store/MyFileStore.dart';

class Support extends StatefulWidget {
  @override
  SupportState createState() => new SupportState();
}

class SupportState extends State<Support> {
  String _classes;

  @override
  void initState() {
    super.initState();
    MyFileStore.readLocalFile().then((String value) {
      setState(() {
        _classes = value != null ? value : "";
      });
    });
  }

  @override
  Widget build (BuildContext context) => new Scaffold(
    //App Bar
    appBar: new AppBar(
      title: new Text(
        'Shopping Cart',
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),

    //Content of tabs
    body: new PageView(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Shopping cart content'),
            new Text(_classes),
          ],
        )
      ],
    ),
  );
}