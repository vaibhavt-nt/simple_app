import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';
import 'package:simple_app/services/download_share_service.dart';

class OverViewScreen extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final String imageUrl;
  final String enteredText;
  final String selectedDate;
  final String selectedTime;
  final String selectedPlatform;
  final Color frameColor1;
  final Color frameColor2;
  const OverViewScreen(
      {super.key,
      required this.containerHeight,
      required this.containerWidth,
      required this.imageUrl,
      required this.enteredText,
      required this.selectedDate,
      required this.selectedTime,
      required this.selectedPlatform,
      required this.frameColor1,
      required this.frameColor2});

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
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
        "schedule_date": widget.selectedDate,
        "schedule_time": widget.selectedTime,
        "platform": widget.selectedPlatform,
        "caption": widget.enteredText,
        "user_id": userId?.uid,
        "user_email": userId?.email,
        "user_name": userId?.displayName,
        // Add image reference to document
        "image": downloadUrl.toString(),
        "image_height": widget.containerHeight,
        "image_width": widget.containerWidth,
        "frame_color1": frameColor1Hex,
        "frame_color2": frameColor2Hex
      }).then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationBarScreen(),
          )));
      setState(() {
        _isLoading = false;
      });
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

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(20.r, 60.r, 20.r, 10.r),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Stack(alignment: Alignment.center, children: [
                          // Display the container image
                          Container(
                            height: widget.containerHeight.h,
                            width: widget.containerWidth.w,
                            decoration: BoxDecoration(
                              border: GradientBoxBorder(
                                  width: 8.w,
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
                                : Text(
                                    'Container',
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                          ),
                          // Display the entered text
                          Positioned.fill(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0.r),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0.r),
                                    child: Text(
                                      widget.enteredText,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
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
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Post Schedule',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: Colors.black),
                                  )),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 40.h,
                              width: 342.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(color: CustomColors.pink)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.selectedDate,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.r,
                                              color: Colors.black),
                                        )),
                                    Icon(Icons.date_range_outlined, size: 25.r)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 40.h,
                              width: 342.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(color: CustomColors.pink)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.selectedTime,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.r,
                                              color: Colors.black),
                                        )),
                                    Icon(Icons.watch_later_outlined, size: 25.r)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 40.h,
                              width: 342.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(color: CustomColors.pink)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.selectedPlatform,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.r,
                                              color: Colors.black),
                                        )),
                                    Icon(Icons.facebook, size: 25.r)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 155.w,
                                  height: 44.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      surfaceTintColor: Colors.white,
                                      shadowColor: Colors.white,
                                      backgroundColor: Colors
                                          .white, //background color of button
                                      side: BorderSide(
                                          width: 2.w,
                                          color: CustomColors
                                              .pink), //border width and color
                                      shape: RoundedRectangleBorder(
                                          //to set border radius to button
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
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
                                          Icon(
                                            Icons.file_download_outlined,
                                            size: 20.sp,
                                            color: Colors.black,
                                          ),
                                          Text('Download',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.r,
                                                    color: Colors.black),
                                              )),
                                          // Icon(Icons.file_download_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 155.w,
                                  height: 44.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      surfaceTintColor: Colors.white,
                                      shadowColor: Colors.white,
                                      backgroundColor: Colors
                                          .white, //background color of button
                                      side: BorderSide(
                                          width: 2.w,
                                          color: CustomColors
                                              .pink), //border width and color
                                      shape: RoundedRectangleBorder(
                                          //to set border radius to button
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
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
                                          Icon(
                                            size: 15.sp,
                                            Icons.share_outlined,
                                            color: Colors.black,
                                          ),
                                          Text('Share',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.r,
                                                    color: Colors.black),
                                              )),
                                          // Icon(Icons.file_download_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 342.w,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.r, horizontal: 16.r),
                      backgroundColor: _isLoading
                          ? CustomColors.lightGrey
                          : const Color(0xFFEE4D86)),
                  onPressed: _isLoading
                      ? null
                      : () {
                          onSubmitButton();
                        },
                  child: _isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.w, color: Colors.white),
                        )
                      : Text("Go to home",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.r,
                                fontWeight: FontWeight.w600),
                          )),
                ),
              ),
              Gap(
                height: 30.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
