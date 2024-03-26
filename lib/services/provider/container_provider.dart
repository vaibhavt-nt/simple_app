import 'package:flutter/material.dart';

class ContainerProvider with ChangeNotifier {
  double? _height;
  double? _width;

  double? get height => _height;
  double? get width => _width;

  void setContainerSize(double height, double width) {
    _height = height;
    _width = width;
    notifyListeners();
  }
}
