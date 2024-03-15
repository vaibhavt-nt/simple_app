import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  static void pickImage(void Function(File?) updateState) async {
    // pick image from gallery, change ImageSource.camera if you want to capture image from camera.
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      updateState(imageFile);
    }
  }

  static final ImagePicker _picker = ImagePicker();
}