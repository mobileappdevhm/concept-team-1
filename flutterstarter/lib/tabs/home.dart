import 'package:flutter/material.dart';
import 'package:cie/consants/style.dart';
import 'dart:convert';
import 'package:cie/store/course.dart';
import 'package:cie/store/MyFileStore.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home>{
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
  Widget build(BuildContext context) => new Container(
    color: Colors.white,
    child: new ListView(
      children: renderRows(),
    )
  );

  List<Widget> renderRows() {
    List<Widget> list = new List<Widget>();
    List jsonCourses = JSON.decode(Course.configJson);
    for (int i = 0; i < jsonCourses.length; i++) {
      String jsonCourse = JSON.encode(jsonCourses[i]);
      Map jsonMap = JSON.decode(jsonCourse);
      list.add(renderCourse(jsonMap["course_name"], jsonMap["schedule_time"], jsonMap["schedule_days"], "Building " + jsonMap["building_name"], jsonMap["classroom_name"], "Professor " + jsonMap["professor_name"]));
    }
    return list;
  }

  Container renderCourse(String name, String time, String day, building, classroom, professor) {
    return new Container(
      height: 125.0,
      margin : const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: Colors.lightBlue, width: 4.0),
              right: new BorderSide(color: Colors.grey, width: 1.0),
              bottom: new BorderSide(color: Colors.grey,  width: 1.0),
              left: new BorderSide(color: Colors.grey, width: 1.0)),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Flexible(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(name , style:MyStyle.getBoldStyle(),),
                new Padding(padding: new EdgeInsets.only(bottom: 5.0)),
                new Text(professor, style:MyStyle.getStyle()),
                new Padding(padding: new EdgeInsets.only(bottom: 5.0)),
                new Text(building + " " + classroom, style:MyStyle.getItalicStyle()),
                new Padding(padding: new EdgeInsets.only(bottom: 5.0)),
                new Text(time +", " + day, style:MyStyle.getItalicStyle()),
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
          new Text(start + "-" + end + ", " + location, style:MyStyle.getStyle())
        ],
      ),
    );
  }
}
