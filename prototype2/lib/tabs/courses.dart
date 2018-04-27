import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cie/store/MyFileStore.dart';
import 'package:cie/store/course.dart';
import 'package:cie/utilities/style.dart';

class Courses extends StatefulWidget {
  String name, number;
  bool isSearch = false;

  Courses(String name, String number, bool isSearch) {
    this.name = name;
    this.number = number;
    this.isSearch = isSearch;
  }

  @override
  CourseState createState() => new CourseState(name,number, isSearch);
}
/*
class Courses extends StatefulWidget {
  String name, number;

  Courses(String name, String number) {
    this.name = name;
    this.number = number;
  }
  //CoursesState createState() => new CoursesState();
  @override
  CourseState createState() => new CourseState(name,number);
}
*/

/*
class CoursesState extends State<Courses> {
  String _classes;
  bool _loggedIn = false;

  // Start
  String name, number;
  bool _isChecked = false;

  CourseState(String name, String number) {
    this.name = name;
    this.number = number;
  }


  void onChanged(bool value) {
    setState((){
      _isChecked = value;
    });
  }
  // End

  @override
  void initState() {
    super.initState();
    MyFileStore.readLoginFile().then((bool value) {
      setState(() {
        _loggedIn = value;
      });
    });

    MyFileStore.readLocalFile().then((String value) {
      setState(() {
        _classes = value != null ? value : "";
      });
    });
  }

  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
    for (int k=0; k<20; k++) {
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
*/
class CourseState extends State<Courses> {
  String name, number;
  String _classes;
  bool _isChecked = false;
  bool _loggedIn = false;
  bool isSearch = false;

  CourseState(String name, String number, bool isSearch) {
    this.name = name;
    this.number = number;
    this.isSearch = isSearch;
  }

  void onChanged(bool value) {
    setState((){
      _isChecked = value;
    });
  }

  @override
  void initState() {
    super.initState();
    MyFileStore.readLoginFile().then((bool value) {
      setState(() {
        _loggedIn = value;
      });
    });

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

  @override
  Widget build(BuildContext context) {
    if (isSearch) {
      return new Scaffold(
      appBar: new AppBar(
        title: new Text("Browsing All Courses"),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            //margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            //color: Colors.orangeAccent,
            color: new Color(0x07000000),
            child: new TextField(
              decoration: new InputDecoration(
                  hintText: "Search for Courses"
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              child: new ListView(children: renderCoursesOld()),
            ),
          ),
        ],
      ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Browsing Department: " + number),
      ),
      body: new Column(
        children: <Widget>[
            new Container (
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                      child: new Text(name, style:MyStyle.getHeaderStyle(),textAlign: TextAlign.center)
                  ),
                ],
              ),
            ),
          new Expanded(
            flex: 6,
            child: new Container(
              child: new ListView(children: renderCourses()),
            )
          ),
        ],
      ),
    );
  }

  List<Widget> renderCourses() {
    List jsonCourses = JSON.decode(Course.configJson);
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < jsonCourses.length; i++) {
      String jsonCourse = JSON.encode(jsonCourses[i]);
      Map jsonMap = JSON.decode(jsonCourse);
      list.add(new Container(
        decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: Colors.black38, width: 1.0)),
        ),
        child:new ExpansionTile(
          backgroundColor: new Color(0x07000000),
          title: new Text(jsonMap["course_name"], style: MyStyle.getBoldStyle()),
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: new Text(jsonMap["course_description"],
                  style: MyStyle.getStyle()),
            ),
          ],
        ),
      )
      );
    }
    list.add(
        new Container(
            height: 50.0,
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: new RaisedButton(
              color: Colors.orangeAccent,
              onPressed: voidFunction,
              child:new Text("Bookmark selected courses"),
            )
        )
    );
    return list;
  }

  void voidFunction() {

  }
  /* OLD FUNCTIONS HERE */
  List<Widget> renderCoursesOld() {
    List jsonCourses = JSON.decode(Course.configJson);
    List<Widget> list = new List<Widget>();
    for (int k=0; k<20; k++) {
      for (int i = 0; i < jsonCourses.length; i++) {
        String jsonCourse = JSON.encode(jsonCourses[i]);
        Map jsonMap = JSON.decode(jsonCourse);
        list.add(new Container(
          decoration: new BoxDecoration(
            color: new Color(0x07000000),
            border: new Border(
                top: new BorderSide(color: Colors.black38, width: 1.0)),
          ),
          child: new ExpansionTile(
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
          )
        ));
      }
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
