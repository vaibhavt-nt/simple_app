import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';
import 'package:simple_app/services/download_share_service.dart';

class OverViewScreenWhenSkipButtonPressed extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final String imageUrl;
  final String enteredText;
  final Color frameColor1;
  final Color frameColor2;
  const OverViewScreenWhenSkipButtonPressed(
      {super.key,
      required this.containerHeight,
      required this.containerWidth,
      required this.imageUrl,
      required this.enteredText,
      required this.frameColor1,
      required this.frameColor2});

  @override
  State<OverViewScreenWhenSkipButtonPressed> createState() =>
      _OverViewScreenWhenSkipButtonPressedState();
}

class _OverViewScreenWhenSkipButtonPressedState
    extends State<OverViewScreenWhenSkipButtonPressed> {
  ScreenshotController screenshotController = ScreenshotController();

  bool _isLoading = false;

  //for storing image in firebase storage
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser;

  //for converting color to string
  String colorToHex(int colorValue, {bool includeHash = false}) {
    Color color = Color(colorValue);
    String hex = color.value.toRadixString(16);
    if (includeHash) {
      return '#$hex';
    } else {
      return hex;
    }
  }

  String frameColor1Hex = '';
  String frameColor2Hex = '';

  @override
  void initState() {
    super.initState();
    _convertColorsToHex();
  }

  void _convertColorsToHex() {
    frameColor1Hex = colorToHex(widget.frameColor1.value);
    frameColor2Hex = colorToHex(widget.frameColor2.value);
  }

  void onSubmitButton() async {
    setState(() {
      _isLoading = true;
    });

    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
        FirebaseStorage.instance.ref().child('post_images/$imageName.jpg');
    var uploadTask = storageRef.putFile(File(widget.imageUrl));
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    //add users details in  firestore
    try {
      await firestore.collection("post_data").doc().set({
        "created_at": DateTime.now(),
        "schedule_date": '',
        "schedule_time": '',
        "platform": '',
        "caption": widget.enteredText,
        "user_id": userId?.uid,
        "user_email": userId?.email,
        "user_name": userId?.displayName,
        // Add image reference to document
        "image": downloadUrl.toString(),
        "image_height": widget.containerHeight,
        "image_width": widget.containerWidth,
        "frame_color1": frameColor1Hex,
        "frame_color2": frameColor2Hex,
      }).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationBarScreen(),
            ),
          ));
      setState(() {
        _isLoading = false;
      });
      // Create an instance of MyNewClass and pass the containerHeight and containerWidth values to it
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print(e);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Gap(
                        height: 70,
                      ),
                      Screenshot(
                        controller: screenshotController,
                        child: Stack(alignment: Alignment.center, children: [
                          // Display the container image
                          Container(
                            height: widget.containerHeight,
                            width: widget.containerWidth,
                            decoration: BoxDecoration(
                              border: GradientBoxBorder(
                                  width: 8,
                                  gradient: LinearGradient(
                                      colors: [
                                        widget.frameColor1,
                                        widget.frameColor2
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                            ),
                            child: widget.imageUrl.isNotEmpty
                                ? Image.file(
                                    File(widget.imageUrl),
                                    fit: BoxFit.cover,
                                  )
                                : const Text(
                                    'Container',
                                    style: TextStyle(fontSize: 20),
                                  ),
                          ),
                          // Display the entered text
                          Positioned.fill(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      widget.enteredText,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: CustomColors.darkGrey),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SafeArea(
                        right: true,
                        left: true,
                        bottom: false,
                        top: false,
                        minimum: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      width: 2, color: CustomColors.pink),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () {
                                  DownloadShareService.saveToGallery(
                                      context, screenshotController);
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.file_download_outlined,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'Download',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CustomColors.darkGrey),
                                        ),
                                      ),
                                      // Icon(Icons.file_download_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      width: 2, color: CustomColors.pink),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () {
                                  DownloadShareService.shareImage(
                                      context, screenshotController);
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        size: 15,
                                        Icons.share_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'Share',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CustomColors.darkGrey),
                                        ),
                                      ),
                                      // Icon(Icons.file_download_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 342,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    backgroundColor: _isLoading
                        ? CustomColors.lightGrey
                        : const Color(0xFFEE4D86)),
                onPressed: _isLoading
                    ? null
                    : () {
                        onSubmitButton();
                      },
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text("Go to home",
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
              ),
            ),
            const Gap(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
