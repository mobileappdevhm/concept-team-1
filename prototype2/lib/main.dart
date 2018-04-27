import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './screens/about.dart' as _aboutPage;
import './tabs/tabs.dart' as _tabsPage;
import './screens/profile.dart' as _profilePage;
import './screens/schedule.dart' as _schedulePage;
import './screens/login.dart' as _loginPage;
import './screens/previous.dart' as _previousPage;
import './utilities/constants.dart';
import './store/Localization.dart';

void main() => runApp(new MaterialApp(
        onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
        localizationsDelegates: [
          const DemoLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
          const Locale('de', ''),
        ],
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
          Routes.Previous: (BuildContext context) => new _previousPage.Previous(),
        }));
