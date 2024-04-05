import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_date_time_screen.dart';
import 'package:simple_app/services/provider/post_caption_provider.dart';

class SelectCaptionScreen extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final String imageUrl;
  final Color frameColor1;
  final Color frameColor2;

  const SelectCaptionScreen({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.imageUrl,
    required this.frameColor1,
    required this.frameColor2,
  });

  @override
  Widget build(BuildContext context) {
    final PostCaptionProvider model = Provider.of<PostCaptionProvider>(
      context,
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.r, 40.r, 24.r, 24.r),
        child: Column(
          children: [
            Gap(
              height: 20.h,
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.2,
              lineHeight: 8.0,
              percent: 0.80,
              barRadius: Radius.circular(20.r),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 24.r, 0, 24.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Padding(
                    padding: EdgeInsets.only(right: 150.r),
                    child: Text(
                      'Step 4',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: const Color(0xff1C1C1C)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 24.0.r),
                      child: Text(
                        'Enter your caption.',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: const Color(0xff1C1C1C)),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      model.updateEnteredText(value);
                    },
                    minLines: 4.bitLength,
                    maxLines: 4.bitLength,
                    controller: model.textFieldController,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEE4D86))),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      height: containerHeight.h,
                      width: containerWidth.w,
                      decoration: BoxDecoration(
                        border: GradientBoxBorder(
                            width: 8.w,
                            gradient: LinearGradient(
                                colors: [frameColor1, frameColor2],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                      child: Center(
                        child: imageUrl.isNotEmpty
                            ? Image.file(
                                File(imageUrl),
                                fit: BoxFit.cover,
                                width: containerWidth.w,
                                height: containerHeight.h,
                              )
                            : Text(
                                'Select Image',
                                style: TextStyle(fontSize: 20.sp),
                              ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0.r),
                          child: Container(
                            color: Colors.white,
                            child: Text(
                              model.enteredText,
                              textAlign: model.textAlign,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.r,
                                    color: const Color(0xff1C1C1C)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Select text alignment',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.h,
                              color: Colors.black),
                        )),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w, color: CustomColors.pink),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            //borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              model.setTextAlign(TextAlign.left);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: Icon(
                                // Icons.vertical_distribute,
                                Icons.format_align_left_outlined,
                                size: 20.0.r,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w, color: CustomColors.pink),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            //borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              model.setTextAlign(TextAlign.center);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: Icon(
                                // Icons.vertical_distribute,
                                Icons.format_align_center_outlined,
                                size: 20.0.r,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w, color: CustomColors.pink),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            //borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              model.setTextAlign(TextAlign.right);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: Icon(
                                // Icons.vertical_distribute,
                                Icons.format_align_right_outlined,
                                size: 20.0.r,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(
                    height: 30.h,
                  )
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectDateAndTimeScreen(
                      containerHeight: containerHeight,
                      containerWidth: containerWidth,
                      imageUrl: imageUrl,
                      enteredText: model.enteredText,
                      frameColor1: frameColor1,
                      frameColor2: frameColor2,
                    ),
                  ),
                );
              },
              child: Container(
                height: 40.h,
                width: 342.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.r),
                  ),
                  color: const Color(0xffED4D86),
                ),
                child: Center(
                  child: Text('Next',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: const Color(0xffFFFFFC)),
                      )),
                ),
              ),
            ),
            Gap(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
