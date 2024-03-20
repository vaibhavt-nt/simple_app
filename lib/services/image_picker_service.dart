import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  static pickImageFromGallery(Function(File?) onImagePicked) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  static pickImageFromCamera(Function(File?) onImagePicked) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }
}
