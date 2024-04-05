import 'package:flutter/material.dart';

class PostFrameSizeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  late PageController _pageController;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  PageController get pageController => _pageController;

  PostFrameSizeProvider() {
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
