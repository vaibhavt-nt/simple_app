import 'package:flutter/material.dart';
import 'package:simple_app/constants/colors.dart';

class PostFrameColorProvider extends ChangeNotifier {
  final List<Color> _frameColors = [
    CustomColors.teal,
    CustomColors.lightPurple,
    CustomColors.yellow,
    CustomColors.green,
    CustomColors.lightRed,
    CustomColors.lightYellow,
    CustomColors.purple,
    CustomColors.lightOrange,
    CustomColors.rose,
    CustomColors.levender,
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  late PageController _pageController;
  PageController get pageController => _pageController;

  PostFrameColorProvider() {
    _pageController = PageController(initialPage: _selectedIndex);
  }

  // Add this getter
  List<Color> get frameColors => _frameColors;

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    if (_selectedIndex < _frameColors.length ~/ 2 - 1) {
      _selectedIndex++;
      setSelectedIndex(_selectedIndex);
      notifyListeners();
    }
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    if (_selectedIndex > 0) {
      _selectedIndex--;
      setSelectedIndex(_selectedIndex);
      notifyListeners();
    }
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String get buttonTexts {
    if (_selectedIndex == 0) {
      return 'Frame 1';
    } else if (_selectedIndex == 1) {
      return 'Frame 2';
    } else if (_selectedIndex == 2) {
      return 'Frame 3';
    } else if (_selectedIndex == 3) {
      return 'Frame 4';
    } else if (_selectedIndex == 4) {
      return 'Frame 5';
    } else {
      return '';
    }
  }

  Color get selectedFrameColor1 => _frameColors[_selectedIndex * 2];

  Color get selectedFrameColor2 => _frameColors[_selectedIndex * 2 + 1];

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
