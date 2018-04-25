import 'package:cie/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bookmarks.dart' as _tab3;
import 'courses.dart' as _tab1;
import 'departments.dart' as _tab2;

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  PageController _tabController;
  List<String> dashElements = new List<String>();

  var _appTitle = '';
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._appTitle = TabItems[0].title;
    dashElements.add("Item one");
    dashElements.add("Item TWO!");
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: new Text(
          _appTitle,
          style: new TextStyle(
            fontSize:
                Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new PageView(
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          new _tab1.Courses(),
          new _tab2.Departments(),
          new _tab3.Bookmarks(),
        ],
      ),
      bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS
          ? new CupertinoTabBar(
              activeColor: Colors.blueGrey,
              currentIndex: _tab,
              onTap: onTap,
              items: TabItems.map((TabItem) {
                return new BottomNavigationBarItem(
                  title: new Text(TabItem.title),
                  icon: new Icon(TabItem.icon),
                );
              }).toList(),
            )
          : new BottomNavigationBar(
              currentIndex: _tab,
              onTap: onTap,
              items: TabItems.map((TabItem) {
                return new BottomNavigationBarItem(
                    title: new Text(
                      TabItem.title,
                      style: new TextStyle(color: Colors.black),
                    ),
                    icon: new Icon(TabItem.icon, color: Colors.black),
                    backgroundColor: Colors.white70);
              }).toList(),
            ),
      drawer: Utilities.getNavigationDrawer(context));

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._tab = tab;
    });
    // Switch statement for save tab navigation
    switch (tab) {
      case 0:
        this._appTitle = TabItems[0].title;
        break;
      case 1:
        this._appTitle = TabItems[1].title;
        break;
      case 2:
        this._appTitle = TabItems[2].title;
        break;
      case 3:
        this._appTitle = TabItems[3].title;
        break;
    }
  }
}

class TabItem {
  const TabItem({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Search', icon: Icons.search),
  const TabItem(title: 'Browse Courses', icon: Icons.business),
  const TabItem(title: 'Bookmarks', icon: Icons.book),
];
