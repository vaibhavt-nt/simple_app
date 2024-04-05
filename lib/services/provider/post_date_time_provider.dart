import 'package:flutter/material.dart';

class PostDateTimeProvider extends ChangeNotifier {
  int buttonSelected = 0;
  bool chipSelected = false;
  String? _selectedPlatform;

  String? get selectedPlatform => _selectedPlatform;

  set selectedPlatform(String? value) {
    if (_selectedPlatform == value) return;
    _selectedPlatform = value;
    notifyListeners();
  }

  // For Date Pick Method
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void pickDateDialog(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            // which date will display when user open the picker
            firstDate: DateTime.now(),
            // what will be the previous supported year in picker
            lastDate: DateTime(
                2025)) // what will be the up to supported date in picker
        .then((pickedDate) {
      // then usually do the future job
      if (pickedDate == null) {
        // if user tap cancel then this function will stop
        return;
      }
      _selectedDate = pickedDate;
      notifyListeners();
    });
  }

  TimeOfDay? selectedTime;
  void pickTimeDialog(BuildContext context) {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay
                .now()) // what will be the up to supported date in picker
        .then((pickedDate) {
      // then usually do the future job
      if (pickedDate == null) {
        // if user tap cancel then this function will stop
        return;
      }
      selectedTime = pickedDate;
      notifyListeners();
    });
  }

// for time pick method
}
