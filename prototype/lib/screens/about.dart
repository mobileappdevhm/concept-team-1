import 'package:flutter/material.dart';
import 'package:cie/consants/style.dart';

class About extends StatelessWidget {
  final String aboutMUASDescription = "Munich University of Applied Sciences is one of the largest universities of applied sciences in Germany. Around 18,000 students and the location in a leading European business metropolis offer opportunities, but they also demand responsibility in industrial, economic and social contexts.";
  final String aboutCIEDescription = "One of Munich University of Applied Sciences’ main objectives is to continually expand and improve its international activities and services. These include international exchange programmes as well as a wide range of language and intercultural courses.json. The Courses in English forms a vital part of this strategy.";
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: new AppBar(
      title: new Text(
        'About', 
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),

    //Content of tabs
    body: new PageView(
      children: <Widget>[
        new ListView(
        children: <Widget>[
          new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
            padding: new EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            child: new Image(
                  image: new AssetImage("resources/muas.png"),
                  color: null,
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                )
            ),
            new Container(
            padding: new EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            child: new Text(aboutMUASDescription,
                style: MyStyle.getStyle()),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
              child: new Text(aboutCIEDescription,
                style: MyStyle.getStyle()),
            ),
          ],
        ),
        ]
        ),
      ],
    ),
  );
}