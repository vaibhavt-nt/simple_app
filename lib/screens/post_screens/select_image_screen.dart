import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_caption_screen.dart';
import 'package:simple_app/services/image_picker_service.dart';

class SelectImageScreen extends StatefulWidget {
  final double height;
  final double width;
  final Color frameColor1;
  final Color frameColor2;
  const SelectImageScreen({
    super.key,
    required this.height,
    required this.width,
    required this.frameColor1,
    required this.frameColor2,
  });

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  final List<String> imageUrls = [];
  String? selectedImageUrl;
  void showImagePicker(
    BuildContext context,
    Function(File?) onImagePicked,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                await PickImage.pickImageFromCamera(onImagePicked);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await PickImage.pickImageFromGallery(onImagePicked);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedImageUrl ??= '';

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
              percent: 0.60,
              barRadius: Radius.circular(20.r),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.r, 24.r, 0.r, 24.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Padding(
                    padding: EdgeInsets.only(right: 150.r),
                    child: Text(
                      'Step 3',
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
                          'Select your post background image.',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff1C1C1C)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: widget.height.h,
                      width: widget.width.w,
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
                      child: Center(
                        child: selectedImageUrl!.isNotEmpty
                            ? Image.file(
                                File(selectedImageUrl!),
                                fit: BoxFit.cover,
                                width: widget.width.w,
                                height: widget.height.h,
                              )
                            : Text(
                                'Select Image',
                                style: TextStyle(fontSize: 20.sp),
                              ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    //Horizontal gallery of images
                    SizedBox(
                      height: 100.h, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageUrls.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: GestureDetector(
                                onTap: () {
                                  showImagePicker(context, (selectedFile) {
                                    if (selectedFile != null) {
                                      setState(() {
                                        final String newUrl = selectedFile.path;
                                        selectedImageUrl = newUrl;
                                        imageUrls.add(newUrl);
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: const BoxDecoration(
                                    color: CustomColors.lightGrey,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 50.r,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            final int assetIndex = index - 1;
                            return Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImageUrl = imageUrls[assetIndex];
                                  });
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2.w),
                                  ),
                                  child: Image.file(
                                    File(imageUrls[assetIndex]),
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectCaptionScreen(
                      containerHeight: widget.height,
                      containerWidth: widget.width,
                      imageUrl: selectedImageUrl!,
                      frameColor1: widget.frameColor1,
                      frameColor2: widget.frameColor2,
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
