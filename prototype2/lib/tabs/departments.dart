import 'dart:convert';
import 'dart:io';

import 'package:cie/utilities/style.dart';
import 'package:cie/store/MyFileStore.dart';
import 'package:cie/tabs/courses.dart';
import 'package:cie/store/department.dart';
import 'package:flutter/material.dart';

import 'package:cie/utilities/constants.dart';

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

    list.add(
      new Container(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: new RaisedButton(
            color: Colors.lightBlueAccent,
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            onPressed: switchToSearchPage,
            child: new Column(
              children: <Widget>[new Icon(Icons.search), new Text("Search Entire Course Catalog")]
            )))
    );

    List jsonDepartments = JSON.decode(Department.configJson);
    for (int i = 0; i < jsonDepartments.length; i++) {
      String jsonCourse = JSON.encode(jsonDepartments[i]);
      Map jsonMap = JSON.decode(jsonCourse);
      list.add(renderDepartment(
          jsonMap["department_name"], jsonMap["department_number"]));
    }

    return list;
  }

  void switchToSearchPage() {
    Navigator.push(
    context,
    new MaterialPageRoute(
        builder: (context) => new Courses(null, null, true),
    ),
  );
  }


  Container renderDepartment(String name, String number) {
    return new Container(
      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      decoration: new BoxDecoration(
        border: new Border(
            top: new BorderSide(color: Colors.green, width: 2.0),
            right: new BorderSide(color: Colors.black12, width: 1.25),
            bottom: new BorderSide(color: Colors.black12, width: 1.25),
            left: new BorderSide(color: Colors.black12, width: 1.25)),
      ),
      child: new FlatButton(
        color: new Color(0x07000000),
        //color: Colors.white,
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Courses(name,number, false)),
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

