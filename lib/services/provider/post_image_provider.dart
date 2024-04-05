import 'package:flutter/material.dart';

class PostImageProvider extends ChangeNotifier {
  String? _selectedImageUrl;
  final List<String> _imageUrls = [];

  String? get selectedImageUrl => _selectedImageUrl;
  List<String> get imageUrls => _imageUrls;

  void setSelectedImageUrl(String? url) {
    _selectedImageUrl = url;
    notifyListeners();
  }

  void addImageUrl(String url) {
    _imageUrls.add(url);
    notifyListeners();
  }
}
