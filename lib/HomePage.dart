import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vin_clipper/HistoryPage.dart';
import 'package:vin_clipper/SettingsPage.dart';
import 'package:vin_clipper/VinScannerPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();
  List<Widget> _screens = [HistoryPage(), VinScannerPage(), SettingsPage()];

  AppBar createAppBar() {
    return AppBar(
      // Here we take the value from the HomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(widget.title),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PageView createBody() {
    return PageView(
      controller: _pageController,
      children: _screens,
      onPageChanged: _onPageChanged,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  BottomNavigationBar createBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text('History'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          title: Text('Scan VIN'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: createBody(), bottomNavigationBar: createBottomNavigationBar());
  }
}

class CameraAccessDenied {}
