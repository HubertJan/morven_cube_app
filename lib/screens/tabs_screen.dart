import 'package:flutter/material.dart';

import 'solve/solve_setup_screen.dart';
import 'history_screen.dart';
import 'status_screen.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen();

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {"page": SolveSetupScreen(), "title": "Lösen"},
      {"page": HistoryScreen(), "title": "Verlauf"},
      {"page": StatusScreen(), "title": "Status"},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navBar = NavigationBarWidget(_selectedPageIndex, _selectPage);
    return Scaffold(
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: navBar,
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}

class NavigationBarWidget extends StatelessWidget {
  final _pageIndex;
  final _select;

  NavigationBarWidget(this._pageIndex, this._select);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _select,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      currentIndex: _pageIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.vpn_key),
          label: "Lösen",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "Verlauf",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: "Status",
        ),
      ],
    );
  }
}
