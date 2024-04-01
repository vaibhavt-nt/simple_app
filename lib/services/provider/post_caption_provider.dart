import 'package:flutter/material.dart';

class PostCaptionProvider extends ChangeNotifier {
  String enteredText = '';
  TextAlign textAlign = TextAlign.left;
  TextEditingController textFieldController = TextEditingController();

  void updateEnteredText(String newText) {
    enteredText = newText;
    notifyListeners();
  }

  void setTextAlign(TextAlign newAlign) {
    textAlign = newAlign;
    notifyListeners();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }
}
