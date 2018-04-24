import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cie/store/MyFileStore.dart';
import 'package:cie/store/course.dart';
import 'package:cie/utilities/style.dart';

class Courses extends StatefulWidget {
  @override
  CoursesState createState() => new CoursesState();
}

class CoursesState extends State<Courses> {
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
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: new TextField(
              decoration: new InputDecoration(hintText: "Search for Courses"),
            ),
          ),
          new Expanded(
            child: new Container(
              child: new ListView(children: renderCourses()),
            ),
          ),
        ],
      );

  void _addClassHandler(String value) {
    setState(() {
      _classes += "- " + value + "\n";
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
                  _buildButton(jsonMap),
                ]),
          ),
        ],
      ));
    }

    return list;
  }

  Widget _buildButton(Map jsonMap) {
    return new RaisedButton(
      color: Colors.orangeAccent,
      onPressed:
          _loggedIn ? () => _addClassHandler(jsonMap["course_name"]) : null,
      child: new Container(
        margin: const EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
        child: new Row(
          children: <Widget>[
            new Icon(Icons.bookmark),
            new Text("Bookmark Course"),
          ],
        ),
      ),
    );
  }
}
