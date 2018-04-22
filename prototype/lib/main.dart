import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './tabs/home.dart' as _firstTab;
import './tabs/dashboard.dart' as _secondTab;
import './tabs/registration.dart' as _thirdTab;
import './tabs/departments.dart' as _fourthTab;
import './screens/about.dart' as _aboutPage;
import './screens/support.dart' as _supportPage;

void main() => runApp(new MaterialApp(
  title: 'Technical CIE',
  theme: new ThemeData(
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.red, backgroundColor: Colors.white
  ),
  home: new Tabs(),
  onGenerateRoute: (RouteSettings settings) {
    switch (settings.name) {
      case '/about': return new FromRightToLeft(
        builder: (_) => new _aboutPage.About(),
        settings: settings,
      );
      case '/support': return new FromRightToLeft(
        builder: (_) => new _supportPage.Support(),
        settings: settings,
      );
    }
  },
  // routes: <String, WidgetBuilder> {
  //   '/about': (BuildContext context) => new _aboutPage.About(),
  // }
));

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);

  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  
  PageController _tabController;
  List<String> dashElements = new List<String>();

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
    dashElements.add("Item one");
    dashElements.add("Item TWO!");
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: new AppBar(
      title: new Text(
        _title_app, 
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),

    //Content of tabs
    body: new PageView(
      controller: _tabController,
      onPageChanged: onTabChanged,
      children: <Widget>[
        new _firstTab.Home(),
        new _secondTab.Dashboard(),
        new _thirdTab.Registration(_tabController),
        new _fourthTab.Departments(),
      ],
    ),

    //Tabs
    bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
      new CupertinoTabBar(
        activeColor: Colors.blueGrey,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
      ):
      new BottomNavigationBar(
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(
                TabItem.title,
                style: new TextStyle(
                  color: Colors.black
                ),
            ),
            icon: new Icon(
                TabItem.icon,
                color: Colors.black
            ),
            backgroundColor: Colors.white70
          );
        }).toList(),
    ),

    //Drawer
    drawer: new Drawer(
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
          new ListTile(
            leading: new Icon(Icons.shopping_cart),
            title: new Text('Shopping Cart'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/support');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.info),
            title: new Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/about');
            }
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
        ],
      )
    )
  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });
    // Switch statement for save tab navigation
    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
      break;
      case 1:
        this._title_app = TabItems[1].title;
      break;
      case 2:
        this._title_app = TabItems[2].title;
      break;
      case 3:
        this._title_app = TabItems[3].title;
      break;
    }
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'My Schedule', icon: Icons.calendar_today),
  const TabItem(title: 'Register Courses', icon: Icons.dashboard),
  const TabItem(title: 'Browse Courses', icon: Icons.transform),
  const TabItem(title: 'Search Courses', icon: Icons.class_)
];