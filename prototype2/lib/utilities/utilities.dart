import 'dart:io';

import 'package:cie/store/MyFileStore.dart';
import 'package:cie/utilities/constants.dart';
import 'package:flutter/material.dart';

class Utilities {
  static Drawer getNavigationDrawer(BuildContext context) {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new Container(
          height: 120.0,
          child: new DrawerHeader(
            padding: new EdgeInsets.all(0.0),
            decoration: new BoxDecoration(
              color: new Color(0xFFECEFF1),
            ),
            child: new Center(
              child: new Image(
                image: new AssetImage("resources/logo.jpg"),
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        _createProfile(context),
        new Divider(),
        _createListTile(context, 'Courses', Routes.Courses, Icons.apps),
        _createListTile(context, 'Schedule', Routes.Schedule, Icons.alarm),
        _createListTile(context, 'About', Routes.About, Icons.info),
        new Divider(),
        _createLogin(context),
      ],
    ));
  }

  static ListTile _createProfile(BuildContext context){
    if(MyFileStore.isLoggedIn()) {
      return _createListTile(context, 'Profile', Routes.Profile, Icons.account_circle);
    }
    return _createListTile(context, 'Profile', Routes.Profile, Icons.account_circle);
    //return _createListTile(context, "Profile", Routes.Login, Icons.account_circle);
  }

  static ListTile _createLogin(BuildContext context) {
    if (MyFileStore.isLoggedIn()) {
      return new ListTile(
          leading: new Icon(Icons.exit_to_app),
          title: new Text('Sign Out'),
          onTap: () {
            Navigator.pop(context);
            MyFileStore.getLoginFile().then((File file) {
              file.writeAsString('');
            });
          });
    } else {
      return _createListTile(context, "Sign In", Routes.Login, Icons.exit_to_app);
    }
  }

  static ListTile _createListTile(
      BuildContext context, String title, String path, IconData icon) {
    return new ListTile(
        leading: new Icon(icon),
        title: new Text(title),
        onTap: () {
          //close the drawer
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(path);
        });
  }
}
