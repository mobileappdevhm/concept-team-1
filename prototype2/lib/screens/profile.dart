import 'package:cie/utilities/utilities.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      new Scaffold(
        //App Bar
          appBar: new AppBar(
            title: new Text(
              'Profile',
              style: new TextStyle(
                fontSize: Theme
                    .of(context)
                    .platform == TargetPlatform.iOS ? 17.0 : 20.0,
              ),
            ),
            elevation: Theme
                .of(context)
                .platform == TargetPlatform.iOS ? 0.0 : 4.0,
          ),

          //Content of tabs
          body: new PageView(
            children: <Widget>[
              new Column (
                  children: <Widget>[new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(30.0),
                        child: new Container(

                          child: new Text(
                            'John Doe',
                            style: new TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                        ),)
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: new Text('Information about the student:')
                        ,)
                    ],
                  ),
                  new Row(
                  ),
                  ])

            ],
            //children: <Widget>[
            //  new Column(
            //    mainAxisAlignment: MainAxisAlignment.center,
            //    children: <Widget>[
            //      new Text('Information about the student'),
            //      new Text('Accounttype: Local / Exchange'),
            //      new Text('Local students can see a progressbar which shows how many courses they need to get the certificate.'),
            //    ],
            //  )
            //],
          ),
          drawer: Utilities.getNavigationDrawer(context)
      );
}
