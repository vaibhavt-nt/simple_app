import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_app/constants/colors.dart';

class ListOfPostScreen extends StatelessWidget {
  final String scheduleTime, scheduleDate, caption, platform, postImage;
  final double containerHeight;
  final double containerWidth;
  final Color frameColor1;
  final Color frameColor2;
  const ListOfPostScreen(
      {super.key,
      required this.scheduleTime,
      required this.scheduleDate,
      required this.caption,
      required this.platform,
      required this.postImage,
      required this.containerHeight,
      required this.containerWidth,
      required this.frameColor1,
      required this.frameColor2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0.sp),
      child: Stack(alignment: Alignment.topCenter, children: [
        Container(
          height: containerHeight.h + 70.h,
          width: containerWidth.w + 30.w,
          decoration: BoxDecoration(
              color: CustomColors.lightPink,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.r)),
          child: Padding(
            padding: EdgeInsets.all(10.0.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Schedule: $scheduleDate",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Colors.black),
                        )),
                    Text(platform,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Colors.black),
                        )),
                  ],
                ),
                Text(scheduleTime,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0.r),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: containerWidth.w,
              height: containerHeight.h,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.r),
                border: GradientBoxBorder(
                    width: 8.w,
                    gradient: LinearGradient(
                        colors: [frameColor1, frameColor2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
              child: Image.network(
                postImage,
                fit: BoxFit.cover,
                width: containerWidth.w + 5.w,
                height: containerHeight.h + 5.h,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(60.0.r),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Padding(
                  padding: EdgeInsets.all(15.0.r),
                  child: Text(caption,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.black),
                      )),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
