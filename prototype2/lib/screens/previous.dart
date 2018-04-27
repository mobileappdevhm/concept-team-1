import 'dart:convert';

import 'package:cie/store/MyFileStore.dart';
import 'package:cie/store/course.dart';
import 'package:cie/utilities/style.dart';
import 'package:cie/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:cie/utilities/constants.dart';

class Previous extends StatefulWidget {
  @override
  PreviousState createState() => new PreviousState();
}

class PreviousState extends State<Previous> {
  String _classes;
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    MyFileStore.readLocalFile().then((String value) {
      setState(() {
        _classes = value!=null ? value : "";
      });
    });
    MyFileStore.readLoginFile().then((bool value) {
      setState(() {
        _loggedIn = value;
      });
    });
  }

  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new AppBar(
          title: new Text(
            'Previous Courses',
            style: new TextStyle(
              fontSize: Theme.of(context).platform == TargetPlatform.iOS
                  ? 17.0
                  : 20.0,
            ),
          ),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),

        //Content of tabs
        body: new PageView(children: <Widget>[
          new Container(
            color: Colors.white,
            child: new ListView(
              children: renderRows(),
            ),
          ),
        ]),
        drawer: Utilities.getNavigationDrawer(context),
      );

  void switchToLogin() {
    String path = Routes.Login;
    Navigator.of(context).pushReplacementNamed(path);
  }

  List<Widget> renderRows() {
    List<Widget> list = new List<Widget>();
    if (_classes == null) {
      list.add(
      new RaisedButton(
              onPressed: switchToLogin,
              child: new Text("Sign in"),
              color: Colors.lightBlueAccent
          )
      );
    }
    list.add(new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
    ));
    if(_loggedIn) {
      List jsonCourses = JSON.decode(Course.configJson);
      for (int i = 0; i < jsonCourses.length; i++) {
        String jsonCourse = JSON.encode(jsonCourses[i]);
        Map jsonMap = JSON.decode(jsonCourse);
        list.add(renderCourse(
            jsonMap["course_name"],
            jsonMap["schedule_time"],
            jsonMap["schedule_days"],
            "Building " + jsonMap["building_name"],
            jsonMap["classroom_name"],
            "Professor " + jsonMap["professor_name"]));
      }
    } else {
      new Text('Please login to view your schedule.', style: MyStyle.getStyle());
    }
    return list;
  }

  Container renderCourse(
      String name, String time, String day, building, classroom, professor) {
    return new Container(
      height: 125.0,
      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      decoration: new BoxDecoration(
        border: new Border(
            top: new BorderSide(color: Colors.lightBlue, width: 2.0),
            right: new BorderSide(color: Colors.grey, width: 1.25),
            bottom: new BorderSide(color: Colors.grey, width: 1.25),
            left: new BorderSide(color: Colors.grey, width: 1.25)),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Flexible(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  name,
                  style: MyStyle.getBoldStyle(),
                ),
                new Padding(padding: new EdgeInsets.only(bottom: 5.0)),
                new Text(professor, style: MyStyle.getStyle()),
                new Padding(padding: new EdgeInsets.only(bottom: 5.0)),
                new Text("ECTS: 5",
                    style: MyStyle.getItalicStyle()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container renderTimeTable(String start, String end, String location) {
    return new Container(
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(start + "- " + end + ", " + location,
              style: MyStyle.getStyle())
        ],
      ),
    );
  }
}
