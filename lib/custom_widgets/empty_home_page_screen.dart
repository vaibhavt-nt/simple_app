import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Screens/post_screens/select_frame_screen.dart';

class EmptyHomeScreen extends StatelessWidget {
  final String imagePath, subtitle, buttonText;
  const EmptyHomeScreen(
      {super.key,
      required this.imagePath,
      required this.subtitle,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60.h,
        ),
        SizedBox(
          width: 335.w,
          height: 247.h,
          child: SvgPicture.asset(imagePath
              // 'assets/home_images/empty.svg'
              ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                )),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.all(10.0.w),
          child: SizedBox(
            width: 342.w,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectFrameScreen(),
                    ));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFEE4D86)),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))))),
              child: Text(buttonText,
                  // "Create Post",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
