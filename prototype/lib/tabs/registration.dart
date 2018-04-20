import 'dart:convert';
import 'dart:io';

import 'package:cie/consants/Style.dart';
import 'package:cie/store/MyFileStore.dart';
import 'package:cie/store/course.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  final PageController controller;

  Registration(PageController controller) {
    controller = this.controller;
  }
  @override
  RegistrationState createState() => new RegistrationState(controller);
}

class RegistrationState extends State<Registration> {
  String _classes;
  final PageController controller;
  RegistrationState(PageController controller) {
    controller = this.controller;
  }

  @override
  void initState() {
    super.initState();
    MyFileStore.readLocalFile().then((String value) {
      setState(() {
        _classes = value != null ? value : "";
      });
    });
  }

  void _addClassHandler(String value) {
    setState(() {
      _classes += "-" + value + "\n";
      MyFileStore.getLocalFile().then((File file) {
        file.writeAsString("$_classes");
      });
    });
  }

  List<Widget> renderCourses() {
    List jsonCourses = JSON.decode(Course.configJson);
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < jsonCourses.length; i++) {
      String jsonCourse = JSON.encode(jsonCourses[i]);
      Map jsonMap = JSON.decode(jsonCourse);
      list.add(new ExpansionTile(
        title: new Text(jsonMap["course_name"], style: MyStyle.getBoldStyle()),
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: new Text(jsonMap["course_description"],
                style: MyStyle.getStyle()),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          child: new Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new RaisedButton(
                  color: Colors.orangeAccent,
                  onPressed: () => _addClassHandler(jsonMap["course_name"]),
                  child: new Container(
                    margin: const EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
                    child:new Text("Add To Cart"),
                  ),
                  //child: new Icon(Icons.add_shopping_cart)
                ),
              ]),
          ),
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => new Container(
        child: new ListView(children: renderCourses()),
  );
}
