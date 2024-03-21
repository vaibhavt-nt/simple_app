import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showErrorSnackBar(BuildContext context, String enterErrorText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(enterErrorText),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String enterErrorText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(enterErrorText),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
