import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_image_screen.dart';
import 'package:provider/provider.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_app/services/provider/post_color_frame_provider.dart';

class SelectColorFrameScreen extends StatelessWidget {
  final double height;
  final double width;

  const SelectColorFrameScreen({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final PostFrameColorProvider model =
        Provider.of<PostFrameColorProvider>(context, listen: false);
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
              percent: 0.40,
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
                      'Step 2',
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
                          'Select your post frame.',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff1C1C1C)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 420.h,
                      width: 342.w,
                      child: PageView.builder(
                          controller: model.pageController,
                          itemCount: model.frameColors.length ~/ 2,
                          itemBuilder: (context, index) {
                            Color frameColor1 = model.frameColors[index * 2];
                            Color frameColor2 =
                                model.frameColors[index * 2 + 1];

                            return buildContainer(
                              height,
                              width,
                              frameColor1,
                              frameColor2,
                              index == model.selectedIndex,
                            );
                          },
                          onPageChanged: (index) {
                            model.setSelectedIndex(index);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 32.r, 0, 22.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: model.previousPage,
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xffED4D86),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                            child: Text(
                              Provider.of<PostFrameColorProvider>(context)
                                  .buttonTexts,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: const Color(0xff1C1C1C),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: model.nextPage,
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffED4D86),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20.r, 0, 10.r),
              child: GestureDetector(
                onTap: () {
                  Color frameColor1 = model.selectedFrameColor1;
                  Color frameColor2 = model.selectedFrameColor2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectImageScreen(
                        height: height,
                        width: width,
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
                    child: Text(
                      'Next',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: const Color(0xffFFFFFC),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(double height, double width, Color color, Color color2,
          bool isSelected) =>
      Center(
        child: Container(
          height: height.h,
          width: width.w,
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              width: 8.w,
              gradient: LinearGradient(
                colors: [
                  isSelected ? color : color,
                  isSelected ? color2 : color2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      );
}
