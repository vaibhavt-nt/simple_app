import 'package:flutter/material.dart';
import 'package:simple_app/Authentication/login_screen.dart';
import 'package:simple_app/Home/home_page.dart';
import 'package:simple_app/Profile/profile_screen.dart';
import 'package:simple_app/Schedule/schedule_screen.dart';


class Navigation_Screen extends StatefulWidget {
  const Navigation_Screen({super.key});

  @override
  _Navigation_ScreenState createState() => _Navigation_ScreenState();
}

class _Navigation_ScreenState extends State<Navigation_Screen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home_Page_Screen(),
    Schedule_Screen(),
    Profile_Screen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFEE4D86),
          iconSize: 30,
          onTap: _onItemTapped,
      ),
    );
  }
}