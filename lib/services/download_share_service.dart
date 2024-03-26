import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_app/custom_widgets/snack_bar.dart';

class DownloadShareService {
  static saveToGallery(
      BuildContext context, ScreenshotController screenshotController) {
    screenshotController
        .capture()
        .then((Uint8List? image) => {saveScreenshot(image!)});
    CustomSnackBar.showSuccessSnackBar(context, 'Download successfully');
  }

  static saveScreenshot(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    final name = "Screenshot$time";
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  static shareImage(
      BuildContext context, ScreenshotController screenshotController) {
    try {
      screenshotController
          .capture(delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          final xFileImage = XFile(imagePath.path);
          await Share.shareXFiles([xFileImage]);
        }
      });
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, 'Error');
      return;
    }
  }
}
