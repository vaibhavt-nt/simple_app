import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/screens/home_screens/home_page.dart';
import 'package:simple_app/screens/profile_screen/profile_screen.dart';
import 'package:simple_app/screens/schedule_screen/schedule_screen.dart';
import 'package:simple_app/services/provider/navigation_provider.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  BottomNavigationBarScreen({
    super.key,
  });

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const ScheduleScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (BuildContext context, NavigationProvider value, Widget? child) {
        return Scaffold(
          body: Center(child: _widgetOptions.elementAt(value.selectedIndex)),
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
              currentIndex: value.selectedIndex,
              selectedItemColor: const Color(0xFFEE4D86),
              iconSize: 30.r,
              onTap: (int index) {
                value.setSelectedIndex(index);
              }),
        );
      },
    );
  }
}
