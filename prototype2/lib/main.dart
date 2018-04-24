import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './screens/about.dart' as _aboutPage;
import './tabs/tabs.dart' as _tabsPage;
import './screens/profile.dart' as _profilePage;
import './screens/schedule.dart' as _schedulePage;
import './screens/login.dart' as _loginPage;
import './utilities/constants.dart';

void main() => runApp(new MaterialApp(
        title: 'Technical CIE',
        theme: new ThemeData(
            primarySwatch: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.red,
            backgroundColor: Colors.white),
        home: Constants.REGISTRATION_PERIOD
            ? new _tabsPage.Tabs()
            : new _aboutPage.About(),
        routes: <String, WidgetBuilder>{
          Routes.About: (BuildContext context) => new _aboutPage.About(),
          Routes.Courses: (BuildContext context) => new _tabsPage.Tabs(),
          Routes.Profile: (BuildContext context) => new _profilePage.Profile(),
          Routes.Schedule: (BuildContext context) => new _schedulePage.Schedule(),
          Routes.Login: (BuildContext context) => new _loginPage.Login(),
        }));
