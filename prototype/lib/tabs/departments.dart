import 'dart:convert';
import 'dart:io';

import 'package:cie/consants/style.dart';
import 'package:cie/store/MyFileStore.dart';
import 'package:cie/store/department.dart';
import 'package:cie/tabs/registration.dart';
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
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      //padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
      decoration: new BoxDecoration(
        border: new Border(
            top: new BorderSide(color: Colors.green, width: 1.5),
            right: new BorderSide(color: Colors.black12, width: 1.0),
            bottom: new BorderSide(color: Colors.black12, width: 1.0),
            left: new BorderSide(color: Colors.black12, width: 1.0)),
      ),
      child: new FlatButton(
        color: Colors.white,
        //highlightColor: Colors.white,
        //splashColor: Colors.white,
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
                  new Text("Department " + number, style: MyStyle.getStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Courses extends StatelessWidget {
  String name, number;

  Courses(String name, String number) {
    this.name = name;
    this.number = number;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Department: " + number),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container (
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: new Align(
                alignment: Alignment.topCenter,
                child: new Text("Courses for: \n" + name, style:MyStyle.getBoldStyle(),textAlign: TextAlign.center,),
              ),
            ),
          ),
          new Expanded(
            flex: 5,
            child: new Container(

            )
          ),
        ],
      ),
    );
  }
}
