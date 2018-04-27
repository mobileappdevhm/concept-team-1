import 'package:cie/utilities/utilities.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => new _ProfileState();

}


class _ProfileState extends State<Profile> {
  String _currentLanguage = '';
  List<String> _languageList = new List<String>();

  @override
  void initState() {
    _languageList.addAll(['English','German','French','Chinese','Thai','Spanish']);
    _currentLanguage = _languageList.elementAt(0);
  }

  void _onChange(String newLanguage){
    setState(() {
      _currentLanguage = newLanguage;
    });
  }


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
                        child: new Text('Department: Computer Sciences and Mathematics ')
                        ,)
                    ],
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                        child: new Text('Account Type: Local Student ')
                        ,)
                    ],
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                        child: new Text('Accumulated Credits: 10 ')
                        ,)
                    ],
                  ),

                  new Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('5 credits left to achieve CIE certificate'),
                        new LinearProgressIndicator(value:0.7),
                      ],
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('7 credits left to achieve IE certificate'),
                        new LinearProgressIndicator(value:0.5),
                      ],
                    ),
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: new Text('Preferred Language: '),
                      ),
                      new DropdownButton<String>(
                        value: _currentLanguage,
                        items: _languageList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }
                        ).toList(),
                        onChanged: (String value) { _onChange(value);},
                      ),
                    ],
                  ),
                    
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child:new RaisedButton(
                              onPressed: null,
                              color: Colors.red ,
                              disabledColor: Colors.red,
                              child: new Text(
                                  "See courses enrolled in previous semester",
                                  style: new TextStyle(
                                    color: Colors.black,
                                  )
                              ),
                          
                          ),
                        ),
                        
                      ],
                    )
                  ])
            ],
          ),
          drawer: Utilities.getNavigationDrawer(context)
      );
}
