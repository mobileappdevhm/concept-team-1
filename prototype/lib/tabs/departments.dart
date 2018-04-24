import 'dart:convert';
import 'dart:io';

import 'package:cie/consants/style.dart';
import 'package:cie/store/MyFileStore.dart';
import 'package:cie/store/course.dart';
import 'package:cie/store/department.dart';
import 'package:flutter/material.dart';

class Departments extends StatefulWidget {
  @override
  DepartmentsState createState() => new DepartmentsState();
}

class DepartmentsState extends State<Departments> {
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
  Widget build(BuildContext context) =>
      new Container(
          color: Colors.white,
          child: new ListView(
            children: renderRows(),
          ));

  List<Widget> renderRows() {
    List<Widget> list = new List<Widget>();
    list.add(new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
    ));
    List jsonDepartments = JSON.decode(Department.configJson);
    for (int i = 0; i < jsonDepartments.length; i++) {
      String jsonCourse = JSON.encode(jsonDepartments[i]);
      Map jsonMap = JSON.decode(jsonCourse);
      list.add(renderDepartment(
          jsonMap["department_name"], jsonMap["department_number"]));
    }
    return list;
  }

  Container renderDepartment(String name, String number) {
    return new Container(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      decoration: new BoxDecoration(
        border: new Border(
            top: new BorderSide(color: Colors.green, width: 2.0),
            right: new BorderSide(color: Colors.black12, width: 1.25),
            bottom: new BorderSide(color: Colors.black12, width: 1.25),
            left: new BorderSide(color: Colors.black12, width: 1.25)),
      ),
      child: new FlatButton(
        color: Colors.white,
        padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Courses(name,number)),
          );
        },
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
                  new Text("Department " + number, style: MyStyle.getItalicStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Courses extends StatefulWidget {
  String name, number;

  Courses(String name, String number) {
    this.name = name;
    this.number = number;
  }
  @override
  CourseState createState() => new CourseState(name,number);
}

class CourseState extends State<Courses> {
  String name, number;
  String _classes;
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Browsing Department " + number),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
              top: new BorderSide(color: Colors.black45, width: 1.0)),
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
              child:new Text("Add Selected Courses"),
          )
        )
    );
    return list;
  }

  void voidFunction() {

  }
}
