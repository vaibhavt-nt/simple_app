import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
